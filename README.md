# 小火箭节点提取器 🚀

一个简洁易用的iOS应用程序，用于获取和管理代理节点配置，支持一键导入Shadowrocket（小火箭）。

## 📱 应用截图

![应用界面](https://img.shields.io/badge/iOS-App-blue?style=flat-square&logo=apple)
![版本](https://img.shields.io/badge/版本-1.0-green?style=flat-square)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange?style=flat-square&logo=swift)

## ✨ 主要功能

- 🌐 **自动获取节点**: 从远程服务器自动获取最新的代理节点配置
- 📋 **一键复制**: 快速复制节点链接到剪贴板
- 🚀 **直接导入**: 支持一键导入到Shadowrocket应用
- 🎨 **精美界面**: 黄紫渐变背景，现代化UI设计
- ⚡ **实时更新**: 节点信息每日自动更新
- 🔄 **动画效果**: 流畅的淡入和弹簧动画

## 🛠 技术栈

- **开发语言**: Swift
- **UI框架**: UIKit
- **网络请求**: URLSession
- **布局方式**: Auto Layout (代码布局)
- **最低支持**: iOS 13.0+

## 📦 项目结构

```
Rocket/
├── AppDelegate.swift          # 应用程序委托
├── SceneDelegate.swift        # 场景委托
├── ViewController.swift       # 主视图控制器
├── Info.plist                # 应用配置文件
├── Assets.xcassets           # 资源文件
└── Base.lproj/              # 本地化资源
```

## 🚀 快速开始

### 环境要求

- Xcode 12.0 或更高版本
- iOS 13.0 或更高版本
- macOS 10.15 或更高版本

### 安装步骤

1. **克隆项目**
   ```bash
   git clone https://github.com/your-username/节点提取器.git
   cd 节点提取器
   ```

2. **打开项目**
   ```bash
   open Rocket.xcodeproj
   ```

3. **配置开发者账号**
   - 在Xcode中选择项目
   - 在"Signing & Capabilities"中配置你的开发者账号
   - 修改Bundle Identifier为你的唯一标识符

4. **运行应用**
   - 选择目标设备或模拟器
   - 点击运行按钮 (⌘+R)

## 📱 使用说明

### 基本操作

1. **启动应用**: 打开应用后会看到黄紫渐变的主界面
2. **获取节点**: 点击"开始提取"按钮获取最新节点
3. **复制链接**: 点击"复制"按钮将节点链接复制到剪贴板
4. **导入小火箭**: 点击"小火箭导入"直接导入到Shadowrocket应用

### 功能详解

#### 节点获取
- 应用会从 `https://rocket.xkcc.vip/get_history.php` 获取节点数据
- 支持JSON格式的响应解析
- 自动提取有效的HTTP/HTTPS链接

#### 界面元素
- **标题**: "小火箭节点提取器" - 带阴影效果的主标题
- **提取按钮**: 蓝色圆角按钮，触发节点获取
- **节点列表**: 动态生成的节点链接列表
- **操作按钮**: 每个节点配备复制和导入按钮
- **使用说明**: 底部显示详细的使用指南

## 🔧 自定义配置

### 修改API端点

如需更改节点数据源，请修改 `ViewController.swift` 中的URL：

```swift
guard let url = URL(string: "https://your-api-endpoint.com/api") else {
    print("无效的URL")
    return
}
```

### 自定义UI样式

#### 修改渐变背景色
```swift
gradientLayer.colors = [
    UIColor.your_color1.cgColor,
    UIColor.your_color2.cgColor
]
```

#### 调整按钮样式
```swift
extractButton.backgroundColor = UIColor.your_color
extractButton.layer.cornerRadius = your_radius
```

## 🔗 API接口说明

### 节点数据接口

**请求地址**: `https://rocket.xkcc.vip/get_history.php`

**请求方法**: GET

**响应格式**: JSON

**响应示例**:
```json
{
  "files": [
    {
      "links": [
        {
          "url": "ss://base64-encoded-config"
        },
        {
          "url": "vmess://base64-encoded-config"
        }
      ]
    }
  ]
}
```

## 🤝 贡献指南

欢迎提交Issue和Pull Request！

### 开发流程

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开Pull Request

### 代码规范

- 遵循Swift官方编码规范
- 使用有意义的变量和函数命名
- 添加必要的注释说明
- 保持代码简洁和可读性

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 📞 联系方式

- **开发者**: MacXK
- **微信**: Xcode-XK
- **创建日期**: 2025年4月20日

## ⚠️ 免责声明

本应用仅供学习和研究使用，请遵守当地法律法规。开发者不对使用本应用产生的任何后果承担责任。

## 🔄 更新日志

### v1.0 (2025-04-20)
- ✨ 初始版本发布
- 🎨 实现黄紫渐变UI界面
- 🌐 添加节点获取功能
- 📋 支持一键复制节点链接
- 🚀 集成Shadowrocket导入功能
- ⚡ 添加动画效果和用户反馈

---

**⭐ 如果这个项目对你有帮助，请给个Star支持一下！**
