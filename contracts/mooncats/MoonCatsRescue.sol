/**
 *Submitted for verification at Etherscan.io on 2017-08-09
*/

pragma solidity ^0.8.0;
contract MoonCatsRescue {
   struct AdoptionOffer {
    bool exists;
    bytes5 catId;
    address seller;
    uint price;
    address onlyOfferTo;
  }

  // struct AdoptionRequest{
  //   bool exists;
  //   bytes5 catId;
  //   address requester;
  //   uint price;
  // }

  mapping (bytes5 => AdoptionOffer) public adoptionOffers;
  // mapping (bytes5 => AdoptionRequest) public adoptionRequests;

  mapping (bytes5 => bytes32) public catNames;
  mapping (bytes5 => address) public catOwners;
  mapping (address => uint256) public balanceOf; //number of cats owned by a given address
  mapping (address => uint) public pendingWithdrawals;

  function acceptAdoptionOffer(bytes5 catId) payable external{}
    function makeAdoptionOfferToAddress(bytes5 catId, uint price, address to) external{}
    function giveCat(bytes5 catId, address to) external{}
    function rescueOrder(uint256 rescueIndex) external view returns(bytes5 catId){}
}