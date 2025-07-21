# UserProfile Smart Contract

A simple Solidity smart contract that allows users to register and manage their profile information on the blockchain.

## Features

- **User Registration**: Register with name, age, and email
- **Profile Updates**: Update existing profile information
- **Profile Retrieval**: View any user's profile data
- **Duplicate Prevention**: Users cannot register twice
- **Timestamp Tracking**: Records when each user registered

## Functions

- `register(name, age, email)` - Register a new user profile
- `updateProfile(name, age, email)` - Update existing profile
- `getProfile(userAddress)` - Retrieve user profile information
- `users(userAddress)` - Public getter for user data

## Usage

Deploy the contract and call the functions with your profile information. Users are identified by their wallet address.
