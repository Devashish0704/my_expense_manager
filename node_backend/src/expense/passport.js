require('dotenv').config();

const { Strategy: JwtStrategy, ExtractJwt } = require('passport-jwt');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const passport = require('passport');
const pool = require('../../db'); // Assuming you have a database configuration
const queries = require('./queries'); // Your queries file

// const googleClientId = process.env.GOOGLE_CLIENT_ID;
// const googleClientSecret = process.env.GOOGLE_CLIENT_SECRET;
const jwtSecret = process.env.SECRET_JWT;


// JWT Strategy configuration
const opts = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: jwtSecret, 
};

passport.use(
  new JwtStrategy(opts, async (jwt_payload, done) => {
    try {
      const result = await pool.query(queries.getUserById, [jwt_payload.id]);
      if (result.rows.length > 0) {
        return done(null, result.rows[0]);
      } else {
        return done(null, false);
      }
    } catch (err) {
      return done(err, false);
    }
  })
);

// Google OAuth 2.0 Strategy configuration
// passport.use(
//   new GoogleStrategy(
//     {
//       clientID: process.env.GOOGLE_CLIENT_ID_WEB,
//       clientSecret: process.env.GOOGLE_CLIENT_SECRET,
//       callbackURL: 'http://localhost:3000/api/auth/google/callback', // Replace with your callback URL
//       scope: ['profile', 'email'] // Add the desired scopes here

//     },
//     async (accessToken, refreshToken, profile, done) => {
//       try {
//         console.log('Google OAuth strategy callback initiated');
//         // Check if user exists in your database by Google ID
//         let user = await pool.query(queries.findUserByGoogleId, [profile.id]);

//         if (user.rows.length === 0) {
//           // Create new user if not exists
//           const result = await pool.query(queries.createUser, [profile.id, profile.displayName, profile.emails[0].value]);
//           user = result.rows[0];
//         } else {
//           user = user.rows[0];
//         }

//         console.log('User authenticated via Google OAuth:', user);
//         return done(null, user);
//       } catch (err) {
//         console.error('Google OAuth error:', err);
//         return done(err, false);
//       }
//     }
//   )
// );


module.exports = passport;
