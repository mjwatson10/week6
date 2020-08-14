pragma solidity 0.5.1;
contract MemoryAndStorage {

    mapping(uint => User) users;

    struct User{
        uint id;
        uint balance;
    }

    function addUser(uint id, uint balance) public {
        users[id] = User(id, balance);
    }
    
    //changed memory to storage to have update saved outside of function
    function updateBalance(uint id, uint balance) public {
         User storage user = users[id];
         user.balance = balance;
    }

    function getBalance(uint id) view public returns (uint) {
        return users[id].balance;
    }

}
