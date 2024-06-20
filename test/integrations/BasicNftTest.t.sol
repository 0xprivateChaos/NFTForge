// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft deployer;
    BasicNft basicNft;
    address public USER = makeAddr("user");
    string public constant PUG_URI =
        "ipfs://QmY175EFoDPJngL4HDNNSLTsxpvC7fWLw8QQft5rESxjQA";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
        // assertEq(actualName, expectedName);
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);
        
        uint256 expectedBalance = 1;
        uint256 actualBalance = basicNft.balanceOf(USER);

        assert(actualBalance == expectedBalance);
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG_URI) ));
    }
}