// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.8.4;

import "./punks/interfaces/ICryptoPunks.sol";
import "./punks/interfaces/IWrappedPunk.sol";
import "./mooncats/interfaces/IMoonCatsWrapped.sol";
import "./mooncats/interfaces/IMoonCatsRescue.sol";
import "./mooncats/interfaces/IMoonCatAcclimator.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./interfaces/IWETH.sol";

library Converter {

    struct MoonCatDetails {
        bytes5[] catIds;
        uint256[] oldTokenIds;
        uint256[] rescueOrders;
    }

    /**
    * @dev converts uint256 to a bytes(32) object
    */
    function _uintToBytes(uint256 x) internal pure returns (bytes memory b) {
        b = new bytes(32);
        assembly {
            mstore(add(b, 32), x)
        }
    }

    /**
    * @dev converts address to a bytes(32) object
    */
    function _addressToBytes(address a) internal pure returns (bytes memory) {
        return abi.encodePacked(a);
    }

    function mooncatToAcclimated(MoonCatDetails memory moonCatDetails) external {
        for (uint256 i = 0; i < moonCatDetails.catIds.length; i++) {
            // make an adoption offer to the Acclimated​MoonCats contract
            IMoonCatsRescue(0x60cd862c9C687A9dE49aecdC3A99b74A4fc54aB6).makeAdoptionOfferToAddress(
                moonCatDetails.catIds[i], 
                0, 
                0xc3f733ca98E0daD0386979Eb96fb1722A1A05E69
            );
        }
        // mint Acclimated​MoonCats
        IMoonCatAcclimator(0xc3f733ca98E0daD0386979Eb96fb1722A1A05E69).batchWrap(moonCatDetails.rescueOrders);
    }

    function wrappedToAcclimated(MoonCatDetails memory moonCatDetails) external {
        for (uint256 i = 0; i < moonCatDetails.oldTokenIds.length; i++) {
            // transfer the token to Acclimated​MoonCats to mint
            IERC721(0x7C40c393DC0f283F318791d746d894DdD3693572).safeTransferFrom(
                address(this),
                0xc3f733ca98E0daD0386979Eb96fb1722A1A05E69,
                moonCatDetails.oldTokenIds[i],
                abi.encodePacked(
                    _uintToBytes(moonCatDetails.rescueOrders[i]),
                    _addressToBytes(address(this))
                )
            );
        }
    }

    function mooncatToWrapped(MoonCatDetails memory moonCatDetails) external {
        for (uint256 i = 0; i < moonCatDetails.catIds.length; i++) {
            // make an adoption offer to the Acclimated​MoonCats contract               
            IMoonCatsRescue(0x60cd862c9C687A9dE49aecdC3A99b74A4fc54aB6).makeAdoptionOfferToAddress(
                moonCatDetails.catIds[i], 
                0, 
                0x7C40c393DC0f283F318791d746d894DdD3693572
            );
            // mint Wrapped Mooncat
            IMoonCatsWrapped(0x7C40c393DC0f283F318791d746d894DdD3693572).wrap(moonCatDetails.catIds[i]);
        }
    }

    function acclimatedToWrapped(MoonCatDetails memory moonCatDetails) external {
        // unwrap Acclimated​MoonCats to get Mooncats
        IMoonCatAcclimator(0xc3f733ca98E0daD0386979Eb96fb1722A1A05E69).batchUnwrap(moonCatDetails.rescueOrders);
        // Convert Mooncats to Wrapped Mooncats
        for (uint256 i = 0; i < moonCatDetails.rescueOrders.length; i++) {
            // make an adoption offer to the Acclimated​MoonCats contract               
            IMoonCatsRescue(0xc3f733ca98E0daD0386979Eb96fb1722A1A05E69).makeAdoptionOfferToAddress(
                moonCatDetails.catIds[i], 
                0, 
                0x7C40c393DC0f283F318791d746d894DdD3693572
            );
            // mint Wrapped Mooncat
            IMoonCatsWrapped(0x7C40c393DC0f283F318791d746d894DdD3693572).wrap(moonCatDetails.catIds[i]);
        }
    }

    function cryptopunkToWrapped(address punks, address wrappedPunk, address punkProxy, uint256[] memory tokenIds) external {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            // transfer the CryptoPunk to the userProxy
            ICryptoPunks(punks).transferPunk(punkProxy, tokenIds[i]);
            // mint Wrapped CryptoPunk
            IWrappedPunk(wrappedPunk).mint(tokenIds[i]);
        }
    }

    function wrappedToCryptopunk(address wrappedPunk, uint256[] memory tokenIds) external {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            IWrappedPunk(wrappedPunk).burn(tokenIds[i]);
        }
    }

    function ethToWeth(address weth, uint256 amount) external {
        bytes memory _data = abi.encodeWithSelector(IWETH.deposit.selector);
        
        // (bool success, ) = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2).call{value:amount}(_data);
        (bool success, ) = address(weth).call{value:amount}(_data);
        if (!success) {
            // Copy revert reason from call
            assembly {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
        }
    }

    function wethToEth(address weth, uint256 amount) external {
        // IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2).withdraw(amount);
        
        IWETH(weth).withdraw(amount);
        
    }
}