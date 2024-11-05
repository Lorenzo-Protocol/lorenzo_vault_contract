# Lorenzo Contract

This repo contains the source code for the Lorenzo contract, and here you can find the deployments guide.

Follow the instructions below to deploy the contract.

<br>

## 1. Set up the environment

### 1.1 Environment variables

Copy the `.env.example` file to `.env` and set the environment variables, and fill in the RPC URLs, Etherscan API key, and deployer's private key.

```bash
cp .env.example .env
```

- For the RPC URLs, you should use a private RPC provider from [Quicknode](https://www.quicknode.com/), [Alchemy](https://www.alchemy.com/) or [Infura](https://www.infura.io/en) instead of the public ones in the `.env.example`. Otherwise, the deployment will be unstable or fail.
- For the Etherscan API key, you can get one for free from [Etherscan](https://etherscan.io/apis). It's used to verify the contracts on Etherscan.
- For the deployer's private key, it must be a ECDSA key starts with `0x` and is 64 characters long (66 in total with `0x` prefix).

### 1.2 Install dependencies

The project uses [Foundry](https://book.getfoundry.sh/) to build and deploy the contracts, which is a modern Ethereum development toolchain. It's based on Rust, so you need to install the Rust toolchain first. 

You can install the Foundry toolchain following the [official guide](https://book.getfoundry.sh/getting-started/installation).

## 1.3 Compile the contracts

After installing the dependencies, you can compile the contracts by running:

```bash
forge build
```

<br>

## 2. Deploy periphery contracts

Before deploying the core contracts, you need to deploy the periphery contracts, including the mock tokens (only on testnet), and a "deployer" contract that will be used to deploy the core contracts.

### 2.1 (**Testnet-Only**) Deploy mock tokens

Run the following command to deploy the mock tokens:

```bash
source .env && forge script test/mocks/MockToken.s.sol:MockTokenScript --evm-version london --slow --with-gas-price 3000000000 --broadcast --etherscan-api-key $ETHERSCAN_KEY --verify
```

In the deployment script [MockToken.s.sol](./test/mocks/MockToken.s.sol), the `WETH` contract is imported from solmate library and must be deployed for future usage, while the other token contracts like `MockWBTC`, `MockTBTC`, and `MockCBBTC` are just some mock tokens which will be used in Lorenzo vault. These token contracts can be found in [MockToken.sol](./src/mock/MockToken.sol), and you can remove them or replace with other mock tokens.

### 2.2 (**Testnet-Only**) Fill the address variables

The token addresses are stored in [SepoliaAddresses.sol](./src/constants/SepoliaAddresses.sol), you need to fill in the addresses for the mock tokens after deploying them. Meanwhile, the real token addresses on mainnet are stored in [MainnetAddresses.sol](./src/constants/MainnetAddresses.sol), and you can directly use them.


