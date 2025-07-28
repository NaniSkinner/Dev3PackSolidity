// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract VulnerablePiggyBank {
    address public owner;
    //added ; to the end of the constructor
    constructor() { owner = msg.sender; }
    function deposit() public payable {}
    function withdraw() public { payable(msg.sender).transfer(address(this).balance); }
    
    // Attack function demonstrating the vulnerability
    function attack() public { 
        // Anyone can call this and steal all funds!
        withdraw();
    }
}

// SECURE VERSION - Fixed vulnerabilities
contract SecurePiggyBank {
    address public owner;
    mapping(address => uint256) public balances;
    
    constructor() { 
        owner = msg.sender; 
    }
    
    function deposit() public payable {
        require(msg.value > 0, "Must deposit some Ether");
        balances[msg.sender] += msg.value;
    }
    
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(address(this).balance > 0, "No funds to withdraw");
        
        uint256 amount = address(this).balance;
        payable(owner).transfer(amount);
    }
    
    function withdrawMyDeposit() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No funds to withdraw");
        
        balances[msg.sender] = 0; // Clear balance first (prevents reentrancy)
        payable(msg.sender).transfer(amount);
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function getMyBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}