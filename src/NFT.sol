// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract RewardNFT is ERC721, ERC721URIStorage,ERC721Enumerable, Ownable{

    string rewardNFTURI;

    constructor(string memory _name, 
    string memory _symbol)
    ERC721(_name, _symbol) 
    Ownable(msg.sender){

    }

    function mintNFT(
        address _to) 
        external 
        onlyOwner
        {

            uint256 _tokenId = totalSupply();
            _mint(_to, _tokenId);
            _setTokenURI(_tokenId, rewardNFTURI);

    }

    function setTokenURI(string memory _URI) external onlyOwner{

        rewardNFTURI = _URI;
    }

    function mintWithURI(address _to, 
    string memory _tokenURI)
    external
    onlyOwner{

        uint256 _tokenId = totalSupply();
        _mint(_to, _tokenId);
        _setTokenURI(_tokenId, _tokenURI);
    }

   function tokenURI(
                uint256 tokenId
            )
            public 
            view 
            virtual
            override(ERC721, ERC721URIStorage)
            returns (string memory)
            {

                return super.tokenURI(tokenId);
            }

            function supportsInterface(bytes4 interfaceId)
            public 
            view
            override(ERC721, ERC721URIStorage, ERC721Enumerable)
            returns(bool)
            {

                return super.supportsInterface(interfaceId);

            }

            function _update(address to, uint256 tokenId, address auth)
            internal
            virtual
            override(ERC721, ERC721Enumerable)
            returns(address){

                return super._update(to, tokenId, auth);
            }

            function _increaseBalance(address account, uint128 value) 
            internal 
            virtual 
            override(ERC721, ERC721Enumerable){ 
                super._increaseBalance(account, value);
            }
    }