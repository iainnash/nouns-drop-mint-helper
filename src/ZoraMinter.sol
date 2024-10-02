// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {IZoraTimedSale} from "./interfaces/IZoraTimedSale.sol";
import {IZora1155} from "./interfaces/IZora1155.sol";

contract ZoraMinter {
    IZoraTimedSale immutable timedSale;

    constructor(IZoraTimedSale timedSale_) {
        timedSale = timedSale_;
    }

    error UserNeedsToBeAdmin();

    function setupTokenAndSale(
        IZora1155 targetContract,
        string memory tokenURI,
        string memory name
    ) external {
        // TODO(): validate ownership from calling contract
        if (
            !targetContract.hasRole(
                targetContract.PERMISSION_BIT_ADMIN(),
                msg.sender
            )
        ) {
            revert UserNeedsToBeAdmin();
        }

        uint256 nextTokenId = targetContract.nextTokenId();
        uint256 tokenId = targetContract.setupNewToken(
            tokenURI,
            type(uint256).max
        );
        targetContract.grantRole(
            targetContract.PERMISSION_BIT_MINTER(),
            address(timedSale)
        );
        targetContract.callSale(
            tokenId,
            address(timedSale),
            abi.encodeWithSelector(
                IZoraTimedSale.setSaleV2.selector,
                IZoraTimedSale.SalesConfigV2({
                    saleStart: 0,
                    marketCountdown: 24 hours * 3,
                    name: name,
                    symbol: name
                })
            )
        );
    }
}
