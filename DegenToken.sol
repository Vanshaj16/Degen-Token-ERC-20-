// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
// Transferring tokens: Players should be able to transfer their tokens to others.
// Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// Checking token balance: Players should be able to check their token balance at any time.
// Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable(msg.sender), ERC20Burnable {
    constructor() ERC20("Degen", "DGN") {}

    struct StoreItem {
        string name;
        uint256 price;
    }

     mapping(uint => StoreItem)  storeItems;

    function addItem() public onlyOwner {
        storeItems[1] = StoreItem("0.5 Eth coin",100);
        storeItems[2] = StoreItem("5% Cashback",80);
        storeItems[3] = StoreItem("CryptoPunks",50);
        storeItems[4] = StoreItem("Axie Infinity free access",500);

    }

    function showStoreItems() public view returns (StoreItem[] memory) {
        StoreItem[] memory items = new StoreItem[](4);
        for (uint256 i = 0; i < 4; i++) {
            items[i] = storeItems[i];
        }
        return items;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount); // last value is for decimals
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        approve(msg.sender, _value);
        transferFrom(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        _burn(msg.sender, _value);
    }

    function redeemToken(uint256 _itemIndex) external payable {
        require(_itemIndex < 4, "Invalid item index");
        StoreItem memory item = storeItems[_itemIndex];
        require(balanceOf(msg.sender) >= item.price, "You do not have enough Degen Tokens");
        _burn(msg.sender, item.price);
        payable(msg.sender).transfer(msg.value);
        
       }

    // Fallback function to accept Ether
    receive() external payable {}
}
