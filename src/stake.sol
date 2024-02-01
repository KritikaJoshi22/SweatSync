// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface _SweatSync{

    function mint(address _user, uint256 _amount) external returns(bool);
}
interface NFT{

    function balanceOf(address _user) external returns(uint256);
    function transferFrom(address _from, address _to, uint256 _amount) external;
    function mintNFT(address to) external returns(uint256);

}

contract NFTStaking is Ownable {
    // Struct to represent a staking entry
    struct Staking {
        uint256 goal; // Number of days, for which the goal is set
        uint256 start_time; // The starting time.
        uint256 lastUpadated; // To keep track of the streak
        uint256 totalCaloriesLeft; // To keep track of all the calories left 
        uint256 totalStepsTaken;
        uint256 tokenId;
        bool goalActive;
        address _nftTokenAddress;
    }

    address public s_sweatSyncHandler;
    address public s_nftContract;
    address public s_sweatSyncContract;

    uint8 constant GOAL_ACHIEVED = 0;

    // Mapping from NFT owner address to their staking details
    mapping(address => Staking) public stakings;

    // ERC20 token contract address (used as a reward token)
    IERC20 public rewardToken;

    // ERC721 NFT contract address
    IERC721 public nftContract;

    // Event emitted when a user stakes their NFTs
    event Staked(address indexed user, uint256 indexed goal, uint256 indexed tokenId);

    event UnStaked(address indexed user, uint256 indexed tokenId);

    // Event emitted when a user claims their reward
    event RewardClaimed(address indexed user, uint256 indexed amount);

    // Event emitted when a user withdraws their NFTs
    event WithdrawnByOwner(address indexed user, uint256 indexed tokenId);

    event DailyCheckin(address indexed user, uint256 indexed _days);

    event SweatSyncAddressChanged(address indexed previousSweatSyncAddress, address indexed newSweatSyncAddress);

    event RewardNFTClaimed(address user, uint256 tokenId);

    modifier isGoalActive(address _user){

        require (stakings[_user].goalActive == true, "You do not have an active goal");
        _;
    }

    modifier onlyFromSweatSync(){

        require (msg.sender == s_sweatSyncHandler, "You are not authorized");
        _;
    }

    constructor(
    address _nftContract, 
    address _rewardToken, 
    address _sweatsync)
    Ownable(msg.sender) 
    {

        s_nftContract = _nftContract;
        s_sweatSyncContract = _rewardToken;
        s_sweatSyncHandler = _sweatsync;
    }

    // Function to allow users to stake their NFTs
    function stakeNFTs(
        uint256 _goal, 
        uint256 _tokenId, 
        uint256 _dailyCalories, 
        uint256 _stepsDaily,
        address _nftAddress) 
        external 
        {

        require(NFT(_nftAddress).balanceOf(msg.sender) > 0, "You do not own any NFTs.");
        require(stakings[msg.sender].goalActive == false, "You have an active staking.");

        uint256 totalCalories = _dailyCalories * _goal;
        uint256 totalSteps = _stepsDaily * _goal;
        stakings[msg.sender] = Staking(_goal, block.timestamp, block.timestamp, totalCalories, totalSteps,_tokenId, true, _nftAddress);
        NFT(_nftAddress).transferFrom(msg.sender, address(this), _tokenId); // Assuming users can only stake 1 NFT
        emit Staked(msg.sender, _goal, _tokenId);
    }

    function dailyCheckIn(
        address _user,
        uint256 todaysCaloriesBurnt, 
        uint256 totalStepsToday) 
    external
    onlyFromSweatSync
    isGoalActive(_user)
    {

        require(stakings[_user].lastUpadated - block.timestamp >= 1 days, "You can only call this function after a Day");
        if (stakings[_user].goal > GOAL_ACHIEVED){
            stakings[_user].goal--;
        }
        if(stakings[_user].totalCaloriesLeft > todaysCaloriesBurnt){
            stakings[_user].totalCaloriesLeft -= todaysCaloriesBurnt;
        }
        else if(stakings[_user].totalCaloriesLeft < todaysCaloriesBurnt){
            stakings[_user].totalCaloriesLeft = GOAL_ACHIEVED;
        }
        if (stakings[_user].totalStepsTaken > totalStepsToday){
            stakings[_user].totalStepsTaken -= totalStepsToday;
        }
        else if(stakings[_user].totalStepsTaken < todaysCaloriesBurnt){
            stakings[_user].totalStepsTaken = GOAL_ACHIEVED;
        }
        stakings[_user].lastUpadated = block.timestamp;
        emit DailyCheckin(_user, stakings[_user].goal);
    }

    function unStake() 
    external
    isGoalActive(msg.sender)
    {
        require(stakings[msg.sender].goal == GOAL_ACHIEVED, "You can't unstake now, complete your streak");
        require(stakings[msg.sender].totalCaloriesLeft == GOAL_ACHIEVED, "You need to burn some more calories");
        require(stakings[msg.sender].totalStepsTaken == GOAL_ACHIEVED, "You need to take some more steps");
        
        uint256 _tokenId = stakings[msg.sender].tokenId;
        address tokenAddress = stakings[msg.sender]._nftTokenAddress;
        NFT(tokenAddress).transferFrom(address(this), msg.sender, _tokenId);

        claimRewardToken(msg.sender);
        claimRewardNFT(msg.sender);

         delete stakings[msg.sender];

         emit UnStaked(msg.sender, _tokenId);

    }

    // Function to allow users to claim their reward when the goal is completed
    function claimRewardToken(
    address _user) 
    private 
    {

        uint256 rewardAmount = calculateReward(_user);
        _SweatSync(s_sweatSyncContract).mint(_user, rewardAmount);

        emit RewardClaimed(_user, rewardAmount);
    }

    function claimRewardNFT(
    address _user)
    private{

        uint256 tokenId = NFT(s_nftContract).mintNFT(_user);

        emit RewardNFTClaimed(_user, tokenId);
    }

    // Function to allow users to withdraw their NFTs if the goal is not completed
    function withdraw(
    address _user) 
    external 
    onlyOwner
    isGoalActive(_user)
    {

        uint256 _tokenId = stakings[_user].tokenId;
        address tokenAddress = stakings[msg.sender]._nftTokenAddress;
        NFT(tokenAddress).transferFrom(address(this), _user, _tokenId);

         delete stakings[_user];

        emit WithdrawnByOwner(_user, _tokenId);
    }

    // Function to calculate the reward amount based on some logic
    function calculateReward(
    address _user) 
    internal 
    view 
    returns (uint256)
    {
        // For demonstration purposes, let's assume the reward is half of the goal
        return stakings[_user].goal / 2;
    }

    function changeSweatSyncAddres(
        address newAddr)
        external
        onlyOwner
        {
        
        emit SweatSyncAddressChanged(s_sweatSyncHandler, newAddr);
        s_sweatSyncHandler = newAddr;
    
    }
}