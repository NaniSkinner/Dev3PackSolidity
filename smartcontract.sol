// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserProfile {
    // User struct 
    struct User {
        string name;
        uint256 age;
        string email;
        bool isRegistered;
        uint256 registrationTimestamp;
    }
    
    // State variable to store users with public getter function
    mapping(address => User) public users;
    
    // Register function
    function register(string memory _name, uint256 _age, string memory _email) public {
        // Validate that user cannot register twice
        require(!users[msg.sender].isRegistered, "User is already registered");
        
        // Store user data
        users[msg.sender] = User({
            name: _name,
            age: _age,
            email: _email,
            isRegistered: true,
            registrationTimestamp: block.timestamp
        });
    }
    
    // Update profile function
    function updateProfile(string memory _name, uint256 _age, string memory _email) public {
        require(users[msg.sender].isRegistered, "User is not registered");
        
        users[msg.sender].name = _name;
        users[msg.sender].age = _age;
        users[msg.sender].email = _email;
    }
    
    // View function to fetch user info
    function getProfile(address _userAddress) public view returns (
        string memory name,
        uint256 age,
        string memory email,
        bool isRegistered,
        uint256 registrationTimestamp
    ) {
        User memory user = users[_userAddress];
        return (
            user.name,
            user.age,
            user.email,
            user.isRegistered,
            user.registrationTimestamp
        );
    }
}
