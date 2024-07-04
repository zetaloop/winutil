> [!WARNING]
> 该汉化正在制作中，请坐和放宽。

### **This is the Chinese Localization version of Winutil.<br>Original version see -> [ChrisTitusTech/winutil](https://github.com/ChrisTitusTech/winutil)**

# Chris Titus Tech 的 Windows 工具箱 - 汉化

[![版本](https://img.shields.io/github/v/release/zetaloop/winutil?color=7a39fb)](https://github.com/zetaloop/winutil/releases/latest)

这个工具箱综合了我（CTT）给每个新安装的 Windows 系统做的优化。它可以快速 *安装* 各类软件，*优化* 系统减少臃肿，解决 *配置* 问题，以及修复 Windows *更新*。该项目对各种贡献非常挑剔，以确保整洁高效。

![screen-install](screen-install.png)

## 用法

为了执行系统级的优化，Winutil 需要以管理员模式运行，请以管理员身份打开 PowerShell 或终端。以下是几种方法：

1. **右键方法：**
   - 右键单击开始按钮。
   - 选择 "Windows PowerShell (管理员)"（Win10）或 "终端 (管理员)"（Win11）.

2. **搜索方法：**
   - 按一下 Windows 徽标键。
   - 输入 "PowerShell" 或 "终端"（Win11）。
   - 按下 `Ctrl + Shift + Enter` 以管理员权限启动。


### 启动命令

#### 最简单的方法

```ps1
irm "https://christitus.com/win" | iex
```
参考该议题：[#144](https://github.com/ChrisTitusTech/winutil/issues/144)

如果该网站在您的地区不可用，请直接从 GitHub 运行。
```ps1
irm "https://github.com/zetaloop/winutil/releases/latest/download/winutil.ps1" | iex
```

如果仍有问题，请参考 [已知问题（英文）](https://github.com/ChrisTitusTech/winutil/blob/main/KnownIssues.md)。


#### 自动化

部分功能可以自动化执行。您可以保存一个配置文件，传给 Winutil 来执行。当您再次回来的时候，系统已完成优化。以下是是用 Winutil >24.01.15 自动化执行的方法：

1. 在安装页面中，点击 "获取已安装列表"，获取系统上所有已经安装的 **支持 Winutil 管理的这部分** 软件。
  ![GetInstalled](/wiki/Get-Installed.png)
2. 点击右上角齿轮图标，点击 "导出设置"，选择保存位置，即可导出设置文件。
  ![SettingsExport](/wiki/Settings-Export.png)
3. 把这个文件复制到 U 盘或别的 Windows 安装好后能访问的地方。
4. 使用 Microwin 功能创建自定义 Windows 镜像。
5. 安装这个 Windows 镜像。
6. 在新的 Windows 系统中，以管理员身份启动 PowerShell，运行命令来自动执行优化与安装软件。
```
iex "& { $(irm christitus.com/win) } -Config [path-to-your-config] -Run"
```
7. 喝杯咖啡，稍等就好！



## 支持
- 如果希望在道德和精神上支持这个项目，请务必留下一颗 ⭐️！[原项目传送门](https://github.com/ChrisTitusTech/winutil)
- 也可以用 10 美元购买 EXE 打包版：https://www.cttstore.com/windows-toolbox

## 教程（英文）

[![观看视频](https://img.youtube.com/vi/6UQZ5oQg8XA/hqdefault.jpg)](https://www.youtube.com/watch?v=6UQZ5oQg8XA)

## 概览

- 安装
  - 安装：软件已分门别类整理好，选中即可一键安装。

  - 全部更新：将所有现有软件更新到最新版本，确保用户拥有最新最好的软件。

  - 卸载：一键卸载所选软件，轻松移除不需要的软件。

  - 获取已安装列表：查找系统上已安装的软件，刷新列表。

  - 导入/导出：导入和导出程序选择列表，备份配置或与他人分享。您可在不同系统之间灵活管理软件。

- 优化
  - 推荐模式：为 PC、笔记本、轻量用户定制的优化模板，用户可以根据需求快速选择优化模式。

  - 基本优化：一些优化系统性能、隐私收集和资源利用的基本调整。包括创建系统还原点、禁用遥测、Wi-fi 感知、将系统后台服务设为手动、禁用位置跟踪、家庭组等。

  - 高级优化：一些专业用户用于深度优化系统的选项。包括删除 OneDrive 和 Edge、禁用 UAC（用户账户控制）、通知面板等。

  - 快速开关：一键开关暗色模式、开机打开数字锁定键、显示文件扩展名、粘滞键等功能。

  - 其他优化：一些其他调整，比如启用暗色模式、更改 DNS 设置、添加终极性能模式、创建 WinUtil 本工具的快捷方式，提供了额外的自定义选项。

- 配置
  - 组件：管理 Windows 的各种必要组件和增强功能。包括安装 .NET 框架、启用 Hyper-V 虚拟化、启用包含 Windows 媒体播放器与 DirectPlay 的旧版媒体支持、启用 NFS（网络文件系统）来进行网络文件共享、启用 WSL（Windows 上的 Linux 子系统）来运行 Linux 环境。

  - 修复：一些有用的修复功能，可用于解决常见问题和提高系统稳定性。包括设置自动登录、重置 Windows 更新来修复更新失败问题、执行系统损坏扫描来修复损坏的系统文件、重置网络设置来解决网络连接问题。

  - 旧版 Windows 面板：访问 Win7 的设置面板，找回那熟悉而强大的工具。包括管理系统设置的控制面板、管理网络适配器和连接的网络连接中心、调整电源和睡眠设置的电源选项、管理音频设备和设置的声音设置、查看和修改系统信息的系统属性、管理用户配置文件和账户设置的用户账户设置。


- 更新:
  - 默认（初始状态）设置：Windows 默认的更新设置。

  - 安全（推荐）设置：推荐的更新设置，功能更新推迟 2 年，安全更新在发布 4 天后安装。

  - 禁用一切更新（不推荐!）：禁用所有 Windows 更新，由于潜在的安全风险，不推荐这么做。


概览视频和文章：https://christitus.com/windows-tool/

## 问题

如果您在使用该脚本时遇到任何问题，恳请您通过 [GitHub 的 Issues 功能（英文）](https://github.com/ChrisTitusTech/winutil/issues)来汇报。您可以在模板中填写问题的具体细节，这样我可以及时解决软件错误或考虑功能请求。

## 贡献代码

现在拉取请求是直接在 main 分支中处理的，因为我们在 GitHub Release 中能够选择特定的版本。

如果您进行了改动，可以提交 PR 到 main 分支，但是注意我对代码十分挑剔。请勿使用格式化工具、进行大量行改动或一次做出多个功能改动。**每个功能改动都需要在单独的拉取请求中进行！**

创建拉取请求时，需要完整记录所做的所有改动。这包括记录任何新增的优化项，以及确保如果需要的话可以立即撤销该项优化。不遵守该格式可能导致拉取请求被拒绝。此外，所有代码更改都需要详尽的文档记录，缺乏文档的代码也可能被拒绝。

通过遵守这些规定，我们可以保持代码质量，确保代码库有组织、有记录。

注意：创建函数时，请在名称中包含 "WPF" 或 "WinUtil" 以便将其加载到运行空间中。

## 感谢所有贡献者
非常感谢您花费时间精力帮助 Winutil 成长，感激不尽！让我们继续努力 🍻。

[![贡献者](https://contrib.rocks/image?repo=ChrisTitusTech/winutil)](https://github.com/ChrisTitusTech/winutil/graphs/contributors)

## GitHub 统计（原项目）

![Alt](https://repobeats.axiom.co/api/embed/aad37eec9114c507f109d34ff8d38a59adc9503f.svg "原项目的 Repobeats 分析图像")
