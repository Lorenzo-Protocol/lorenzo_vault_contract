// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {ERC20} from "@solmate/tokens/ERC20.sol";
import {WETH} from "@solmate/tokens/WETH.sol";
import "forge-std/Script.sol";

/**
 *  source .env && forge script test/mocks/MockToken.s.sol:MockTokenScript --evm-version london --slow --broadcast --etherscan-api-key $ETHERSCAN_KEY --verify
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
        new MockToken("Wrapped BTC", "WBTC", 8);
        new MockToken("Tether USD", "USDT", 6);
        new MockToken("USDC", "USDC", 6);
    }

}

contract MockToken is ERC20 {
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) ERC20(_name, _symbol, _decimals) {
        _mint(msg.sender, 1_000_000 * 10 ** decimals);
    }
}
