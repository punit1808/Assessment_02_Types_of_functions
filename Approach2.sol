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
