# PropertyTrader Smart Contract
This is the project consisting of a smart contract in Solidity, called PropertyTrader, and a web-based JavaScript script to complement it using the Web3 library to integrate it with MetaMask. In this smart contract, properties can be added, updated, purchased, and sold. The JavaScript code communicates with the Ethereum blockchain for such actions through a web interface.

## Function
>>mintToken : Function to mint new tokens (only owner).
>>
>>rewardTokens : Function to transfers tokens from the sender to a specified address and records the reward.
>>
>>burnTokens : Function to burns tokens from the sender's balance.
>>
>>checkRewardHistory : Function to returns the total rewards received by the sender.
>>
>>viewTotalRewards : Function to returns the total amount of tokens rewarded, viewable only by the instructor.


### Description
This is a project consisting of a Solidity smart contract called `PropertyTrader` and a frontend JavaScript application that connects with MetaMask through Web3.js. It provides a smart contract for running property management, through which users can create, update, buy, and sell properties on the Ethereum blockchain. On top of this, the JavaScript code provides user interaction through a web interface, thus having nice integration with MetaMask to perform blockchain transactions.

#### Getting Started

##### Executing program
#### solidity
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StudyToken is ERC20 {
    address private instructor;
    uint256 private totalRewards;

    mapping(address => uint256) private rewards;

    modifier onlyInstructor() {
        require(
            msg.sender == instructor,
            "Only the instructor can perform this action"
        );
        _;
    }

    constructor(uint256 initialSupply) ERC20("StudyToken", "STK") {
        _mint(msg.sender, initialSupply);
        instructor = msg.sender;
    }

    function mintTokens(uint256 amount) external onlyInstructor {
        require(amount > 0, "Mint amount must be greater than zero");
        _mint(instructor, amount);
    }

    function rewardTokens(address to, uint256 amount) public {
        require(to != address(0), "Cannot reward to the zero address");
        require(amount > 0, "Reward amount must be greater than zero");
        require(
            balanceOf(msg.sender) >= amount,
            "Insufficient balance to reward"
        );

        _transfer(msg.sender, to, amount);
        rewards[msg.sender] += amount;
        totalRewards += amount;
    }

    function burnTokens(uint256 amount) public {
        require(amount > 0, "Burn amount must be greater than zero");
        require(
            balanceOf(msg.sender) >= amount,
            "Insufficient balance to burn"
        );

        _burn(msg.sender, amount);
    }

    function checkRewardHistory() public view returns (uint256) {
        return rewards[msg.sender];
    }

    function viewTotalRewards() public view onlyInstructor returns (uint256) {
        return totalRewards;
    }
}
```


###### Author
Manish Kumar 
(https://www.linkedin.com/in/manish-kmr/)

###### License
This project is licensed under the MIT License
