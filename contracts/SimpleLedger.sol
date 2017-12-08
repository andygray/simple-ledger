pragma solidity ^0.4.11;


contract SimpleLedger {

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    address public owner;

    event SimpleLedgerEntry(bytes2 indexed _entity, int256 _amount);

    // entity -> amount
    // for example: "AB" -> 999
    mapping (bytes2 => int256) public ledger;

    function SimpleLedger() {
        owner = msg.sender;
    }

    function recordEntry(bytes2 _entity, int256 _amount) onlyOwner public {
        ledger[_entity] = _amount;
        SimpleLedgerEntry(_entity, _amount);
    }

    function readEntry(bytes2 _entity) constant returns (bytes2 entity, int256 amount) {
        return (_entity, ledger[_entity]);
    }
}