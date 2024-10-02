// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ZoraMinter} from "../src/ZoraMinter.sol";
import {IZoraTimedSale} from "../src/interfaces/IZoraTimedSale.sol";
import {IZora1155} from "../src/interfaces/IZora1155.sol";

contract ZoraMinterTest is Test {
    ZoraMinter public zoraMinter;

    function setUp() public {
        address timedSaleAddress = address(0);
        zoraMinter = new ZoraMinter(IZoraTimedSale(timedSaleAddress));
    }

    function test_Deploy() public {
        IZora1155 zora1155 = IZora1155(address(0));
        zoraMinter.setupTokenAndSale(zora1155, "asdf", "asdf");
    }
}
