// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

interface course{
     function enroll(address _user, uint256 _courseId) external payable;
}

contract NFTMarketplace is ERC721, ERC721Enumerable, Ownable {

    // The line using SafeMath for uint256; indicates that the SafeMath library is being used to perform arithmetic operations on uint256 types in a safe manner. 
    // In Solidity, arithmetic operations can lead to vulnerabilities like integer overflow or underflow, which may result in unexpected behavior or security issues.

    // using SafeMath for uint256;  Cannot use Safe Math, because we have not imported it.
    //Also we don't need safemath as solidity version >0.8.0 comes with it.

    // NFT struct
    struct NFT {
        uint256 goalId;
        uint256 startDate;
        uint256 endDate;
        bool goalCompleted;
    }

    // User data struct
    struct UserData {
        uint256[] ownedNFTs;
        uint256[] achievements;
        uint256[] purchasedCourses;
    }

    address public s_courseAddress;

    // Mapping from token ID to NFT details

    mapping(uint256 => NFT) public nftDetails;

    // Mapping from goal ID to goal details

    mapping(uint256 => string) public goals;

    // Mapping from user address to user data

    mapping(address => UserData) private userData;

    // Events : Events are a way for your smart contract to communicate with the external world.
    // GoalCompleted: This is the name of the event.
    // address indexed owner: This parameter indicates the address of the user (owner) who triggered the event. 
    // The indexed keyword is used to make this parameter searchable in log data, allowing external systems to efficiently filter and search for specific events.
    // uint256 indexed tokenId: This parameter represents the unique identifier of the NFT (token) associated with the completed goal.
    // uint256 goalId: This parameter holds the identifier of the completed goal. It provides information about which goal was achieved.

    event GoalCompleted(address indexed owner, uint256 indexed tokenId, uint256 goalId);

    // Constructor
    // ERC721(_name, _symbol): This line is invoking the constructor of the ERC721 contract, which is being used as a base contract.
    // The curly braces represent the body of the constructor. 
    // In this case, it's empty, indicating that there are no additional operations to be executed when the contract is deployed.

    constructor(string memory _name, string memory _symbol, address courseAddress) ERC721(_name, _symbol) Ownable(msg.sender) {
        s_courseAddress = courseAddress;
    }

    // Get user data
    function getUserData(address user) external view returns (UserData memory) {
        return userData[user];
    }

    // Add NFT to user's ownedNFTs
    function addOwnedNFT(address user, uint256 tokenId) internal {
        userData[user].ownedNFTs.push(tokenId);
    }

    // Add achievement to user's achievements
    function addAchievement(address user, uint256 achievementId) internal {
        userData[user].achievements.push(achievementId);
    }

     // Add course to user's purchasedCourses
    function addPurchasedCourse(address user, uint256 courseId) internal {
        userData[user].purchasedCourses.push(courseId);
    }

    // Mint new NFT with associated goal
    // The function is declared as external, meaning it can be called from outside the contract. 
    // The onlyOwner modifier ensures that only the owner of the contract (the address that deployed the contract) can call this function.
    function mintNFT(address to, uint256 tokenId, uint256 goalId, uint256 startDate, uint256 endDate) external onlyOwner {

        // This line checks if the provided goalId is within the valid range.
        // Assuming there are 10 predefined goals.
        require(goalId > 0 && goalId <= 10, "Invalid goal ID");

        // This line checks if the provided date range is valid (start date is before the end date).
        require(startDate < endDate, "Invalid date range");

        // This line calls the _mint function inherited from the ERC721 contract. 
        // It mints a new NFT and assigns it to the specified address (to) with the given tokenId.
        _mint(to, tokenId);

        //  This line updates the nftDetails mapping with the details of the newly minted NFT. 
        // It associates the tokenId with a struct containing the goalId, startDate, endDate, and a boolean indicating whether the goal is completed (false initially).
        nftDetails[tokenId] = NFT(goalId, startDate, endDate, false);
    }

    // Buy NFT
    // The function is declared as external to allow external calls, and payable because it accepts ether.
    function buyNFTAndUpdateData(uint256 tokenId) external payable {

        // This line checks if the NFT with the given tokenId exists. 
        // If the condition is not met, the function will revert with the error message "NFT does not exist."
        require(ownerOf(tokenId) != address(0), "NFT does not exist");

        // This line checks if the amount of ether sent with the transaction is at least 1 ether. 
        // If the condition is not met, the function will revert with the error message "Insufficient funds."
        require(msg.value >= 1 ether, "Insufficient funds");

        // This line transfers ownership of the NFT with the specified tokenId from the current owner to the buyer (msg.sender). 
        // It uses the _transfer function inherited from the ERC721 contract.
        _transfer(ownerOf(tokenId), msg.sender, tokenId);

        // Update user data
        addOwnedNFT(msg.sender, tokenId);

        // This conditional statement checks if the current date and time (represented by block.timestamp) is on or after the end date of the associated goal, and if the goal has not been completed yet.
        // If the conditions are met, it sets nftDetails[tokenId].goalCompleted to true, indicating that the goal has been completed.
        // It also emits the GoalCompleted event with information about the buyer, the NFT (tokenId), and the completed goal (nftDetails[tokenId].goalId).
        if (nftDetails[tokenId].endDate >= block.timestamp && !nftDetails[tokenId].goalCompleted) {
            nftDetails[tokenId].goalCompleted = true;
            emit GoalCompleted(msg.sender, tokenId, nftDetails[tokenId].goalId);
            addAchievement(msg.sender, nftDetails[tokenId].goalId);
        }
    }

    // Reward NFT for completing a goal
    function rewardNFTAndUpdateData(uint256 tokenId) external onlyOwner {

        // This line checks if the NFT with the given tokenId exists. 
        // If the condition is not met, the function will revert with the error message "NFT does not exist."
        require(ownerOf(tokenId) != address(0), "NFT does not exist");

        // This line checks if the goal associated with the NFT (tokenId) has been completed. 
        // If the condition is not met, the function will revert with the error message "Goal not completed."
        require(nftDetails[tokenId].goalCompleted, "Goal not completed");

        //  This line calculates a new token ID for the reward NFT. 
        // It assumes that the new token ID is one more than the current total supply of NFTs in the contract.
        uint256 newTokenId = totalSupply() + 1;

        // This line mints a new NFT with the calculated newTokenId and assigns it to the owner of the original NFT with tokenId. 
        // It uses the _mint function inherited from the ERC721 contract.
        _mint(ownerOf(tokenId), newTokenId);

        // Update user data
        addOwnedNFT(ownerOf(tokenId), newTokenId);
    }

    // Set goal details (onlyOwner)
    function setGoalDetails(uint256 goalId, string memory goalDescription) external onlyOwner {

        // This line checks if the provided goalId is within the valid range (assuming there are 10 predefined goals, as mentioned in the comment). 
        // If the condition is not met, the function will revert with the error message "Invalid goal ID."
        require(goalId > 0 && goalId <= 10, "Invalid goal ID");

        // This line updates the goals mapping with the new or updated description for the specified goalId. 
        // The goals mapping is assumed to have been declared in the contract to store the descriptions of predefined goals.
        goals[goalId] = goalDescription;
    }

    // Purchase course and update user data
    function purchaseCourseAndUpdateData(uint256 courseId) external payable {
        // ... (logic for purchasing a course)

        course(payable(s_courseAddress)).enroll(msg.sender, courseId);

        // Update user data
        addPurchasedCourse(msg.sender, courseId);

        // ... (other logic)
    }

    //These Functions are overrides, required by solidity

     function _increaseBalance(address account, uint128 value) internal virtual override(ERC721, ERC721Enumerable){
        super._increaseBalance(account, value);
     }

     function _update(address to, uint256 tokenId, address auth) internal virtual override (ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
     }
     function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
     }
     }
    
