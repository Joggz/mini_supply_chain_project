pragma solidity >=0.7.0 < 0.9.0;

library CryptoSuite {
    function splitSignature(bytes memory sig) internal pure returns(uint8 v, bytes32 r, bytes32 s){
        require(sig.length == 65);

        assembly {
             r := mload(add(sig, 32))

             s := mload(add(sig, 64))

             v := byte(0, mload(add(sig, 96)))
        }

        return (v, r, s);
    }
    function recoverSigner(bytes2 message, bytes memory sig) internal pure returns (address) {
        (uint8 v, bytes32 r, bytes32 s) = splitSignature(sig);

        return erecover(message, v, r, s);
    }
}