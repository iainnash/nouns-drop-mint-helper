// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {IZoraTimedSale} from "./interfaces/IZoraTimedSale.sol";
import {IZora1155} from "./interfaces/IZora1155.sol";

contract ZoraMinter {
    IZoraTimedSale immutable timedSale;

    error AddressCannotBeZero();

    constructor(IZoraTimedSale timedSale_) {
        if (address(timedSale_) == address(0)) {
            revert AddressCannotBeZero();
        }
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
            !targetContract.isAdminOrRole(
                msg.sender,
                0,
                targetContract.PERMISSION_BIT_ADMIN()
            )
        ) {
            revert UserNeedsToBeAdmin();
        }

        uint256 nextTokenId = targetContract.nextTokenId();
        uint256 tokenId = targetContract.setupNewToken(
            tokenURI,
            type(uint256).max
        );
        targetContract.addPermission(
            0,
            address(timedSale),
            targetContract.PERMISSION_BIT_MINTER()
        );
        targetContract.callSale(
            tokenId,
            address(timedSale),
            abi.encodeWithSelector(
                IZoraTimedSale.setSaleV2.selector,
                nextTokenId,
                IZoraTimedSale.SalesConfigV2({
                    saleStart: 0,
                    marketCountdown: 24 hours * 3,
                    minimumMarketEth: 0.111111 ether,
                    name: name,
                    symbol: name
                })
            )
        );
    }
}
