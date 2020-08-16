import "./helloworldDay2.sol";
import "./Boss.sol";
pragma solidity 0.5.12;


contract Workers is People, Boss{
   
    
    struct Payment{
                    string name; 
                    uint age;
                    uint height; 
                    bool senior;                    
                    uint wage;
                    string title;
    }
    
    
    //mapping for employees
    mapping(address => Payment) private salary;
    
    
    address[] private creators;
    
    
    //event
    event workerFired(string name, uint wage, address deletedBy);
    
    
    
    
    function createWorker(string memory name, uint age, uint height, uint wage, string memory title) public {
            
             createPerson(name, age, height);
             require(age <= 75, "Age needs to be no older than 75");
             
                 Payment memory newEmployee;
                 newEmployee.name = name;
                 newEmployee.age = age;
                 newEmployee.height = height;
                 newEmployee.wage = wage;
                 newEmployee.title = title;
                
                    
            insertWorker(newEmployee, theBoss);
            creators.push(msg.sender);
                
    }
            
            
        function insertWorker(Payment memory newEmployee, address newBoss) internal {
            
            address creator = msg.sender; 
            salary[creator] = newEmployee;
            theBoss = newBoss;
    }
    
    
    
        function getWorker() public view returns(string memory name, uint age, uint height, bool senior, uint wage, string memory title){
            address creator = msg.sender;
        
            return (
                    salary[creator].name, 
                    salary[creator].age, 
                    salary[creator].height, 
                    salary[creator].senior, 
                    salary[creator].wage, 
                    salary[creator].title
                    );
    }  
    
    
    
        function fireWorker(address creator) public onlyBoss{
            string memory name = salary[creator].name;
            uint wage = salary[creator].wage;
        
            delete salary[creator];
                assert(salary[creator].wage == 0);
                emit workerFired(name, wage, msg.sender);
    }
        
    
    
    
}
