// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {SnapShotToken} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise12_SnapShotToken is Test {
    SnapShotToken public snapShotToken;

    function setUp() public {
        snapShotToken = new SnapShotToken();
    }

    function test_UpdateCheckpoint() public {
        vm.deal(address(this), 1 ether);

        snapShotToken.buyToken{value: 1 ether}();

        assertEq(snapShotToken.balances(address(this)), 1);

        snapShotToken.transfer(address(this), 1);

        assertEq(snapShotToken.balances(address(this)), 2);
    }
}
