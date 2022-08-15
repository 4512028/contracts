contract AirDropRc31 is Ownable{
    ERC20 private Token;
    using Address for address;
    constructor(){}
    function doAirDrop(
        address[] memory _address,
        uint256[] memory amounts,
        address tokenInstance
    )  public returns(bool) {
    require(_address.length == amounts.length, "addresses & amounts length should be same");
    require(tokenInstance.isContract(), "TokenInstance should be a contract");
    uint256 count = _address.length;
    Token = ERC20(tokenInstance);
    for (uint256 i = 0; i < count; i++)
    {
      Token.transferFrom(msg.sender,_address[i],amounts[i]);
    }
    return true;
  }
}