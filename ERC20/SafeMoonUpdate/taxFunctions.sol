// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PQLToken is ERC20 {

    address owners = msg.sender;
    constructor() ERC20("PiqSol Token", "PQL") {
        _mint(owners, 10000000 * 10 ** 18);
    }
    
    uint256 public taxFee; // this variable holding tax amount
    
    address public Address1 = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
    address public Address2 = 0x583031D1113aD414F02576BD6afaBfb302140225;
    address public Address3 = 0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB;

    function realtransfer(address from, address to, uint256 amount) public {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        // require(amount > 0, "Transfer amount must be greater than zero");       

        uint256 taxFee1 = return75(amount);
         transfer( to, taxFee1);
        taxFee = calculate25(amount);
       
        sendTexfeeTollAll();
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        realtransfer(sender, recipient, amount);
        return true;
    }

    // function _tokenTransfer(address from, address to, uint256 amount) private {
    // if(taxFee>0 && from != address(0) && to!=address(0) && amount>0){
    // sendTexfeeTollAll();
    // }
    // }

    function return75(uint _amount) public pure returns(uint _taxfee){
           _taxfee = _amount*75/100;
           return _taxfee;
    }
    function calculate25(uint _amount) public pure returns(uint _taxfee){
           _taxfee = _amount*25/100;
           return _taxfee;
    }
    function calculate50(uint _amount) public pure returns(uint _taxfee){
           _taxfee = _amount*50/100;
           return _taxfee;
    }
    function sendTexfeeTollAll() public {
        transfer(Address1,calculate25(taxFee));
        transfer(Address2,calculate25(taxFee));
        transfer(Address3,calculate50(taxFee));
    }
}