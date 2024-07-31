require('dotenv').config();

const pool = require('../../../db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const queries = require('../queries');
const axios = require('axios');


const { authenticator } = require('otplib');
const twilio = require('twilio');


const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

const otpStore = {}; // In-memory store for OTPs
const secretOrKey = process.env.SECRET_JWT;


const googleUser = async (req, res) => {
  const { access_token } = req.body;
  try {
    // Fetch user info from Google Userinfo endpoint
    const response = await axios.get(`https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token=${access_token}`);
    const profile = response.data;

    // Check if user exists in your database by Google ID
    let user = await pool.query(queries.findUserByGoogleId, [profile.id]);

    if (user.rows.length === 0) {
      // Create new user if not exists
      const result = await pool.query(queries.createUser, [profile.id, profile.name, profile.email]);
      user = result.rows[0];
    } else {
      user = user.rows[0];
    }

    // Generate JWT
    const token = jwt.sign({ id: user.id }, 'your_jwt_secret', { expiresIn: '1h' });

    res.json({ id: user.id, token, name: user.name });
  } catch (error) {
    console.error(error);
    res.status(400).json({ error: 'Token verification failed' });
  }
}  





const registerUser = async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const result = await pool.query(queries.registerUser, [name, email, hashedPassword || null]);
    
    // Assuming result.rows[0] contains the newly registered user's data
    const newUser = result.rows[0];
    
    // Generate JWT token
    const payload = { id: newUser.id, username: newUser.username };
    const token = jwt.sign(payload, secretOrKey, { expiresIn: '1h' });
    
    // Return token and user ID
    res.status(201).json({ token, id: newUser.id, name: newUser.name});
  } catch (err) {
    console.error('Error registering user:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};


const loginUser = async (req, res) => {
  const { email, password } = req.body;
  try {
    const result = await pool.query(queries.loginUser, [email]);
    if (result.rows.length > 0) {
      const user = result.rows[0];
      console.log('Stored hashed password:', user.password);
      const isMatch = await bcrypt.compare(password, user.password);
      console.log('Password comparison result:', isMatch);
      if (isMatch) {
        const payload = { id: user.id, username: user.username };
        const token = jwt.sign(payload, secretOrKey, { expiresIn: '1h' });
        res.status(200).json({ token, id: user.id, name: user.name });
      } else {
        res.status(400).json({ error: 'Password incorrect' });
      }
    } else {
      res.status(404).json({ error: 'User not found' });
    }
  } catch (err) {
    console.error('Error logging in user:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// Generate OTP
const generateOTP = async (req, res) => {
  const { phoneNumber } = req.body;
  try {
    const otp = authenticator.generate(phoneNumber);
    const timestamp = new Date().getTime();
    otpStore[phoneNumber] = { otp, timestamp };
    console.log(`Generated OTP: ${otp} for phoneNumber: ${phoneNumber}`); // Debugging log
    console.log(`otpStore:`, otpStore); // Debugging log
    await sendOTPSMS(phoneNumber, otp);
    res.status(200).json({ message: 'OTP sent to your phone' });
  } catch (err) {
    console.error('Error generating OTP:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// Send OTP via SMS
const sendOTPSMS = async (phoneNumber, otp) => {
  await client.messages.create({
    body: `Your OTP code is ${otp}`,
    from: process.env.TWILIO_PHONE_NUMBER,
    to: phoneNumber,
  });
};

// Verify OTP
const verifyOTP = async (req, res) => {
  const { phoneNumber, otp } = req.body;
  console.log('Request Body:', req.body);
  console.log('Received phoneNumber:', phoneNumber);
  console.log('Received OTP:', otp);
  console.log('Current otpStore:', otpStore);
  try {
    if (otpStore[phoneNumber]) {
      const { otp: storedOTP, timestamp } = otpStore[phoneNumber];
      console.log(`Stored OTP: ${storedOTP}, Timestamp: ${timestamp}`);
      const currentTime = Date.now();
      console.log(`Current Time: ${currentTime}, OTP Expiry Duration: ${process.env.OTP_EXPIRY_DURATION}`);
      
      if (currentTime - timestamp > process.env.OTP_EXPIRY_DURATION) {
        delete otpStore[phoneNumber]; // Clear expired OTP
        res.status(400).json({ error: 'OTP expired' });
      } else if (storedOTP === otp) {
        delete otpStore[phoneNumber]; // Clear OTP after verification
        res.status(200).json({ message: 'OTP verified successfully' });
      } else {
        res.status(400).json({ error: 'Invalid OTP' });
      }
    } else {
      res.status(400).json({ error: 'No OTP found for this phone number' });
    }
  } catch (err) {
    console.error('Error verifying OTP:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};



module.exports = {
  registerUser,
  loginUser,
  generateOTP,
  verifyOTP,
  googleUser
};
