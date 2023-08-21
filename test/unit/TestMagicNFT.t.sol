// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "lib/forge-std/src/Test.sol";
import {MagicNFT} from "../../src/MagicNFT.sol";
import {DeployMagicNFT} from "../../script/DeployMagicNFT.s.sol";

contract TestMagicNFT is Test{

    event Approval(address indexed from, address indexed to, uint id);

    MagicNFT magic;
    address USER = makeAddr('user');
    string public constant MAGIC= "ipfs://Qmbmj8mvUeyZPsSQ6uLgt6s6J7M8FWLV21SKVxagveiTbX";
    string public constant NAME = "Magic";
    string public constant SYMBOL = "MAT";

    uint private constant INITIAL_BALANCE = 100_000 ether;
    function setUp() external {
        DeployMagicNFT deployer = new DeployMagicNFT();
        magic = deployer.run();
        vm.deal(USER, INITIAL_BALANCE);
    }

    modifier userMint() {
        vm.prank(USER);
        magic.mint(MAGIC);
        _;
    }

    function testBalanceOf() external userMint{
        assert(magic.balanceOf(USER) > 0);
        assert(keccak256(abi.encodePacked(MAGIC)) == keccak256(abi.encodePacked(magic.tokenURI(0))));
    }

    function testOwnerOf() external userMint{
        
        assert(magic.ownerOf(0) == USER);
    }

    function testInvalidAddress() external {
        vm.prank(address(0));
        vm.expectRevert("ERC721: invalid token ID");
        magic.ownerOf(0);
    }

    function testNameAndSymbol() external {
        assert(keccak256(abi.encodePacked(magic.name())) == keccak256(abi.encodePacked(NAME)));
        assert(keccak256(abi.encodePacked(magic.symbol())) == keccak256(abi.encodePacked(SYMBOL)));
    }

    function testTokenURI() external userMint{
        assert(keccak256(abi.encodePacked(magic.tokenURI(0))) != keccak256(abi.encodePacked("")));
    }

    function testApproveRevertNotOwner() external userMint{
        vm.expectRevert("ERC721: approval to current owner");
        magic.approve(USER, 0);
    }

    function testApproveEmitApproval() external userMint{
        // vm.expectEmit(true, true, false, true);
        // emit Approval(USER, msg.sender, 0);
        // magic.approve(msg.sender, 0);

        vm.expectEmit();
        emit MagicNFT.Approval(USER, msg.sender, 0);
        magic.approve(msg.sender, 0);
    }
}
