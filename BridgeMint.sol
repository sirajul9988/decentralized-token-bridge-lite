// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeMint is ERC20, Ownable {
    using ECDSA for bytes32;
    address public relayer;
    mapping(uint256 => bool) public processedNonces;

    constructor(address _relayer) ERC20("Wrapped Token", "wTKN") Ownable(msg.sender) {
        relayer = _relayer;
    }

    function mint(address user, uint256 amount, uint256 nonce, bytes calldata signature) external {
        require(!processedNonces[nonce], "Transfer already processed");
        
        bytes32 messageHash = keccak256(abi.encodePacked(user, amount, nonce));
        bytes32 ethSignedMessageHash = messageHash.toEthSignedMessageHash();
        
        require(ethSignedMessageHash.recover(signature) == relayer, "Invalid signature");

        processedNonces[nonce] = true;
        _mint(user, amount);
    }
}
