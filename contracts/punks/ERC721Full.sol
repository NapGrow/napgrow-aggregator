// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



/**
 * @title Full ERC721 Token
 * @dev This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology.
 *
 * See https://eips.ethereum.org/EIPS/eip-721
 */
 
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./ERC721Metadata.sol";
contract ERC721Full is ERC721Enumerable, ERC721Metadata {

    constructor (string memory name, string memory symbol, string memory baseURI) ERC721Metadata(name, symbol) {
        // solhint-disable-previous-line no-empty-blocks
        _setBaseURI(baseURI);
    }
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return ERC721.supportsInterface(interfaceId) || ERC721Enumerable.supportsInterface(interfaceId);
    }
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal virtual override(ERC721Enumerable, ERC721) {
        ERC721Enumerable._beforeTokenTransfer(from,to,tokenId,1);

    }
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721Metadata) returns (string memory) {
        return ERC721Metadata.tokenURI(tokenId);
    }
    
    function mint(address to, uint256 tokenId) external {
       _safeMint(to, tokenId);
    }
}