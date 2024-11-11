// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {LinearBondedCurve} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise7_LinearBondedCurve is Test {
    LinearBondedCurve public curve;

    function setUp() public {
        curve = new LinearBondedCurve();
    }

    function test_sell() public {
        vm.deal(address(this), 1 ether);
        curve.buy{value: 1 ether}();
        vm.expectRevert();
        curve.sell(1000000000000000000);
    }
}
