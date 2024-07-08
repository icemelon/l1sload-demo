// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;

import {IL1Blocks} from "./IL1Blocks.sol";

/**
 * @title L2Storage
 * @dev L2Storage retrieves values from L1Storage contract
 */
 contract L2Storage {
    address constant L1_SLOAD_ADDRESS = 0x0000000000000000000000000000000000000101;
    uint256 constant NUM1_SLOT = 0;
    uint256 constant NUM2_SLOT = 1;
    uint256 constant NUM3_SLOT = 2;
    address immutable l1StorageAddr;

    event RetrievedNumbers(uint256 num1, uint256 num2, uint256 num3);

    constructor(address _l1Storage) {
        l1StorageAddr = _l1Storage;
    }

    function loadFromL1() public returns (uint256, uint256, uint256) {
        (bool success, bytes memory ret) = L1_SLOAD_ADDRESS.staticcall(
            abi.encodePacked(l1StorageAddr, NUM1_SLOT, NUM2_SLOT, NUM3_SLOT)
        );
        if (!success) {
            revert("L1SLOAD failed");
        }
        (uint256 num1, uint256 num2, uint256 num3) = abi.decode(ret, (uint256, uint256, uint256));
        emit RetrievedNumbers(num1, num2, num3);
        return (num1, num2, num3);
    }
