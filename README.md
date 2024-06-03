# MY ERC TOKEN
This project is to create our own ERC Token by implementing the functionalities present in ERC Token .

### Approach 01 :
By overriding the functions present in ERC Token by inheriting ERC20.

### Approach 02 :
By creating our Token from scratch and implementing all functionalities of ERC Token.

## Description

First, we will discuss about approach 1
### Approach 01 :
It contains 4 functions from ERC20 contract which are overrided and implemented in the MY_ERC contract also it has modifier named onlyOwner to give mint function to be done only by the Owner.
In constructor we are assigning totalSupply 1 million tokens and its name and symbol.

Secondly, it's time for the second approach 2
### Approach 02 : 
This approach is implementing ERC20 Token 6 functions which are build from the scratch and do similar functionalities as ERC20 Token.
It contains 6 helper functions a modifier for giving access of mint to Owner only and 2 mapping between address and totalSupply and between address and isAvailable to check if a particular address is present or not.


## Getting Started

For the execution of our code we will be using remixIDE ,
https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.25+commit.b61c2a91.js

After opening the remix IDE create a new .sol file and start writing the project code.

### Approach 01

### Executing program

```
code blocks for commands

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MY_ERC is ERC20 {
    uint8 private _decimals;
    address private owner;

    constructor() ERC20("MyToken", "MTK") {
        owner = msg.sender;
        _decimals = 18;
        _mint(msg.sender, 1000000 * (10 ** uint256(_decimals)));
    }

    modifier onlyOwner {
        require(owner == msg.sender, "Only owner can mint");
        _;
    }
    
    function decimals() public view override  returns (uint8) {
        return _decimals;
    }

    function mint(address to, uint256 value) public onlyOwner {
        _mint(to, value);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        return super.transfer(to, value);
    }

    function burn(uint256 value) public returns (bool) {
        _burn(msg.sender, value);
        return true;
    }
}

```

### Approach 02

### Executing program

```
code blocks for commands

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2;

contract MY_ERC_Token {

    string public tokenName;
    string public tokenSymbol;
    uint private  tokenSupply;
    address private Owner;

    mapping(address => uint) private balance_atAddress;
    mapping(address => bool)  private isExist;

    constructor(string memory _tokenName, string memory _tokenSymbol, uint _tokenSupply){
        Owner=msg.sender;
        tokenName=_tokenName;
        tokenSymbol=_tokenSymbol;
        tokenSupply=_tokenSupply;
        balance_atAddress[Owner] += _tokenSupply;
        isExist[Owner] = true;
    }

    modifier ownerAccess{
        require(Owner == msg.sender ,"Only Owner can Access this Function.");
        _;
    }

    function validateAccount(address validAcc) public {
        isExist[validAcc] = true;
    }

    function mint(address mintAt, uint mintValue) public ownerAccess{
        balance_atAddress[mintAt]+=mintValue;
        tokenSupply+=mintValue;
    }

    function burn(address burnFrom) public {
        require( isExist[burnFrom] , "Account don't exit. ");
        tokenSupply -= balance_atAddress[burnFrom];
        balance_atAddress[burnFrom] = 0;
    }

    function totalSupply() public view returns(uint) {
        return tokenSupply;
    }

    function balanceOf(address checkAt) public view returns(uint) {
        require( isExist[checkAt] , "Account don't exit. ");
        return balance_atAddress[checkAt];
    }

    function transfer(address transferAt, uint transferValue) public {
        require( isExist[transferAt] , "Receiver Account don't exit. ");
        require( balance_atAddress[msg.sender] >= transferValue, "Insufficient Account Balance");
        
        balance_atAddress[msg.sender] -= transferValue;
        balance_atAddress[transferAt] += transferValue;
    }
}

```

After writing the code it's time to compile it. So, press Ctrl + S to compile your code or click on Solidity comipler and then click on Compile project.sol . Now it's time to deploy click on deploy and run transction just below Solidity compiler and deploy . After deployment we can put values in mint and burn function to check if the code is working properly.

## For Better Understanding you can refer to Video Explaination.

### Thanks for Reading
I hope you Understand the program Code and functioning well.
## Have a Nice Day !!!
