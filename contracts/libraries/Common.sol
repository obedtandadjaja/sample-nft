pragma solidity ^0.8.0;

library Common {

  // Uint2Str - converts uint to string
  function uint2str(uint256 _i) internal pure returns (string memory str) {
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

  // Random - returns a uint256 based on string input.
  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  function randomFrom(
    string memory input, uint256 numInput) internal pure returns (uint256) {
    return random(string(abi.encodePacked(input, uint2str(numInput))));
  }
}
