// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Abrokadabro is ERC20 {
    constructor(uint256 initialSupply) ERC20("Abrokadabro", "ABRO") {
        _mint(msg.sender, initialSupply);
    }
}