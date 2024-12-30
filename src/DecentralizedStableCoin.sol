// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables

// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
 * @title Decentralized Stable Coin
 * Collateral: Exogenous (ETH & BTC)
 * Minting: Algorithmic
 * Relative Stability: Pegged to USD
 * This is the contract meant to be governed by DSCEngine. This contract is just the ERC20 implementation of our stablecoin system.
 */

contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentralizedStableCoinError_MustBeMoreThanZero();
    error DecentralizedStableCoinError_BurnAmountExceedsBalance();
    error DecentralizedStableCoinError_NotZeroAddress();

    constructor() ERC20("DecentralizedStableCoin", "DSC") {
        // No constructor implementation here
    }

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0) {
            revert DecentralizedStableCoinError_MustBeMoreThanZero();
        }

        if (balance < _amount) {
            revert DecentralizedStableCoinError_BurnAmountExceedsBalance();
        }

        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner {
        if (_to == address(0)) {
            revert DecentralizedStableCoinError_NotZeroAddress();
        }
        if (_amount <= (0)) {
            revert DecentralizedStableCoinError_MustBeMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}
