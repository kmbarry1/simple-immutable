pragma solidity =0.6.12;

contract Simple {
    uint256 public foo;
    constructor(uint256 value) public {
        foo = value;
    }
    function timesFoo(uint256 num) external view returns (uint256 retVal) {
        retVal = foo * num;
        require(num == 0 || retVal / num == foo, "overflow");
    }
}
