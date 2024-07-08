// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
 contract L1Storage {

    uint256 public num1;
    uint256 public num2;
    uint256 public num3;

    /**
     * @dev Store value in variable
     * @param nums values to store
     */
    function store(uint256[3] calldata nums) public {
        num1 = nums[0];
        num2 = nums[1];
        num3 = nums[2];
    }

    /**
     * @dev Return value
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256, uint256, uint256) {
        return (num1, num2, num3);
    }
}
