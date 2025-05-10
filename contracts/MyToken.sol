// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//Контракт для FakeUSDKG (аналог GoldDollar)

contract FakeUsdKG is ERC20 {
      constructor() ERC20("Fake USDKG", "fUSDKG") {
        _mint(msg.sender, 1_000_000 * 10**18); // 1M токенов для тестов
    }
}
//Контракт для FakeKGS (аналог KGS)
contract FakeKGS is ERC20 {
    constructor() ERC20("Fake KGS", "fKGS") {
        _mint(msg.sender, 1_000_000 * 10**18);
    }
}

//Простейший DEX с 1% комиссией для владелца контракта
contract SimpleDEX {
    IERC20 public tokenA; // фейк USDKG
    IERC20 public tokenB; // фейк KGS
    address public owner;
    uint256 public feePercent = 1; //1% комиссим
    
    constructor(address _tokenA, address _tokenB) {
        owner = msg.sender;
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }

    // Обмен фейк USDKG на фейк KGS
    event Swapped(address user, uint256 amount);
    function swapAToB(uint256 amount) public {
        require(tokenA.allowance(msg.sender, address(this)) >= amount, "Not approved");
        uint256 fee = (amount * feePercent) / 100;
        tokenA.transferFrom(msg.sender, owner, fee); // Комиссия владельцу
        tokenA.transferFrom(msg.sender, address(this), amount - fee);
        tokenB.transfer(msg.sender, amount); // Курс 1:1 для примера
    }

    // Добавление ликвидности для обмена
    function addLiquidity(uint256 amountA, uint256 amountB) public {
        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transferFrom(msg.sender, address(this), amountB);
    }
    function withdrawFees() public {
    require(msg.sender == owner, "Not owner");
    tokenA.transfer(owner, tokenA.balanceOf(address(this)));
}
function withdrawLiquidity(uint256 amountA, uint256 amountB) public {
    require(msg.sender == owner, "Not owner");
    tokenA.transfer(owner, amountA);
    tokenB.transfer(owner, amountB);
}
}