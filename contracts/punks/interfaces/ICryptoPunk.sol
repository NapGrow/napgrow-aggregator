// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

interface ICryptoPunk {

    function punkIndexToAddress(uint256 punkIndex) external returns (address);
    function punksOfferedForSale(uint256 punkIndex) external returns (bool, uint256, address, uint256, address);
    function buyPunk(uint punkIndex) external payable;
    function transferPunk(address to, uint punkIndex) external;

}