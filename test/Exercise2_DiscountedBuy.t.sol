// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {DiscountedBuy} from "../src/SolidityHackingWorkshopV8.sol";

contract Exercise2_DiscountedBuy is Test {
    DiscountedBuy public discountedBuy;

    function setUp() public {
        discountedBuy = new DiscountedBuy();
    }

    function test_buy() public {
        vm.deal(address(this), 3 ether);
        discountedBuy.buy{value: 1 ether}();
        console.log(discountedBuy.price());

        discountedBuy.buy{value: 0.5 ether}();
        console.log(discountedBuy.price());

        vm.expectRevert();

        // 333333333333333333 * 3 != 1 ether
        discountedBuy.buy{value: 333333333333333333}();
    }
}
