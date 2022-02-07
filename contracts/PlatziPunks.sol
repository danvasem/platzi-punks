// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//ERC721Enumerable is required to support navigation from the web interface of our project
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
//For counters
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";
import "./PlatziPunksDNA.sol";

contract PlatziPunks is ERC721, ERC721Enumerable, PlatziPunksDNA {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _idCounter;
    uint256 public maxSupply;
    mapping(uint256 => uint256) public tokenDNA;

    constructor(uint256 _maxSupply) ERC721("PlatziPunks", "PLPKS") {
        maxSupply = _maxSupply;
    }

    //This function is VIEW because we do not need to modify data, we just "calculate" the response
    //also, this allows to be more efficient with the gas used by the contract excution.
    //If you want to make the token compatible with Opensea: https://docs.opensea.io/docs/metadata-standards
    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721 Metadata: URI query for nonexistent token"
        );
        uint256 dna = tokenDNA[tokenId];
        string memory image = imageByDNA(dna);
        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{"name":"PlatziPunks #',
                tokenId.toString(),
                '", "description":"Platzi Avatars"',
                ',"image":"',
                image,
                '"}'
            )
        );
        return
            string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }

    //the function _mint() exists in contract ERC721 but is internal,
    //so we need to implement our function and call _mint() from it
    function mint() public {
        uint256 current = _idCounter.current();
        require(current < maxSupply, "No PLatziPunks left :(");

        //Here we obteain a "unique" DNA for this TokenId and save it in our array of tokens' DNA
        tokenDNA[current] = deterministicPseudoRandomDNA(current, msg.sender);

        //Though you can just use a counter to get tokenid, it is better to use the openzeppelin utilities for this.
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://avataaars.io/";
    }

    function _paramsURI(uint256 _dna) internal view returns (string memory) {
        string memory params;

        params = string(
            abi.encodePacked(
                "accessoriesType=",
                getAccessoriesType(_dna),
                "&clotheColor=",
                getClotheColor(_dna),
                "&clotheType=",
                getClotheType(_dna),
                "&eyeType=",
                getEyeType(_dna),
                "&eyebrowType=",
                getEyeBrowType(_dna),
                "&facialHairColor=",
                getFacialHairColor(_dna),
                "&facialHairType=",
                getFacialHairType(_dna),
                "&hairColor=",
                getHairColor(_dna),
                "&hatColor=",
                getHatColor(_dna),
                "&graphicType=",
                getGraphicType(_dna),
                "&mouthType=",
                getMouthType(_dna),
                "&skinColor=",
                getSkinColor(_dna)
            )
        );

        return params;
    }

    //This function allows to be called for pre-visualization of a PlatziPunk no minted yet
    function imageByDNA(uint256 _dna) public view returns (string memory) {
        string memory baseURI = _baseURI();
        string memory paramsURI = _paramsURI(_dna);

        return string(abi.encodePacked(baseURI, "?", paramsURI));
    }

    //Override required
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
