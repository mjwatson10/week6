pragma solidity 0.5.12;

contract Boss{
    
    address public theBoss;
    
    address[] internal bossArray;
    
    
    
    modifier onlyBoss(){
        require(msg.sender == theBoss);
        _;
    }
    
    
    constructor() public{
        theBoss = msg.sender;
    }
    
}
