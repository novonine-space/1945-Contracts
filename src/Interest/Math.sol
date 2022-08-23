// SPDX-License-Identifier: AGPL-3.0-only
// Copyright (C) 2018 Rain <rainbreak@riseup.net>
pragma solidity ^0.8.13;

contract Math {
    uint256 constant ONE = 10 ** 27;


    function rmul(uint x, uint y) public pure returns (uint z) {
        z = (x * y) / ONE;
    }

    function rdiv(uint x, uint y) public pure returns (uint z) {
        require(y > 0, "division by zero");
        z = ((x * ONE) +  (y / 2)) / y;
    }

    function rdivup(uint x, uint y) internal pure returns (uint z) {
        require(y > 0, "division by zero");
        // always rounds up
        z = ((x * ONE) + (y - 1)) / y;
    }


}