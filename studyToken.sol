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
