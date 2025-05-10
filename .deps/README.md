# USDKG/KGS Decentralized Exchange (DEX)

A minimal implementation of a DEX for swapping USDKG and KGS tokens with 1% fee.

## Features
- Swap between USDKG and KGS tokens
- Add/remove liquidity
- 1% transaction fee collected by contract owner
- Owner-controlled withdrawals

## Contracts
| Contract  | Description |
|-----------|-------------|
| `FakeUSDKG` | Test ERC20 token representing USDKG |
| `FakeKGS` | Test ERC20 token representing KGS |
| `SimpleDEX` | Exchange contract |

## Deployment
1. Deploy `FakeUSDKG.sol`
2. Deploy `FakeKGS.sol` 
3. Deploy `SimpleDEX.sol` with token addresses

## Usage

### Add Liquidity
```solidity
// Approve DEX to spend tokens
FakeUSDKG.approve(DEX_ADDRESS, AMOUNT);
FakeKGS.approve(DEX_ADDRESS, AMOUNT);

// Add equal values of both tokens
DEX.addLiquidity(AMOUNT_A, AMOUNT_B);