pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract Delegator is AccessControl {
    bytes32 public constant DELEGATOR = keccak256("DELEGATOR_ROLE");
    bytes32 public constant OWNER = keccak256("OWNER");

    struct CreditProposal {
        uint8 totalVotes;
        uint8 votesFor;
    }

    uint8 threshold;
    address fund;

    mapping(address => CreditProposal) proposals; // Maps beneficiary to Proposal struct
    mapping(address => mapping(address => uint8)) votes; // 0 -> havent voted, 1 -> voted no, 2 -> voted yes

    event VoteCast(
        address indexed beneficiary,
        address indexed voter,
        bool approved
    );
    event LoanApproved(address indexed beneficiary);
    event LoanDenied(address indexed beneficiary);

    error AlreadyVoted(address beneficiary, address voter);
    error ProposalNotActive(address beneficiary);

    constructor(
        address _owner,
        address _fund,
        address[] memory _initialDelegators,
        uint8 _threshold
    ) {
        _grantRole(OWNER, _owner);
        threshold = _threshold;
        fund = _fund;

        for (uint8 i = 0; i < _initialDelegators.length; i++) {
            _grantRole(DELEGATOR, _initialDelegators[i]);
        }
    }

    modifier newVote(address loanId) {
        if (votes[loanId][msg.sender] > 0)
            revert AlreadyVoted(loanId, msg.sender);
        _;
    }

    function isApproved(address beneficiary) external view returns (bool) {
        CreditProposal memory prop = proposals[beneficiary];
        return prop.votesFor >= threshold;
    }

    function vote(address beneficiary, bool approved)
        external
        onlyRole(DELEGATOR)
        newVote(beneficiary)
    {
        CreditProposal memory prop = proposals[beneficiary];
        prop.totalVotes++;
        if (approved) prop.votesFor++;

        emit VoteCast(beneficiary, msg.sender, approved);
    }
}
