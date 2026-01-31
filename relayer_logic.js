const { ethers } = require("ethers");
require("dotenv").config();

async function signBridgeMessage(user, amount, nonce) {
    const wallet = new ethers.Wallet(process.env.RELAYER_PRIVATE_KEY);
    
    // Hash the data exactly as the smart contract does
    const messageHash = ethers.solidityPackedKeccak256(
        ["address", "uint256", "uint256"],
        [user, amount, nonce]
    );

    // Sign the hash
    const signature = await wallet.signMessage(ethers.toBeArray(messageHash));
    console.log("Generated Signature:", signature);
    return signature;
}

// Example usage
// signBridgeMessage("0xUserAddress...", ethers.parseEther("1.0"), 0);
