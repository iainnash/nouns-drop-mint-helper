// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IZoraTimedSale {
    /// @dev This is used to pass in parameters for the `updateSale` function
    struct SalesConfigV2 {
        /// @notice Unix timestamp for the sale start
        uint64 saleStart;
        /// @notice The amount of time after the `minimumMarketEth` is reached until the secondary market can be launched
        uint64 marketCountdown;
        /// @notice The amount of ETH required to launch a market
        uint256 minimumMarketEth;
        /// @notice The ERC20Z name
        string name;
        /// @notice The ERC20Z symbol
        string symbol;
    }

    function setSaleV2(uint256 tokenId, SalesConfigV2 memory salesConfig) external;
}
