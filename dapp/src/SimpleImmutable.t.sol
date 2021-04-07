// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import "ds-test/test.sol";

import "./SimpleImmutable.sol";

contract SimpleImmutableTest is DSTest {
    function test_bytecode() public {
        address ones  = address(new SimpleImmutable(uint256(-1)));
        address zeros = address(new SimpleImmutable(0));

        assembly {
            let ones_size  := extcodesize(ones)
            let zeros_size := extcodesize(zeros)
            if not(eq(ones_size, zeros_size)) {
                // If the bytecode sizes aren't equal, our assumptions are violated,
                // and we cannot proceed.
                invalid()
            }
        }
    }
}
