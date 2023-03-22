// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.8.4;


contract IConverter {
    struct MoonCatDetails {
        bytes5[] catIds;
        uint256[] oldTokenIds;
        uint256[] rescueOrders;
    }

    function mooncatToAcclimated(MoonCatDetails memory moonCatDetails) external{}
    function wrappedToAcclimated(MoonCatDetails memory moonCatDetails) external{}

    function mooncatToWrapped(MoonCatDetails memory moonCatDetails) external{}

    function acclimatedToWrapped(MoonCatDetails memory moonCatDetails) external{}

    function cryptopunkToWrapped(address punks, address wrappedPunk, address punkProxy, uint256[] memory tokenIds) external{}

    function wrappedToCryptopunk(address wrappedPunk, uint256[] memory tokenIds) external{}

    function ethToWeth(address weth, uint256 amount) external{}

    function wethToEth(address weth, uint256 amount) external{}
}