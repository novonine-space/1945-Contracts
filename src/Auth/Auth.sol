// SPDX-License-Identifier: AGPL-3.0-only
// Copyright (C) Centrifuge 2020, based on MakerDAO dss https://github.com/makerdao/dss
pragma solidity ^0.8.13;

contract Auth {
    mapping (address => bool) public wards;
    
    event Rely(address indexed usr);
    event Deny(address indexed usr);

    function rely(address usr) external auth {
        wards[usr] = true;
        emit Rely(usr);
    }
    function deny(address usr) external auth {
        wards[usr] = false;
        emit Deny(usr);
    }

    modifier auth {
        require(wards[msg.sender], "not-authorized");
        _;
    }

}