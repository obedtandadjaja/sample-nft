pragma solidity ^0.8.0;

import { Common } from "./Common.sol";

library Svg {

  // Finalize - wraps the svg with the svg tag wrapper.
  function finalize(
    uint32 height,
    uint32 width,
    bytes memory svgContent
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(
      "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 ",
      Common.uint2str(height),
      " ",
      Common.uint2str(width),
      "'>",
      svgContent,
      "</svg>"
    );
  }
}
