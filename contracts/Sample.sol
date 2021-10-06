pragma solidity ^0.8.0;

// We need some util functions for strings.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "./libraries/Base64.sol";

contract Sample is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  event NewEpicNFTMinted(address sender, uint256 tokenId);

  constructor() ERC721("Sample", "SAMPLE") {
    console.log("This is my NFT contract. Woah!");
  }

  function _uint2str(uint256 _i) internal pure returns (string memory str) {
    if (_i == 0) {
      return "0";
    }
    uint256 j = _i;
    uint256 length;
    while (j != 0) {
      length++;
      j /= 10;
    }
    bytes memory bstr = new bytes(length);
    uint256 k = length;
    j = _i;
    while (j != 0) {
      bstr[--k] = bytes1(uint8(48 + (j % 10)));
      j /= 10;
    }
    str = string(bstr);
  }

  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  function constructNFT() public {
    uint256 newItemId = _tokenIds.current();

    bytes memory content = "";
    for (uint i = 0; i < 10; i++) {
      for (uint j = 0; j < 10; j++) {
        content = abi.encodePacked(content, rectStart, Strings.toString(j), rectAfterWidth, Strings.toString(i), rectAfterHeight, colors[random(string(abi.encodePacked(Strings.toString(i), Strings.toString(j), Strings.toString(newItemId)))) % colors.length], rectEnd);
      }
    }
    string memory svg = string(abi.encodePacked(svgStart, content, svgEnd));

    string memory json = string(
      abi.encodePacked('{"name":"sample #', _uint2str(newItemId), '","description":"sample nft","image":"data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '"}"'));

    string memory encodedJson = string(abi.encodePacked("data:application/json;base64,", json));

    console.log(encodedJson);

    _safeMint(msg.sender, newItemId);

    _setTokenURI(newItemId, encodedJson);

    _tokenIds.increment();

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    emit NewEpicNFTMinted(msg.sender, newItemId);
  }

  string constant svgStart =
    "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 10 10'>";
  string constant svgEnd = "</svg>";
  string constant rectStart = "<rect x='";
  string constant rectAfterWidth = "' y='";
  string constant rectAfterHeight = "' height='1' width='1' fill='";
  string constant rectEnd = "'/>";

  string[] colors = ['#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', '#008080', '#e6beff', '#9a6324', '#fffac8', '#800000', '#aaffc3', '#808000', '#ffd8b1', '#000075', '#808080', '#ffffff', '#000000'];
}
