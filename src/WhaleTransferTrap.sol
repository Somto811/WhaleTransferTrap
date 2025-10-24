// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "./interfaces/ITrap.sol";


interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract WhaleTransferTrap is ITrap {
    /// --- CONFIGURATION ---
    /// Token contract to monitor
    address public constant TOKEN = 0x9F5d4Ec84fC4785788aB44F9de973cF34F7A038e;

    /// Whale address to monitor
    address public constant WHALE = 0x929C3Ed3D1788C4862E6b865E0E02500DB8Fd760;

    /// Use Basis Points instead of fixed 1000 * 1e18
    /// e.g. 5000 = 50% of whale's previous balance minimum
    uint256 public constant DROP_THRESHOLD_BPS = 500; // 5% default

   
    function collect() external pure override returns (bytes memory) {
        // No balance reads – just return empty.
        // Drosera collects logs off-chain & passes to shouldRespond.
        return "";
    }

    function shouldRespond(bytes[] calldata data)
        external
        pure
        override
        returns (bool, bytes memory)
    {
        if (data.length == 0) return (false, "");

        uint256 largest = 0;
        address recipient = address(0);
        bool found = false;

        for (uint256 i = 0; i < data.length; i++) {
            // Minimum expected: (address from, address to, uint256 value)
            (address from, address to, uint256 value) = abi.decode(data[i], (address, address, uint256));

            if (from == WHALE) {
                if (value > largest) {
                    largest = value;
                    recipient = to;
                    found = true;
                }
            }
        }

        if (found) {
            return (true, abi.encode(WHALE, recipient, largest));
        }

        return (false, "");
    }
}
