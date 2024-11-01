// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {ERC20} from "@solmate/tokens/ERC20.sol";

contract SepoliaAddresses {
    // Deployer
    address public deployerAddress = 0x1C1F0657D9Dc486997ceB7c5599CA0e2515Ee81a;
    address public dev0Address = 0x7b7C993c3c283aaca86913e1c27DB054Ce5fA143;
    address public dev1Address = 0x7b7C993c3c283aaca86913e1c27DB054Ce5fA143;

    address public balancerVault = 0x0000000000000000000000000000000000000000;      // Padding

    // ERC20s
    ERC20 public WETH = ERC20(0x2c80132c3f2826640C2A52c1ecEF8949fedf2161);
    ERC20 public WBTC = ERC20(0xf194D8C635AC2E86239557e63C86c8bF59a7D6b0);
    ERC20 public USDT = ERC20(0x19CDAC308d47562F3565b2aaF02AD490936c7b07);
    ERC20 public USDC = ERC20(0x925209706343C5855d86752B7BCab18B208b9e56);

}
