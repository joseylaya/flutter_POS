const { clearSessionCookie, noStore } = require('../lib/auth');

module.exports = (req, res) => {
  noStore(res);
  if (req.method !== 'POST') {
    res.setHeader('Allow', 'POST');
    return res.status(405).json({ error: 'Method not allowed.' });
  }
  clearSessionCookie(res);
  return res.status(200).json({ authenticated: false });
};
