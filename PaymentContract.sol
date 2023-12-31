// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PaymentContract is ERC20 {
    constructor() ERC20("FastCoin", "FC") {}

    function processPayment(address recipient, uint256 amount) external {
        _transfer(msg.sender, recipient, amount);
    }
}
