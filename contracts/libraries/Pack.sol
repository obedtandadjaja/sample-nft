pragma solidity ^0.8.0;

import { Base64 } from "./Base64.sol";

library Pack {

  // Pack - packs the svg content to NFT json metadata format, i.e. name,
  // description, image and encode everything in base64 format.
  function pack(
    string memory name,
    string memory description,
    bytes memory svg
  ) internal pure returns (string memory) {
    string memory json = string(
      abi.encodePacked(
        '{"name":"',
        name,
        '","description":"',
        description,
        '","image":"data:image/svg+xml;base64,',
        Base64.encode(svg),
        '"}"'
      )
    );

    return string(abi.encodePacked("data:application/json;base64,", json));
  }
}
