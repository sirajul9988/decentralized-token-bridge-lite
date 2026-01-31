// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeVault is Ownable {
    uint256 public nextNonce;
    
    event Locked(address indexed user, uint256 amount, uint256 nonce);

    constructor() Ownable(msg.sender) {}

    function lock(address token, uint256 amount) external {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        emit Locked(msg.sender, amount, nextNonce);
        nextNonce++;
    }

    function emergencyWithdraw(address token) external onlyOwner {
        uint256 balance = IERC20(token).balanceOf(address(this));
        IERC20(token).transfer(owner(), balance);
    }
}
