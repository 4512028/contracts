interface IBEP20 {
        function balanceOf(address account) external view returns (uint256);
    }

//  SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

 

pragma solidity ^0.8.4;

contract PQLBuy is Ownable,ReentrancyGuard{

     ERC20 public PqlToken;
     address public owners;
     uint256 public tokenPerEth = 100;

    constructor(address PQLTokenAddress) {
        owners = msg.sender;
        PqlToken = ERC20(PQLTokenAddress);
    } 
    function setTokenPerEthPrice(uint _tokenPerEthPrice) public{
        tokenPerEth = _tokenPerEthPrice ;
    } 
    function userTokenBalance() public view returns(uint256){
        return PqlToken.balanceOf(msg.sender);
    }     

    function contractEtherBalance() public  view returns(uint256) {
        return address(this).balance;
    }     
 

    function Buy() external payable  nonReentrant{
        uint256 tokensAmountToBuy  =  msg.value * tokenPerEth; 
        require(msg.value > 0,"Your Buying must be greater than zero"); 
        PqlToken.transferFrom(owners, msg.sender, tokensAmountToBuy); 
    } 

    // owners can withdraw ethers by using this function 
    function withdrawETHfromContract() external onlyOwner nonReentrant{
        uint256 ownersBalance = address(this).balance;
        require(ownersBalance > 0 , "owners Does not have enough balance to withdraw");
        (bool sent,) =  msg.sender.call{value:address(this).balance}("");
        require(sent , "Failed to send user balance back to the owners");
    }
}