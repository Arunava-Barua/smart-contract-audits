// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {SimpleToken} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise6_SimpleToken is Test {
    SimpleToken public simpleToken;

    function setUp() public {
        simpleToken = new SimpleToken();
    }

    function test_SendToken() public {
        address recipient = vm.addr(1);
        assertEq(simpleToken.balances(address(this)), 1000 ether);

        simpleToken.sendToken(recipient, -100 ether);

        assertEq(simpleToken.balances(address(this)), 1100 ether);
        assertEq(simpleToken.balances(recipient), -100 ether);
    }
}
