// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.8.4;
interface ICryptoPunks {

    struct Offer {
        bool isForSale;
        uint punkIndex;
        address seller;
        uint minValue;          // in ether
        address onlySellTo;     // specify to sell only to a specific person
    }

    function buyPunk(uint punkIndex) external payable;

    function punksOfferedForSale(uint punkIndex) external view returns(Offer memory offer);

    // Transfer ownership of a punk to another user without requiring payment
    function transferPunk(address to, uint punkIndex) external;
}

library GenieCryptoPunksMarket {


    // address public constant CRYPTOPUNKS = 0xb47e3cd837dDF8e4c57F05d70Ab865de6e193BBB;

    function buyAssetsForEth(address CRYPTOPUNKS, uint256[] memory punkIndexes, uint256[] memory prices, address recipient) public {
        for (uint256 i = 0; i < punkIndexes.length; i++) {
            _buyAssetForEth(CRYPTOPUNKS,punkIndexes[i], prices[i], recipient);
        }
    }

    function _buyAssetForEth(address CRYPTOPUNKS, uint256 _index, uint256 _price, address _recipient) internal {
        bytes memory _data = abi.encodeWithSelector(ICryptoPunks.buyPunk.selector, _index);
        (bool success, ) = CRYPTOPUNKS.call{value:_price}(_data);
        require(success,"buy asset failed");
        ICryptoPunks(CRYPTOPUNKS).transferPunk(_recipient, _index);
        
    }
}