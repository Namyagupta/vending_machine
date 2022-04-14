//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VendingMachine{
    address public owner;
    mapping(address => uint) public donutBalances;

    constructor(){
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only owner can restock the donuts!");
        donutBalances[address(this)]+= amount;
    }

    function purchase(uint amount) public payable{
        require(msg.value >= amount * 0.5 ether, "You must pay atleast 2 ether per donut");
        require(donutBalances[address(this)] >= amount, "OOPS! Not enough donuts");
        donutBalances[address(this)] -= amount;
        donutBalances[address(msg.sender)] += amount;
    }
}