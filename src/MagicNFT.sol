// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MagicNFT is ERC721 {

    uint private s_tokenCounter;
    mapping(uint => string) private s_tokenIdToUri;

    constructor() ERC721("Magic", "MAT") {
        s_tokenCounter = 0;
    }

    function mint(string memory tokenUri) external {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint tokenId) public view override returns(string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
// https://ipfs.io/ipfs/Qmbmj8mvUeyZPsSQ6uLgt6s6J7M8FWLV21SKVxagveiTbX