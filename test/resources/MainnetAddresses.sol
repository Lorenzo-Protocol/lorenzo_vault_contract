// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {ERC20} from "@solmate/tokens/ERC20.sol";

contract MainnetAddresses {
    // Deployer
    address public deployerAddress = 0x0000000000000000000000000000000000000000;
    address public dev0Address = 0x0000000000000000000000000000000000000000;
    address public dev1Address = 0x0000000000000000000000000000000000000000;
    address public liquidPayoutAddress = 0x0000000000000000000000000000000000000000;

    address public balancerVault = 0x0000000000000000000000000000000000000000; // Padding

    // ERC20s
    ERC20 public WETH = ERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    ERC20 public WBTC = ERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);
    ERC20 public TBTC = ERC20(0x18084fbA666a33d37592fA2633fD49a74DD93a88);
    ERC20 public cbBTC = ERC20(0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf);
    ERC20 public USDT = ERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    ERC20 public USDC = ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    ERC20 public DAI = ERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);

    // Uniswap V3
    address public uniswapV3NonFungiblePositionManager = 0x0000000000000000000000000000000000000000;
}