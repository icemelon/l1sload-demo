// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;

import {IL1Blocks} from "./IL1Blocks.sol";

/**
 * @title L2Storage
 * @dev L2Storage retrieves value from L1Storage contract
 */
contract L2Storage {
    address constant L1_BLOCKS_ADDRESS = 0x5300000000000000000000000000000000000001;
    address constant L1_SLOAD_ADDRESS = 0x0000000000000000000000000000000000000101;
    uint256 constant NUMBER_SLOT = 0;
    address immutable l1StorageAddr;

    event L1BlockNumber(uint256 number);
    event RetrievedNumber(uint256 number);

    constructor(address _l1Storage) {
        l1StorageAddr = _l1Storage;
    }

    function latestL1BlockNumber() public returns (uint256) {
        uint256 l1BlockNum = IL1Blocks(L1_BLOCKS_ADDRESS).latestBlockNumber();
        emit L1BlockNumber(l1BlockNum);
        return l1BlockNum;
    }

    function retrieveFromL1() public returns (uint256) {
        uint256 l1BlockNum = IL1Blocks(L1_BLOCKS_ADDRESS).latestBlockNumber();
        bytes memory input = abi.encodePacked(l1BlockNum, l1StorageAddr, NUMBER_SLOT);
        bool success;
        bytes memory ret;
        (success, ret) = L1_SLOAD_ADDRESS.call(input);
        if (success) {
            uint256 number;
            (number) = abi.decode(ret, (uint256));
            emit RetrievedNumber(number);
            return number;
        } else {
            revert("L1SLOAD failed");
        }
    }
}
