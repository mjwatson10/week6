pragma solidity 0.5.12;

contract HelloWorld{
    
    //struct
    struct Person {
        string name;
        uint age;
        uint height;
        bool senior;
    }
    
    //event
    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);
    event personOriginal(string name, uint age, uint height, bool senior);
    event personChanged(string name, uint age, uint height, bool senior);
    
    //this is a variable
    address public owner;
    
    //modifier, in the modifer the _; signles the end of the modifier and to continue with the rest of the function 
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    modifier getOriginalPerson(){
        getPerson();
        _;
    }
    
    //constructor
    //constructors will only be called once and that is when the contract it created
    constructor() public{
        owner = msg.sender;
    }
    
    //mapping
    mapping(address => Person) private people;
    
    //array
    address[] private creators;
    
    function createPerson(string memory name, uint age, uint height) public {
        
        require(age <= 150, "Age needs to be below 150");
        
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;
        if(age >= 65){
            newPerson.senior = true;
        } 
        else {
            newPerson.senior = false;
        } 
        
        insertPerson(newPerson);
        creators.push(msg.sender);
        //below is checking people[msg.sender] == newPerson, solidity must hash this in order to assert
        assert(
            keccak256(
                abi.encodePacked(
                    people[msg.sender].name, 
                    people[msg.sender].age, 
                    people[msg.sender].height, 
                    people[msg.sender].senior
            )) == keccak256(
                abi.encodePacked(
                    newPerson.name, 
                    newPerson.age, 
                    newPerson.height, 
                    newPerson.senior
                    )
                )
            );
            //event the function will be sending
            emit personCreated(newPerson.name, newPerson.senior);
    }
    
    //private function because it helps to avoid one function from doing too many things and this function does not need to be accessed outside of the contract    
    function insertPerson(Person memory newPerson) private {
            
            address creator = msg.sender; 
            people[creator] = newPerson;   
    }
    
                                        //version of solidity cannot return struct
    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
        address creator = msg.sender;
        
        return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~modifier onlyOwner
    function deletePerson(address creator) public onlyOwner{
        string memory name = people[creator].name;
        bool senior = people[creator].senior;
        
        delete people[creator];
        assert(people[creator].age == 0);
        emit personDeleted(name, senior, msg.sender);
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~modifiers come before returns statement
    function getCreator(uint index) public view onlyOwner returns(address){
        
        return creators[index];
    }

    function updatePerson(address creator, string memory name, uint age, uint height) public getOriginalPerson {
        
       
    
        emit personOriginal(people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
                require(age <= 150, "Age needs to be below 150");
                
                
                delete people[creator];
        
        Person memory personUpdated;
        personUpdated.name = name;
        personUpdated.age = age;
        personUpdated.height = height;
        if(age >= 65){
            personUpdated.senior = true;
        } 
        else {
            personUpdated.senior = false;
        } 
        
        insertPerson(personUpdated);
        creators.push(msg.sender);
        assert(
            keccak256(
                abi.encodePacked(
                    people[msg.sender].name, 
                    people[msg.sender].age, 
                    people[msg.sender].height, 
                    people[msg.sender].senior
            )) == keccak256(
                abi.encodePacked(
                    personUpdated.name, 
                    personUpdated.age, 
                    personUpdated.height, 
                    personUpdated.senior
                    )
                )
            );
            emit personChanged(personUpdated.name, personUpdated.age, personUpdated.height, personUpdated.senior);
    }
    
    
}
