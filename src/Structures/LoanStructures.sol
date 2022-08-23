// SPDX-License-Identifier: ISC

// license: MIT

pragma solidity ^0.8.13;

contract LoanStructures {
    uint256 public constant PERCENT_DENOMINATOR = 10**10;

    struct OutstandingLoan {
        uint256 amount;
        uint256 time;
    }

    enum LoanPurpose {
        FOOD,
        WATER,
        HEALTH,
        SCHOOL,
        BILLS,
        TRANSPORT,
        OTHER
    }

    struct Tranche {
        uint256 percent;
        uint256 weight;
    }

    struct Loan {
        uint256 start;
        uint256 deadline;
        uint256 id;
        address borrower;
        uint256 totalPaid;
        LoanPurpose purpose;
        bool closed;
        uint256 amount;
    }

    struct LoanRequest {
        uint256 amount;
        uint256 amountFilled;
        address borrower;
        int256 creditScore;
        uint256 duration;
        LoanPurpose purpose;
    }
}
