// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "./interfaces/ITrap.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract WhaleTransferTrap is ITrap {
    // SSV Token contract on Hoodi
    address public constant TOKEN = 0x9F5d4Ec84fC4785788aB44F9de973cF34F7A038e;
    // Top whale address you found
    address public constant WHALE = 0x929C3Ed3D1788C4862E6b865E0E02500DB8Fd760;
    // Threshold in SSV (adjust to taste, here = 1000 SSV)
    uint256 public constant THRESHOLD = 1000 * 1e18;

    function collect() external view override returns (bytes memory) {
        uint256 bal = IERC20(TOKEN).balanceOf(WHALE);
        return abi.encode(bal);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length < 2) return (false, "");

        uint256 prev = abi.decode(data[data.length - 2], (uint256));
        uint256 latest = abi.decode(data[data.length - 1], (uint256));

        if (prev > latest && (prev - latest) >= THRESHOLD) {
            return (true, abi.encode(prev, latest, prev - latest));
        }

        return (false, "");
    }
}
