// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {WETH} from "@solmate/tokens/WETH.sol";
import {MockWBTC, MockTBTC, MockCBBTC} from "src/mock/MockToken.sol";
import "forge-std/Script.sol";

/**
 *  source .env && forge script script/sepolia/DeployMockToken.s.sol:DeployMockTokenScript --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify # --evm-version london --with-gas-price 150000000000
 */
contract DeployMockTokenScript is Script {
    uint256 public privateKey;

    function setUp() external {
        privateKey = vm.envUint("SUPER_DEPLOYER");
        vm.createSelectFork("sepolia");
    }

    function run() external {
        vm.startBroadcast(privateKey);
        new WETH();
        new MockWBTC();
        new MockTBTC();
        new MockCBBTC();
    }
}
