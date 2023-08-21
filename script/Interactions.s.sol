// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {DeployMagicNFT} from "./DeployMagicNFT.s.sol";
import {MagicNFT} from "../src/MagicNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract Mint is Script{

    string public constant MAGIC= "ipfs://Qmbmj8mvUeyZPsSQ6uLgt6s6J7M8FWLV21SKVxagveiTbX";

    function mintMagicNft(address _nft) public{
        vm.startBroadcast();
        MagicNFT(_nft).mint(MAGIC);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("MagicNFT", block.chainid);
        mintMagicNft(mostRecentlyDeployed);
    }
}