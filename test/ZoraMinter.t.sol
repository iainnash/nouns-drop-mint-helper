// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ZoraMinter} from "../src/ZoraMinter.sol";
import {IZoraTimedSale} from "../src/interfaces/IZoraTimedSale.sol";
import {IZora1155} from "../src/interfaces/IZora1155.sol";
import {IZora1155Factory} from "../src/interfaces/IZora1155Factory.sol";

contract ZoraMinterTest is Test {
    ZoraMinter public zoraMinter;

    function setUp() public {
        address timedSaleAddress = address(
            0x777777722D078c97c6ad07d9f36801e653E356Ae
        );
        zoraMinter = new ZoraMinter(IZoraTimedSale(timedSaleAddress));
    }

    function test_Deploy() public {
        IZora1155Factory factory = IZora1155Factory(
            address(0x777777C338d93e2C7adf08D102d45CA7CC4Ed021)
        );
        bytes[] memory setupActions = new bytes[](0);
        IZora1155 zora1155 = IZora1155(
            factory.createContract(
                "asdf",
                "asdf",
                IZora1155Factory.RoyaltyConfiguration({
                    royaltyMintSchedule: 0,
                    royaltyBPS: 0,
                    royaltyRecipient: address(this)
                }),
                payable(address(this)),
                setupActions
            )
        );
        // Grant admin role to helper to setup sale.
        zora1155.addPermission(
            0,
            address(zoraMinter),
            zora1155.PERMISSION_BIT_ADMIN()
        );
        zoraMinter.setupTokenAndSale(zora1155, "asdf", "asdf");
    }

    receive() external payable {}
}
