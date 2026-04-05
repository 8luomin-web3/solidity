# 企业级生产就绪 ERC20 代币合约

一个基于 OpenZeppelin 构建的安全、完整、可直接上线使用的高级 ERC20 代币合约，适用于各类区块链项目发行通证。

## 合约特性
✅ **发行上限（Capped）** - 设定最大总供应量，杜绝超发  
✅ **永久关停铸造** - 管理员可一键永久关闭 mint 功能  
✅ **代币燃烧（Burnable）** - 支持持有人/管理员销毁代币  
✅ **离线授权（Permit）** - 支持 EIP-2612，无需 Gas 完成授权  
✅ **重入攻击防护** - 内置 ReentrancyGuard 安全保障  
✅ **所有权管理** - 仅Owner可执行敏感操作  
✅ **初始分配** - 部署时自动向指定资金钱包发行初始代币  

## 合约部署参数
```solidity
constructor(
    string memory name_,        // 代币名称
    string memory symbol_,      // 代币符号
    uint256 maxSupply_,         // 最大发行量（无需手动乘小数位）
    uint256 initialSupply_,     // 初始发行量（无需手动乘小数位）
    address fundWallet_         // 初始代币接收钱包
)
