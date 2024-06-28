
const { Strategy: JwtStrategy, ExtractJwt } = require('passport-jwt');
const passport = require('passport');
const pool = require('../../db');
const queries = require('./queries');

const opts = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: 'your_jwt_secret', // Use an environment variable for the secret in production
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

module.exports = passport;
