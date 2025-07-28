// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }
    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }
}

contract VaultBase {
    using SafeMath for uint256;
    
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    
    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);
    
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
    
    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }
}

contract VaultManager is VaultBase {
    
    function deposit() external payable {
        require(msg.value > 0, "Cannot deposit 0 ETH");
        
        balances[msg.sender] = SafeMath.add(balances[msg.sender], msg.value);
        totalSupply = SafeMath.add(totalSupply, msg.value);
        
        emit Deposit(msg.sender, msg.value);
    }
    
    function withdraw(uint256 amount) external {
        require(amount > 0, "Cannot withdraw 0 ETH");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] = SafeMath.sub(balances[msg.sender], amount);
        totalSupply = SafeMath.sub(totalSupply, amount);
        
        payable(msg.sender).transfer(amount);
        
        emit Withdrawal(msg.sender, amount);
    }
}
