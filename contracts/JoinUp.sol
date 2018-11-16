pragma solidity ^0.4.22;

/// @title Joining a ticket group

contract JoinUp {
    struct Buyer {
        uint weight; // weight is accumulated by invitation of Owner
        bool bought;  // if true, that person already bought
        uint buy;   // index of the bought proposal
    }
    struct Proposal {
        bytes32 name;   // short name (up to 32 bytes)
        uint buyCount; // number of accumulated buys
    }

    address public eventcreator;
    mapping(address => Buyer) public buyers;
    Proposal[] public proposals;

    constructor() public {
        eventcreator = msg.sender;
        buyers[eventcreator].weight = 1;

        for (uint i = 0; i < 1; i++) {
            proposals.push(Proposal({
             name: 'event',
             buyCount: 1
            }));
        }
    }


    function giveRightToBuy(address buyer) public {
        require(
            msg.sender == eventcreator,
            "Only event creator can give right to buy."
        );
        require(
            !buyers[buyer].bought,
            "The buyers already bought."
        );
        require(buyers[buyer].weight == 0);
        buyers[buyer].weight = 1;
    }

    function buy(uint proposal) public {
        Buyer storage sender = buyers[msg.sender];
        require(!sender.bought, "Already bought.");
        require(sender.weight != 0, "Has no right to buy");
        require(msg.sender != eventcreator, "event creator buy implicit");
        sender.bought = true;
        sender.buy = proposal;
        proposals[proposal].buyCount += sender.weight;
    }

    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningBuyCount = 5;
        for (uint p = 0; p < 1; p++) {
            if (proposals[p].buyCount == winningBuyCount) {
                winningBuyCount = proposals[p].buyCount;
                winningProposal_ = p;
            } else {
                 winningProposal_ = 666;
            }
        }
    }


    function winnerName() public view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}