// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IZora1155 {
    function setupNewToken(
        string memory tokenURI,
        uint256 maxSupply
    ) external returns (uint256 tokenId);
    function nextTokenId() external view returns (uint256);
    function callSale(
        uint256 tokenId,
        address salesConfig,
        bytes memory data
    ) external;
    function addPermission(
        uint256 tokenId,
        address user,
        uint256 permissionBits
    ) external;
    function grantRole(bytes32, address) external;
    function hasRole(bytes32, address) external view returns (bool);
    function PERMISSION_BIT_ADMIN() external returns (uint256);
    function PERMISSION_BIT_MINTER() external returns (uint256);
}
