// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {MagicNFT} from "../src/MagicNFT.sol";

contract DeployMagicNFT is Script{
    function run() external returns(MagicNFT) {

        vm.startBroadcast();
        MagicNFT magic = new MagicNFT();
        vm.stopBroadcast(); 

        return magic;
    }
}