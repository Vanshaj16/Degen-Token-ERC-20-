# Project: Degen Token (ERC-20): Unlocking the Future of Gaming
DegenToken is a custom ERC20 token built on the Ethereum blockchain. This smart contract allows minting, transferring, redeeming, and burning tokens. It also includes an in-game store where tokens can be redeemed for items.

## Description
DegenToken is designed to serve as a reward and utility token for a gaming platform. The platform owner can mint new tokens and distribute them as rewards to players. Players can transfer tokens to each other, redeem them for items in the in-game store, and burn tokens they no longer need. The contract leverages OpenZeppelin's ERC20 implementation for standard token functionality and Ownable for access control, ensuring that only the contract owner can mint new tokens.
### Tools Used
1. Computer
2. Remix IDE
3. Hardhat
4. MetaMask
5. SnowTrace
6. Solidity
### ERC20 standard interface has following functions and events:
1. Total Supply: The total number of tokens that will ever be issued
2. Balance Of: The account balance of a token owner's account
3. Transfer: Automatically executes transfers of a specified number of tokens to a specified address for transactions using the token
4. Transfer From: Automatically executes transfers of a specified number of tokens from a specified address using the token
5. Approve: Allows a spender to withdraw a set number of tokens from a specified account, up to a specific amount
6. Allowance: Returns a set number of tokens from a spender to the owner
7. Transfer: An event triggered when a transfer is successful (an event)
8. Approval: A log of an approved event (an event)

### Prerequisites
1. Remix IDE: An online IDE for Solidity smart contract development.
2. MetaMask: A browser extension for interacting with the Ethereum network.
3. SnowTrace: A powerful blockchain explorer designed for the Avalanche Network.

## Requirements for the project
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
   
## Getting Started
### Installing
To get started with the DegenToken contract, you'll need to have the following tools installed:
1. Remix IDE 
2. MetaMask

### Executing program
1. Go to Remix IDE.
2. Create a New Solidity File: In the "File Explorer" pane on the left, click the "+" button to create a new file.
3. Name your file DegenToken.sol
   
4. Copy and paste the following code into DegenToken.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// Minting new tokens: The platform should be able to create new tokens and distribute them to players as 
// rewards. Only the owner can mint tokens.
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

    mapping(uint => StoreItem) public storeItems;

    event ItemRedeemed(address indexed player, string itemName, uint256 itemPrice);

    function addItem() public onlyOwner {
        storeItems[1] = StoreItem("0.5 Eth coin", 100);
        storeItems[2] = StoreItem("5% Cashback", 80);
        storeItems[3] = StoreItem("CryptoPunks", 50);
        storeItems[4] = StoreItem("Axie Infinity free access", 500);
    }

    function showStoreItems() public view returns (StoreItem[] memory) {
        StoreItem[] memory items = new StoreItem[](4);
        for (uint256 i = 0; i < 4; i++) {
            items[i] = storeItems[i + 1];
        }
        return items;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
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
        require(_itemIndex >= 1 && _itemIndex <= 4, "Invalid item index");
        StoreItem memory item = storeItems[_itemIndex];
        require(balanceOf(msg.sender) >= item.price, "You do not have enough Degen Tokens");
        _burn(msg.sender, item.price);
        
        // Deliver the item to the player
        emit ItemRedeemed(msg.sender, item.name, item.price);

        // Display the item redeemed in console for debugging purposes
        console.log("Item Redeemed:", item.name);
    }

    // Fallback function to accept Ether
    receive() external payable {}
}

```
5. Compile the contract using the Solidity compiler in Remix.

#### Deploy the contract:
1. Select "Injected Web3" as the environment in the Remix IDE.
2. Connect to your MetaMask wallet.
3. Ensure you are connected to the Avalanche C-Chain network.
4. Click "Deploy" and confirm the transaction in MetaMask.
   
#### Verifying on SnowTrace
1. After deploying the contract, copy the contract address from the Remix IDE.
2. Open SnowTrace.
3. Navigate to "Contract" > "Verify and Publish".
4. Enter the contract address and select "Solidity (Single File)" as the Compiler Type.
5. Select the appropriate Solidity Compiler version used in Remix (e.g., 0.8.20).
6. Paste the contract code into the provided text box.
7. Click "Verify and Publish".
8. Once verified, you can interact with your contract directly on SnowTrace

## Authors

Vanshaj

vanshajsen16@gmail.com
