// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./OrderProcessing.sol";

contract RewardsAndLoyalty {
    address public owner;
    mapping(address => uint256) LoyaltyPoints;
    uint256 PointsPerTransaction = 10;
    OrderProcessing public orderContract;

    event LoyaltyTokensCredited(address indexed user, uint256 amount);
    event LoyaltyPointsUsed(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(address _orderContractAddress) {
        owner = msg.sender;
        orderContract = OrderProcessing(_orderContractAddress);
    }

    function creditLoyaltyTokens(address user) external  {
        require(orderContract.getTotalPrice() > 0, "No Transaction Value");
        uint256 orderAmount = orderContract.getTotalPrice();
        uint256 points = orderAmount * PointsPerTransaction;
        LoyaltyPoints[user] += points;
        //tokenContract.transfer(user, amount);
        emit LoyaltyTokensCredited(user, orderAmount);
    }

    function ExtractPoints(address user, uint256 points) external  {
        require(LoyaltyPoints[user] >= points, "Not enough loyalty points");
        LoyaltyPoints[user] -= points;
        emit LoyaltyPointsUsed(user, points);
    }

    function getPoints(address user) public view returns (uint256) {
        return LoyaltyPoints[user];
    }
}