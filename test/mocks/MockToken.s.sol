// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {WETH} from "@solmate/tokens/WETH.sol";
import {MockWBTC, MockTBTC, MockCBBTC} from "src/mock/MockToken.sol";
import "forge-std/Script.sol";

/**
 * source .env && forge script test/mocks/MockToken.s.sol:MockTokenScript --evm-version london --slow --with-gas-price 3000000000 --broadcast --etherscan-api-key $ETHERSCAN_KEY --verify
 */
contract MockTokenScript is Script {
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
