// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {ERC20} from "@solmate/tokens/ERC20.sol";

contract MockWBTC is ERC20 {
    constructor() ERC20("Wrapped BTC", "WBTC", 8) {
        _mint(msg.sender, 1_000_000 * 10 ** decimals);
    }
}

contract MockTBTC is ERC20 {
    constructor() ERC20("tBTC v2", "tBTC", 18) {
        _mint(msg.sender, 1_000_000 * 10 ** decimals);
    }
}

contract MockCBBTC is ERC20 {
    constructor() ERC20("Coinbase Wrapped BTC", "cbBTC", 8) {
        _mint(msg.sender, 1_000_000 * 10 ** decimals);
    }
}