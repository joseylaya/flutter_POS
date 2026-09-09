const { noStore, sessionUser } = require('../lib/auth');

module.exports = (req, res) => {
  noStore(res);
  const username = sessionUser(req);
  if (!username) return res.status(401).json({ authenticated: false });
  return res.status(200).json({ authenticated: true, username });
};
