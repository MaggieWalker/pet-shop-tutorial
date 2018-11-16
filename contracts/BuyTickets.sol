pragma solidity ^0.4.0;

contract buyTickets {
    address[2] public buyerAddresses;
    // mapping (address => bool) private nullBuyer;
    
    function add(uint ticketId) public returns (uint) {
        require (ticketId >= 0 && ticketId <= 2);
        buyerAddresses[ticketId] = msg.sender;
        return ticketId;
    }
    function getBuyers() public view returns (address[2]) {
        return buyerAddresses;
    }
    
    function completeTransaction() public view returns (address[2]) {
        address firstPerson = buyerAddresses[0];
        address secondPerson = buyerAddresses[1];
        require(firstPerson != address(0) && secondPerson != address(0));
            return buyerAddresses;
        }
    }