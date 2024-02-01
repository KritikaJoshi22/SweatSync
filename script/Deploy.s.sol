/// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/course.sol";
import "../src/NFT.sol";
import "../src/NFTMarketplace.sol";
import "../src/RewardToken.sol";
import "../src/stake.sol";

contract DeployAll is Script {

    string public NFT_COLLECTION_NAME = "";
    string public NFT_COLLECTION_SYMBOL = "";
    string public REWARD_TOKEN_COLLECTION_NAME = "";
    string public REWARD_TOKEN_COLLECTION_SYMBOL = "";
    address public SWEAT_SYNC_HANDLER;

    function run() external {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        ///  @dev Deploying the new ChainLink API call contract.
        CoursesMarketplace _courseMarketPlace = new CoursesMarketplace();

        /// @dev Deploying the ERC20 contract 
        RewardNFT _rewardNft = new RewardNFT(NFT_COLLECTION_NAME, NFT_COLLECTION_SYMBOL);

        /// @dev Deploying the engine contract
        SweatCoin _sweatCoin = new SweatCoin(REWARD_TOKEN_COLLECTION_NAME, REWARD_TOKEN_COLLECTION_SYMBOL);

        NFTStaking _nftStaking = new NFTStaking(address(_rewardNft), address(_sweatCoin), SWEAT_SYNC_HANDLER);


        vm.stopBroadcast();

    }
}
