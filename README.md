# Decentralized Token Bridge (Lock-and-Mint)

This repository provides an expert-level, streamlined implementation of a cross-chain bridge. It uses a **Lock-and-Mint** architecture, which is the industry standard for moving liquidity between Layer 1 and Layer 2 networks.



## Architecture & Logic
1. **Source Chain (Lock)**: The user deposits their tokens into the `BridgeVault`. These tokens are held in escrow.
2. **Relayer Service**: An off-chain service (script included) monitors the `Locked` event and signs a message authorizing a release on the destination chain.
3. **Destination Chain (Mint)**: The user (or relayer) submits the signed message to the `BridgeMint` contract, which verifies the signature and mints an equivalent "Wrapped" token.

## Security Features
* **ECDSA Signatures**: Prevents unauthorized minting. Only signatures from the authorized "Relayer" address are accepted.
* **Nonce Tracking**: Every bridge transaction has a unique ID to prevent replay attacks.
* **Emergency Stop**: Built-in circuit breakers for administrative control during volatile events.

## Quick Start
1. `npm install`
2. Update `.env` with your Relayer Private Key.
3. Deploy `BridgeVault.sol` to Chain A and `BridgeMint.sol` to Chain B.
