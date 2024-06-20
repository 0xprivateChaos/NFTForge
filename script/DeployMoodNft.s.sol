// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {

    function run() external returns (MoodNft) {
        string memory happySvg = vm.readFile("./image/happy.svg");
        string memory sadSvg = vm.readFile("./image/sad.svg");
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgToImageURI(happySvg), svgToImageURI(sadSvg));
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseUrl = "data:image/svg+xml;base64,";
        string memory base64EncodedSvg = Base64.encode(bytes(abi.encodePacked(svg)));
        return string(abi.encodePacked(baseUrl, base64EncodedSvg));
    }
}