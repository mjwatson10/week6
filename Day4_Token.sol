pragma solidity 0.5.12;
import "./Day3_Ownable.sol";
import "../Safemath.sol";


contract ERC20 is Ownable{
    
    
    //this gets access the the library Safemath.sol
    using SafeMath for uint256;
    
    
    //variables that are private usually have _ in front of it to specify that they are private
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    uint256 private _totalSupply;
    
    mapping(address => uint256) private _balances;
    
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
    }


    function name() public view returns (string memory) {
        return _name;

    }

    function symbol() public view returns (string memory) {
        return _symbol;

    }

    function decimals() public view returns (uint256) {
        return _decimals;

    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;

    }
    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];

    }

    function mint(address account, uint256 amount) public onlyOwner {
        //the zero address is usually used to burn tokens so we don't send tokens to address no one has
        require(account != address(0));
        
        //increasing total supply by amount being minted
        _totalSupply = _totalSupply.add(amount);
        //increasing account balance by amount minted
        _balances[account] = _balances[account].add(amount);

    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        //make sure account has equal to or more of the amount being transferred
        require(_balances[msg.sender] >= amount);
        
        //amount being sent to recipient needs to be taken out of msg.sender's balance
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        
        //amount being sent from msg.sender needs to be added to recipient's balance
        _balances[recipient] = _balances[recipient].add(amount);
        
        return true;
    }
}
