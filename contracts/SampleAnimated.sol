pragma solidity ^0.8.0;

// We need some util functions for strings.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Pack } from "./libraries/Pack.sol";
import { Svg } from "./libraries/Svg.sol";
import { Common } from "./libraries/Common.sol";

contract SampleAnimated is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  event NewEpicNFTMinted(address sender, uint256 tokenId);

  constructor() ERC721("Sample", "SAMPLE") {
    console.log("This is my NFT contract. Woah!");
  }

  function constructNFT() public {
    uint256 newItemId = _tokenIds.current();

    bytes memory svg = Svg.finalize(
      10,
      10,
      abi.encodePacked(
        "<rect width='10' height='10'><animate attributeName='rx' values='0;5;0' dur='",
        Common.uint2str(Common.randomFrom("ANIMATE", newItemId) % 10 + 1),
        "s' repeatCount='indefinite'/></rect>"
      )
    );

    console.log(string(svg));

    string memory encodedJson = Pack.pack(
      string(abi.encodePacked("sample #", Common.uint2str(newItemId))),
      "sample nft",
      svg
    );

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
