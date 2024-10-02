// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ZoraMinter} from "../src/ZoraMinter.sol";
import {IZoraTimedSale} from "../src/interfaces/IZoraTimedSale.sol";

contract ZoraMinterScript is Script {
    ZoraMinter public zoraMinter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        zoraMinter = new ZoraMinter(IZoraTimedSale(address(0)));

        vm.stopBroadcast();
    }
}
