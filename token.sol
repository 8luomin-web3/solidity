// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract PremiumERC20 is ERC20, Ownable, ReentrancyGuard, ERC20Burnable, ERC20Permit, ERC20Capped {
    bool public mintDisabled;
    address public immutable fundWallet;

    event MintPermanentlyDisabled();
    error MintAlreadyDisabled();
    error InvalidFundWallet();

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 maxSupply_,
        uint256 initialSupply_,
        address fundWallet_
    ) ERC20(name_, symbol_) ERC20Capped(maxSupply_ * 10 ** decimals()) Ownable(msg.sender) ERC20Permit(name_) {
        if(fundWallet_ == address(0)) revert InvalidFundWallet();
        fundWallet = fundWallet_;
        
        uint256 initialMint = initialSupply_ * 10 ** decimals();
        require(initialMint <= maxSupply(), "Initial supply exceeds cap");
        _mint(fundWallet_, initialMint);
    }

    function mint(address to, uint256 amount) external onlyOwner nonReentrant {
        if(mintDisabled) revert MintAlreadyDisabled();
        _mint(to, amount);
    }

    function disableMintPermanently() external onlyOwner {
        mintDisabled = true;
        emit MintPermanentlyDisabled();
    }

    function _mint(address account, uint256 amount) internal override(ERC20, ERC20Capped) {
        super._mint(account, amount);
    }
}
