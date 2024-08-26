# PropertyTrader Smart Contract
This is the project consisting of a smart contract in Solidity, called PropertyTrader, and a web-based JavaScript script to complement it using the Web3 library to integrate it with MetaMask. In this smart contract, properties can be added, updated, purchased, and sold. The JavaScript code communicates with the Ethereum blockchain for such actions through a web interface.

## Function
>>addProperty : Function to add a new property (only owner).
>>
>>updatePropertyPrice : Function to update the price of a property (only owner).
>>
>>propertyExists: Function to check if a property exists.
>>
>>buyProperty: Function to simulate buying a property.
>>
>>sellProperty: Function to simulate selling a property (currently a placeholder).


### Description
This is a project consisting of a Solidity smart contract called `PropertyTrader` and a frontend JavaScript application that connects with MetaMask through Web3.js. It provides a smart contract for running property management, through which users can create, update, buy, and sell properties on the Ethereum blockchain. On top of this, the JavaScript code provides user interaction through a web interface, thus having nice integration with MetaMask to perform blockchain transactions.

>> Structs:
        1. The property struct stores information about property

>> Owner Management:
        1. The owner address is set to the contract deployer and is the only entity allowed to add or update properties.

>> Access Control:
        The onlyOwner modifier restricts certain functions to be called only by the contract owner.


#### Getting Started

##### Executing program
#### solidity
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PropertyTrader {
    // Enum to represent property types
    enum PropertyType { House, Flat }

    // Struct to store information about a property
    struct Property {
        string name;
        PropertyType propertyType;
        uint256 price; // Price in wei
    }

    // Mapping of property names to their details
    mapping(string => Property) public properties;

    // Address of the owner (who can update property prices)
    address public owner;

    // Event emitted when a property price is updated
    event PropertyPriceUpdated(string name, uint256 price);

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    // Function to add a new property (only owner)
    function addProperty(string memory name, PropertyType propertyType, uint256 price) public onlyOwner {
        require(!propertyExists(name), "Property already exists");
        properties[name] = Property(name, propertyType, price);
    }

    // Function to update the price of a property (only owner)
    function updatePropertyPrice(string memory name, uint256 price) public onlyOwner {
        require(propertyExists(name), "Property does not exist");
        properties[name].price = price;
        emit PropertyPriceUpdated(name, price);
    }

    // Function to check if a property exists
    function propertyExists(string memory name) public view returns (bool) {
        return bytes(properties[name].name).length > 0;
    }

    // Function to simulate buying a property
    function buyProperty(string memory name) public payable {
        require(propertyExists(name), "Property does not exist");
        Property storage property = properties[name];
        uint256 propertyPrice = property.price;
        require(msg.value >= propertyPrice, "Insufficient funds");
        // Simulate property purchase logic (e.g., update ownership records)
    }

    // Function to simulate selling a property (currently a placeholder)
function sellProperty(string memory name) public view {
    require(propertyExists(name), "Property does not exist");
    // Simulate property selling logic (e.g., update ownership records)
}

    // Modifier to restrict functions to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }
}
```


###### Author
Manish Kumar 
(https://www.linkedin.com/in/manish-kmr/)

###### License
This project is licensed under the MIT License
