pragma solidity ^0.8.0;

//import "@jbx-protocol/contracts-v2/contracts/interfaces/IJBPayDelegate.sol";
import './interfaces/IJBPayDelegate.sol';
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTRewards is ERC721URIStorage, IJBPayDelegate  {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 constant BRONZE  = 1000000000000000;
    uint256 constant SILVER  = 10000000000000000;
    uint256 constant GOLD    = 1000000000000000000;

    constructor() ERC721("StudioRewards", "STDIOR") {}

    function didPay(JBDidPayData calldata _param) public override {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(_param.payer, newItemId);
        if (_param.amount < BRONZE) {
            _setTokenURI(newItemId, "https://gateway.pinata.cloud/ipfs/QmV4eDCDfYoaBcCoTU6ce9DSq2SFv4dEm7c8wkBEdWYVVD");
        } else if (_param.amount >= BRONZE && _param.amount < SILVER) {
            _setTokenURI(newItemId, "https://gateway.pinata.cloud/ipfs/QmY9T2yY65aCrASiwRuH98NxyQTbceSWuM5A1Mmg3S9CHA");
        } else if (_param.amount >= SILVER && _param.amount < GOLD) {
            _setTokenURI(newItemId, "https://gateway.pinata.cloud/ipfs/QmXupnWuoCF18ZX4CJcHZTVc5GjkYWorXqjypnEGSpaM3d");
        } else if (_param.amount >= GOLD) {
            _setTokenURI(newItemId, "https://gateway.pinata.cloud/ipfs/QmdkHedPr3et5kKQELy56M1fQvLBvPF9KkuTK9dTtpFRjg");
        }
        
    }
    
}
