# zkVerify Relayer

This repository contains a simple one-click setup script to help you quickly configure a Node.js project for submitting zero-knowledge proofs (ZK proofs) to the zkVerify Relayer API.

---

## Features

- Initializes a Node.js project with required dependencies (`axios` and `dotenv`)
- Creates `.env` file to store your zkVerify API key
- Generates two scripts:
  - `submit-proof.js` to submit your proof files to zkVerify Relayer
  - `check-status.js` to check the verification status of submitted proofs
- Streamlines proof submission and status checking workflow

---

## Prerequisites

- Node.js (v14 or later recommended)
- Proof files generated by Noir (`proof.json`, `public.json`, `vk.json`)

---

## Getting Started

### 1. Download and run the setup script

Save the setup script as `zkverify-setup.sh` and run it:

```bash
bash zkverify-setup.sh
