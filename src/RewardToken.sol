// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


contract SweatCoin is ERC20Burnable, Ownable{

    error SweatCoin_MustBeMoreThanZero();
    error SweatCoin_NotZeroAddress();

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) Ownable(msg.sender) {

    }

    function mint(
        address _to, 
        uint256 _amount) 
        external onlyOwner returns (bool){

            if(_to == address(0)){

                revert SweatCoin_NotZeroAddress();
            }

            if(_amount <= 0){

                revert SweatCoin_MustBeMoreThanZero();
            }
            _mint(_to, _amount);
            return true;
    }


}