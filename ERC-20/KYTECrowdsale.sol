pragma solidity ^0.5.0;

import "./KYTE.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract KYTECrowdsale is Crowdsale, MintedCrowdsale {
    constructor(
        uint rate,
        address payable wallet,
        KYTE token
    )
        Crowdsale(rate, wallet, token)
        public
    {
        // constructor body can stay empty
    }
}

contract KYTECrowdsaleDeployer {
    address public kyte_token_address;
    address public kyte_crowdsale_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
    )
        public
    {
        KYTE token = new KYTE(name, symbol, 0);
        kyte_token_address = address(token);

        KYTECrowdsale kyte_crowdsale = new KYTECrowdsale(1, wallet, token);
        kyte_crowdsale_address = address(kyte_crowdsale);

        token.addMinter(kyte_crowdsale_address);
        token.renounceMinter();
    }
}