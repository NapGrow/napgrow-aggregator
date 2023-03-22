// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./interfaces/IERC998.sol";
import "./MoonCatOrderLookup.sol";

//        ##          ##
//      ##  ##      ##  ##
//      ##..  ######  ..##
//    ####              ####
//    ##                  ##
//    ##    ()      ()    ##
//    ##                  ##
//    ##     \  ##  /     ##
//    ##      \/  \/      ##
//      ##              ##
//        ##############
//
//    #AcclimatedMoonCatsGlow
//  https://mooncat.community/


/**
 * @title MoonCat​Acclimator
 * @notice Accepts an original MoonCat and wraps it to present an ERC721- and ERC998-compliant asset
 * @notice Accepts a MoonCat wrapped with the older wrapping contract (at 0x7C40c3...) and re-wraps them
 * @notice Ownable by an admin address. Rights of the Owner are to pause and unpause the contract, and update metadata URL
 */
contract MoonCatAcclimator {
    
    function batchReWrap(
        uint256[] memory _rescueOrders,
        uint256[] memory _oldTokenIds
    ) external {}

    /**
     * @dev Take a list of unwrapped MoonCat rescue orders and wrap them.
     * @param _rescueOrders an array of MoonCats, identified by rescue order, to rewrap
     */
    function batchWrap(uint256[] memory _rescueOrders) external {}

    /**
     * @dev Take a list of MoonCats wrapped in this contract and unwrap them.
     * @param _rescueOrders an array of MoonCats, identified by rescue order, to unwrap
     */
    function batchUnwrap(uint256[] memory _rescueOrders) external {} 
    
}