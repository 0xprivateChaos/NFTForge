// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintBasicNft is Script {
    string public constant PUG_URI =
        "ipfs://QmY175EFoDPJngL4HDNNSLTsxpvC7fWLw8QQft5rESxjQA";

    function run() external {
        address mostRecentlyDeployedContract = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedContract);    
    }

    function mintNftOnContract(address _mostRecentlyDeployedContract) public {
        vm.startBroadcast();
        BasicNft(_mostRecentlyDeployedContract).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {

    function run() external {
        address mostRecentlyDeployedContract = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedContract);    
    }

    function mintNftOnContract(address _mostRecentlyDeployedContract) public {
        vm.startBroadcast();
        MoodNft(_mostRecentlyDeployedContract).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant MOOD_NFT_ID = 0;

    function run() external {
        address mostRecentlyDeployedContract = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodOnContract(mostRecentlyDeployedContract);    
    }

    function flipMoodOnContract(address _mostRecentlyDeployedContract) public {
        vm.startBroadcast();
        MoodNft(_mostRecentlyDeployedContract).flipMood(MOOD_NFT_ID);
        vm.stopBroadcast();
    }
}