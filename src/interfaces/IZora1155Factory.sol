// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IZora1155Factory {
    struct RoyaltyConfiguration {
        uint32 royaltyMintSchedule;
        uint32 royaltyBPS;
        address royaltyRecipient;
    }

    function createContract(
        string calldata newContractURI,
        string calldata name,
        RoyaltyConfiguration memory defaultRoyaltyConfiguration,
        address payable defaultAdmin,
        bytes[] calldata setupActions
    ) external returns (address);
}
