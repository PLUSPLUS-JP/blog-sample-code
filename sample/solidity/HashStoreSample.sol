pragma solidity ^0.4.16;

// -----------------------------------------------------------------------
// This program is to test how long GAS will take.
// Since operation guarantee can not be done at all, thank you.
//
// このプログラムは GAS がどれくらいかかるのかを実験するためのものです。
// 動作の保証は一切できませんので、宜しくお願い致します。
// -----------------------------------------------------------------------

contract HashStoreSample {

    struct Data {
        bytes32 hash;
        uint isExist;
    }

    address public owner;
    mapping(address => Data) private store;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // イベント
    event Store(address indexed _from, bytes32 hash);
    event Remove(address indexed _from);

    function HashStoreSample() public {
        // The owner address is maintained.
        owner = msg.sender;
    }

    // 内容照会
    function get(address _address) public view returns (bytes32) {
        return store[_address].hash;
    }

    // 保存
    function set(string value) public returns (bool) {
        bytes32 hash = keccak256(value);
        store[msg.sender].isExist = 1;
        store[msg.sender].hash = hash;
        emit Store(msg.sender, hash);
        return true;
    }

    // 削除
    function remove() public returns (bool) {
        // 値があること
        require(store[msg.sender].isExist == 1);
        delete store[msg.sender];
        emit Remove(msg.sender);
        return true;
    }

    // ---------------------------------------------
    // Destruction of a contract (only owner)
    // ---------------------------------------------
    function destory() public onlyOwner {
        selfdestruct(owner);
    }

}
