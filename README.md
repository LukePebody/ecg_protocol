# ECG Protocol

Shared networking protocol for ECG (Every Card Game) applications.

This repository contains the shared communication protocol used between:
- `ecg_table` (table/host application)  
- `ecg_hand` (hand/client application)

## Usage

This repository is included as a Git submodule in both ECG applications.

## Structure

- `messages/` - Message type definitions and serialization
- `network/` - Network connection and protocol handling
- `models/` - Shared data models for cards, game state, etc.
