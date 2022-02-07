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

        return ecrecover(message, v, r, s);
    }
}

contract ColdChain {
    enum CertificateStatus { MANFACTURED, STORED, DELIVERED,DELIVERED_LOCAL, DELIVERED_INTERNATIONAL, VACCINATED }
    struct Certificate {
        uint id;
        Entity issuer;
        Entity prover;
        bytes signature;
        Status status;
    }

    enum Mode { ISSUER, PROVER, VERIFIER}
    struct Entity {
        address id;
        Mode mode;
        uint[] certificateIds;
        Status status;
    }
    struct VaccinateBatch {
        uint id;
        string brand;
        address manufacturer;
        uint[] certificateIds;
    }
    uint public constant MAX_CERTIFICATIONs = 2;
    uint[] public certificateIds;
    uint[] public vaccineBatchIds;

    mapping (uint => VaccineBatch) public vaccineBatches;
    mapping(uint => Certificate) public certificates;
      mapping(address => Entity) public entities;


    event AddEntity(address entityId, string entityMode);
        event AddVaccineBatch(uint vaccineBatchId, address indexed manufacturer);
    event IssueCertificate(address indexed issuer, address prover, uint certificateId);


}