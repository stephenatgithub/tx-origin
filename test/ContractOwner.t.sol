// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/ContractOwner.sol";

contract ContractOwnerTest is Test {
    ContractOwner public contractOwner;
    Attack public attack;    

    function setUp() public {        
        address alice = address(1);
        vm.startPrank(alice, alice);
        contractOwner = new ContractOwner();
        
    }

    function testAttack() public {
        address alice = address(1);
        //vm.startPrank(alice, alice);
        vm.deal(alice, 10 ether);               
        contractOwner.deposit{value: 1 ether}();

        console.log("Before balance = ", contractOwner.getBalance()); 
        console.log("Before owner = ", contractOwner.owner()); 
        //contractOwner.transfer(payable(alice), 1 ether);
        
        address bob = address(2);
        vm.prank(bob);
        attack = new Attack(contractOwner);
        console.log("Before attack owner = ", attack.owner());

        vm.prank(alice, alice);
        attack.attack();

        console.log("After balance = ", contractOwner.getBalance());
        console.log("After owner = ", contractOwner.owner()); 
        console.log("After attack owner = ", attack.owner());

    }
}
