const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..');
for (const file of ['public/index.html', 'public/styles.css', 'public/app.js']) {
  if (!fs.existsSync(path.join(root, file))) throw new Error(`Missing ${file}`);
}
console.log('Activation verifier is ready for Vercel deployment.');
