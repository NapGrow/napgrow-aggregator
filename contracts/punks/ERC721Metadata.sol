// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract ERC721Metadata is ERC721 {
    using Strings for uint256;


    // Base URI
    string private _baseuri;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {

    }
    /**
     * @dev Returns the URI for a given token ID. May return an empty string.
     *
     * If a base URI is set (via {_setBaseURI}), it is added as a prefix to the
     * token's own URI (via {_setTokenURI}).
     *
     * If there is a base URI but no token URI, the token's ID will be used as
     * its URI when appending it to the base URI. This pattern for autogenerated
     * token URIs can lead to large gas savings.
     *
     * .Examples
     * |===
     * |`_setBaseURI()` |`_setTokenURI()` |`tokenURI()`
     * | ""
     * | ""
     * | ""
     * | ""
     * | "token.uri/123"
     * | "token.uri/123"
     * | "token.uri/"
     * | "123"
     * | "token.uri/123"
     * | "token.uri/"
     * | ""
     * | "token.uri/<tokenId>"
     * |===
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function tokenURI(uint256 tokenId) public view override virtual returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];

        // If there is no base URI, return the token URI.
        if (bytes(_baseuri).length == 0) {
            return _tokenURI;
        }

        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(_baseuri, _tokenURI));
        }

        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(_baseuri, tokenId.toString()));
    }

    /**
     * @dev Internal function to set the token URI for a given token.
     *
     * Reverts if the token ID does not exist.
     *
     * TIP: if all token IDs share a prefix (e.g. if your URIs look like
     * `http://api.myproject.com/token/<id>`), use {_setBaseURI} to store
     * it and save gas.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");

        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev Internal function to set the base URI for all token IDs. It is
     * automatically added as a prefix to the value returned in {tokenURI}.
     *
     * _Available since v2.5.0._
     */
    function _setBaseURI(string memory _baseURI) internal {
        _baseuri = _baseURI;
    }

    /**
     * @dev Returns the base URI set via {_setBaseURI}. This will be
     * automatically added as a preffix in {tokenURI} to each token's URI, when
     * they are non-empty.
     *
     * _Available since v2.5.0._
     */
    function baseURI() public view returns (string memory) {
        return _baseuri;
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(tokenId);

        // Clears metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }

}