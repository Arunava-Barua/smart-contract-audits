// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {WinnerTakesAll} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise15_WinnerTakeAll is Test {
    WinnerTakesAll public game;
    address public owner = vm.addr(1);
    
    function setUp() public {
        vm.startPrank(owner);
        game = new WinnerTakesAll();
        vm.stopPrank();
    }

    function test_clearRounds() public {
        vm.txGasPrice(1);

        game.createNewRounds(2);

        vm.startPrank(owner);
        uint256 gasStartFirst = gasleft();
        game.clearRounds();
        uint256 gasEndFirst = gasleft();
        uint256 gasUsedFirst = (gasStartFirst - gasEndFirst) * tx.gasprice;
        console.log("First gas used: ", gasUsedFirst);
        vm.stopPrank();

        game.createNewRounds(10000);

        vm.startPrank(owner);
        uint256 gasStartSecond = gasleft();
        game.clearRounds();
        uint256 gasEndSecond = gasleft();
        uint256 gasUsedSecond = (gasStartSecond - gasEndSecond) * tx.gasprice;
        console.log("First gas used: ", gasUsedSecond);
        vm.stopPrank();
    }
}
