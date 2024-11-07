# Lorenzo Contract

This repo contains the source code for the Lorenzo contract, and here you can find the deployments guide.

Follow the instructions below to deploy the contracts.

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


### 1.3 Compile the contracts

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
source .env && forge script script/sepolia/DeployMockToken.s.sol:DeployMockTokenScript --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify # --evm-version london --with-gas-price 150000000000
```

In the deployment script [DeployMockToken.s.sol](./script/sepolia/DeployMockToken.s.sol), the `WETH` contract is imported from solmate library and must be deployed for future usage, while the other token contracts like `MockWBTC`, `MockTBTC`, and `MockCBBTC` are just some mock tokens which will be used in Lorenzo vault. These token contracts can be found in [MockToken.sol](./src/mock/MockToken.sol), and you can remove them or replace with other mock tokens.


### 2.2 (**Testnet-Only**) Fill the token address variables

The token addresses are stored in [SepoliaAddresses.sol](./test/resources/SepoliaAddresses.sol), you need to fill in the addresses for the mock tokens after deploying them. Meanwhile, the real token addresses on mainnet are stored in [MainnetAddresses.sol](./test/resources/MainnetAddresses.sol), and you can directly use them.


### 2.3 Fill the deployer address variables

The manager addresses are stored in [SepoliaAddresses.sol](./test/resources/SepoliaAddresses.sol) and [MainnetAddresses.sol](./test/resources/MainnetAddresses.sol), you need to fill them before deploying the `Deployer` contract. It contains:

- `dev0Address` & `dev1Address`: the addresses with some authority. In boring-vault, there are about 10 roles in total, including `MANAGER_ROLE`, `MINTER_ROLE`, `BURNER_ROLE`, `MANAGER_INTERNAL_ROLE`, `SOLVER_ROLE`, `OWNER_ROLE`, `MULTISIG_ROLE`, `STRATEGIST_MULTISIG_ROLE`, `STRATEGIST_ROLE`, `UPDATE_EXCHANGE_RATE_ROLE`. It's hard to manage them at first, so you can assign them to the same address before knowing how to manage them.
- `liquidPayoutAddress`: the address of the liquid payout contract.
- `uniswapV3NonFungiblePositionManager`: the address of the Uniswap V3 non-fungible position manager.

For convenience, you can just set all of these addresses (besides `deployerAddress`) to the same address, and change them later.


### 2.4 Deploy the `Deployer` contract

[Deployer.sol](./src/helper/Deployer.sol) is a contract that will be used to deploy the core contracts. Run the following command to deploy it:

```bash
# For testnet (Sepolia)
source .env && forge script script/sepolia/DeployDeployer.s.sol:DeployDeployerScript --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify --slow # --evm-version london --with-gas-price 150000000000

# For mainnet
source .env && forge script script/mainnet/DeployDeployer.s.sol:DeployDeployerScript --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify --slow # --evm-version london --with-gas-price 150000000000
```

After deploying the `Deployer` contract, you need to fill in the `deployerAddress` in [SepoliaAddresses.sol](./test/resources/SepoliaAddresses.sol) or [MainnetAddresses.sol](./test/resources/MainnetAddresses.sol) with the address of the `Deployer` contract.


<br>


## 3. Deploy the core contracts

### 3.1 Manage initial assets

To manage the initial assets which are allowed to be deposited or withdrawn, you need to fill in the `depositAssets` and `withdrawAssets` arrays in the deployment script at [DeployLizard.s.sol](./script/Sepolia/DeployLizard.s.sol#L76).


### 3.2 Deploy the `Lizard` core contract

The deployment script for the `Lizard` contract is [DeployLizard.s.sol](./script/Sepolia/DeployLizard.s.sol). Run the following command to deploy it:

```bash
# For testnet (Sepolia)
source .env && forge script script/sepolia/DeployLizard.s.sol:DeployLizardScript --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify --slow # --evm-version london --with-gas-price 150000000000

# For mainnet
source .env && forge script script/mainnet/DeployLizard.s.sol:DeployLizardScript --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify --slow # --evm-version london --with-gas-price 150000000000
```

The detail of the deployment can be found in at `./broadcast/DeployLizard.s.sol`, and the contract addresses are stored in `./deployments/LizardDeployment.json`.


### 3.3 Verify the contracts

Even though the deployment command contains the `--verify` flag, it's not always successful. If it fails, you can manually verify the contracts on Etherscan. For example, you can run the following command to verify the `RolesAuthority` contract on Sepolia:

```bash
source .env && forge v --rpc-url $SEPOLIA_RPC_URL --etherscan-api-key $ETHERSCAN_KEY --chain 11155111 <roles_authority_address> ./lib/solmate/src/auth/authorities/RolesAuthority.sol:RolesAuthority --constructor-args 0x
```

You will get a `guid` in the response, and you can use it to check the verification status of the contract on Etherscan. View the [Etherscan API Doc](https://docs.etherscan.io/api-endpoints/contracts#check-source-code-verification-status) for more details.
