const readline = require('readline');
const { generateOTP, verifyOTP } = require('./src/expense/controller/authController');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const phoneNumber = '+918949362882';

// Mock request and response objects
const mockReqGenerate = { body: { phoneNumber } };
const mockResGenerate = {
  status: (code) => ({
    json: (response) => {
      console.log(`Generate OTP Response Code: ${code}`, response);
      if (code === 200) {
        rl.question('Enter the OTP sent to your phone: ', (otp) => {
          const mockReqVerify = { body: { phoneNumber, otp } };
          verifyOTP(mockReqVerify, mockResVerify);
        });
      } else {
        rl.close();
      }
    }
  })
};

const mockResVerify = {
  status: (code) => ({
    json: (response) => {
      console.log(`Verify OTP Response Code: ${code}`, response);
      rl.close();
    }
  })
};

// Step 1: Generate OTP
generateOTP(mockReqGenerate, mockResGenerate);
