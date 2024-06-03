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
