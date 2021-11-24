pragma solidity ^0.8.0;

// We need some util functions for strings.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import { Pack } from "./libraries/Pack.sol";
import { Svg } from "./libraries/Svg.sol";
import { Common } from "./libraries/Common.sol";

contract Sample is ERC721Enumerable, Ownable {

  string _baseTokenURI;
  uint256 private _price = 0.06 ether;
  bool public _paused = true;

  constructor(string memory baseURI) ERC721("cheap", "C") {
    setBaseURI(baseURI);
  }

  function setBaseURI(string memory baseURI) public onlyOwner {
    _baseTokenURI = baseURI;
  }

  function setPrice(uint256 newPrice) public onlyOwner {
    _price = newPrice;
  }

  function setPause(bool val) public onlyOwner {
    _paused = val;
  }

  function create() public {
    uint256 supply = totalSupply();
    require(!_paused, "Sale paused");
    require(supply + 1 < 1000, "Exceeds maximum supply");
    require(msg.value >= _price, "Wrong price");

    _safeMint(msg.sender, supply);
  }

  function giveAway(address to) external onlyOwner {
    require(_reserved > 0, "No reserved give away");

    _safeMint(to, totalSupply());
    _reserved -= 1;
  }
}
