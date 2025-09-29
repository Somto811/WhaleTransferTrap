# Whale Transfer Detector Trap

A custom Drosera trap that monitors large ERC20 token transfers (e.g., >100k tokens) on the Ethereum blockchain.

---

## 📦 Prerequisites

1. Install sudo and other pre-requisites :
```bash
apt update && apt install -y sudo && sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl ufw iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y
```
3. Install environment requirements:
Drosera Cli
```bash
curl -L https://app.drosera.io/install | bash
source /root/.bashrc
droseraup
```
Foundry cli
```bash
curl -L https://foundry.paradigm.xyz | bash
source /root/.bashrc
foundryup
```
Bun
```bash
curl -fsSL https://bun.sh/install | bash
source /root/.bashrc
```
   

## ⚙️ Setup

Clone this repository

```bash
git clone https://github.com/Somto811/WhaleTransferTrap.git


cd WhaleTransferTrap
```
Compile contract

```bash
forge build
```
Whitelist wallet address
```bash
nano drosera.toml
# Put your EVM public address funded with hoodi ETH in whitelist
e.g ["0xedj..."]  
```
Deploy the trap
```bash
DROSERA_PRIVATE_KEY=xxx drosera apply
```
 Replace xxx with your EVM wallet privatekey (Ensure it's funded with Hoodi ETH, you can claim 1E from hoodifaucet.io)




