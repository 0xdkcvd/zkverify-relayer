#!/bin/bash

echo "🚀 Starting zkVerify Relayer setup..."

# 1. Create project directory
mkdir -p zkverify-relayer && cd zkverify-relayer

# 2. Initialize Node.js project
echo "📦 Initializing Node.js project..."
npm init -y > /dev/null
npm install axios dotenv > /dev/null

# 3. Create .env file
echo "🔐 Creating .env file..."
cat <<EOF > .env
ZKVERIFY_API_KEY=your_api_key_here
EOF

# 4. Create submit-proof.js script
echo "📝 Creating submit-proof.js script..."
cat <<'EOF' > submit-proof.js
require('dotenv').config();
const axios = require('axios');
const fs = require('fs');

const toHex = (file) => Buffer.from(fs.readFileSync(file)).toString('hex');

const submitProof = async () => {
  const API_KEY = process.env.ZKVERIFY_API_KEY;
  const url = `https://relayer.zkverify.io/submit-proof/${API_KEY}`;

  const payload = {
    proof: toHex('proof.json'),
    public: toHex('public.json'),
    vk: toHex('vk.json'),
    proofType: 'GROTH16' // Change this if you use other proof types (e.g., ULTRAPLONG, RISC0)
  };

  try {
    const response = await axios.post(url, payload);
    console.log('✅ Proof submitted. Job ID:', response.data.jobId);
  } catch (err) {
    console.error('❌ Failed to submit proof:', err.response?.data || err.message);
  }
};

submitProof();
EOF

# 5. Create check-status.js script
echo "📝 Creating check-status.js script..."
cat <<'EOF' > check-status.js
require('dotenv').config();
const axios = require('axios');

const jobId = process.argv[2];
if (!jobId) {
  console.error('❗ Please provide a Job ID. Example: node check-status.js <jobId>');
  process.exit(1);
}

const checkStatus = async () => {
  const API_KEY = process.env.ZKVERIFY_API_KEY;
  const url = `https://relayer.zkverify.io/job-status/${API_KEY}/${jobId}`;
  try {
    const response = await axios.get(url);
    console.log('📊 Status:', response.data);
  } catch (err) {
    console.error('❌ Failed to check status:', err.response?.data || err.message);
  }
};

checkStatus();
EOF

echo "✅ Setup completed!"

echo ""
echo "📂 Project structure:"
echo " - zkverify-relayer/"
echo "   - .env"
echo "   - submit-proof.js"
echo "   - check-status.js"
echo ""
echo "📌 Next steps:"
echo "1. Replace 'your_api_key_here' in .env with your real zkVerify API key"
echo "2. Place your proof.json, public.json, and vk.json files in this directory"
echo "3. Submit proof with:"
echo "   node submit-proof.js"
echo "4. Check proof status with:"
echo "   node check-status.js <job_id>"
