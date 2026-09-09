const {
  createSession,
  noStore,
  requiredEnv,
  safeEqual,
  setSessionCookie,
} = require('../lib/auth');

module.exports = (req, res) => {
  noStore(res);
  if (req.method !== 'POST') {
    res.setHeader('Allow', 'POST');
    return res.status(405).json({ error: 'Method not allowed.' });
  }
  const { username = '', password = '' } = req.body || {};
  const valid =
    safeEqual(username, requiredEnv('ADMIN_USERNAME')) &&
    safeEqual(password, requiredEnv('ADMIN_PASSWORD'));
  if (!valid) {
    return res.status(401).json({ error: 'Invalid username or password.' });
  }
  setSessionCookie(res, createSession(username));
  return res.status(200).json({ authenticated: true });
};
