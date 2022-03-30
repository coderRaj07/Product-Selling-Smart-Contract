// SPDX-License-Identifier: GPL-3.0

//objective:
//State Variables: Merchant,Buyer,Price
//Constructor only for merchant
//Pricing Function:
//Set Product Price by Merchant
//Calculate current class price
//Add current gas price with product
//Take payment
//Withdraw only by merchant 

pragma solidity >=0.7.0 <0.9.0;

contract productSell{
    address payable public merchant;
    uint price;
    uint netAmount;

constructor(){
    merchant=payable(msg.sender);
}

address  buyer;

modifier onlyOwner(){
    require(msg.sender==merchant);
    _;
}

//Only Merchant sets Price
function setPrice(uint _price) external onlyOwner{
    price=_price;
}

//Know who is the buyer
function buyerAddress() public returns(address){
    buyer=msg.sender;
    return buyer;
}

//Anyone can view the payment amount to be paid with gas price included
function paymentAmount() public returns(uint){
    netAmount=tx.gasprice + price;
    return netAmount;
}
 
//Amount is paid to smart contract
function payAmount() payable public {
require(msg.value==tx.gasprice + price,"Click paymentAmount to check the exact amount to be paid");

}

//Merchant can withdraw the amount from smart contract
 function withdraw() public payable onlyOwner{
 merchant.transfer(address(this).balance);
}

}
