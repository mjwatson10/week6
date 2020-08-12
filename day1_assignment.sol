pragma solidity 0.5.12;

contract HelloWorld{
    
//struct
    struct Person {
        string name;
        uint age;
        uint height;
        bool senior;
        address creator;
    }
    struct PersonID {
        uint id;
    }
    
//mapping
    mapping(address => Person) public newestPeople;
    
    
//array
    Person [] public people;
    PersonID[] public peopleID;
    
    
    function createPerson(string memory name, uint age, uint height) public {
        
        address creator = msg.sender;
        
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;
        newPerson.creator = creator;
        if(age >= 65){
            newPerson.senior = true;
        } 
        else {
            newPerson.senior = false;
        } 
        
        people.push(newPerson);
        newestPeople[creator] = newPerson;
    }
        
    
                                        //version of solidity cannot return struct
   function getPerson(uint index) public view returns(string memory name, uint age, uint height, bool senior, address creator){
        
     
        return (people[index].name, people[index].age, people[index].height, people[index].senior, people[index].creator);
    } 
    
    //second bonus assignment (does not work, but i wanted to try)
    
    function getSenderID() public returns(uint id){
        
        PersonID memory allIDs;
        
        for(uint i = 0; i < people.length; i++){
            if(msg.sender == people[i].creator)
            return peopleID.push(allIDs);
        }
       
    }
    

    
    
    
}
