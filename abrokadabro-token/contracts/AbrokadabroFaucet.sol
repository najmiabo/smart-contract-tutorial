// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AbrokadabroFaucet {
    IERC20 public token;
    address public owner;
    uint256 public amountPerDay = 5 * 10**18; // 5 tokens (assuming 18 decimals)
    uint256 public lockTime = 1 minutes;
    mapping(address => uint256) private lastAccessTime;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
        owner = msg.sender;
    }

    function requestTokens() external {
        require(canReceiveTokens(msg.sender), "You can only receive tokens once per minute");
        require(token.balanceOf(address(this)) >= amountPerDay, "Faucet is empty");
        lastAccessTime[msg.sender] = block.timestamp;
        require(token.transfer(msg.sender, amountPerDay), "Token transfer failed");
    }

    function canReceiveTokens(address _user) public view returns (bool) {
        return lastAccessTime[_user] + lockTime < block.timestamp;
    }

    function withdrawTokens(uint256 _amount) external {
        require(msg.sender == owner, "Only contract owner can withdraw");
        require(token.balanceOf(address(this)) >= _amount, "Insufficient balance");
        require(token.transfer(msg.sender, _amount), "Token transfer failed");
    }

    function changeOwner(address newOwner) external {
        require(msg.sender == owner, "Only current owner can change ownership");
        owner = newOwner;
    }
}