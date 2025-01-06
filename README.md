# PyPI

## Usage

```yaml
- uses: loong64/pypi@master
  with:
    # [PyPI repository](https://pypi.org/)
    # package name
    app_name: cffi
    # package version
    app_version: latest
```


## 项目说明（暂）

```sh
.
├── action.yml                  # 任务流程控制 
├── build-ci.sh                 # 对应 CIBW_BEFORE_ALL_LINUX
├── project
│   ├── package                 # 包名称, 如 cffi, pillow
│   │   ├── latest              # 版本号, 默认情况下会每日构建 latest 版本
│   │   │   ├── abi             # 对于适配了 abi3 的项目可以指定, 对应 CIBW_BUILD
│   │   │   ├── env             # 构建中载入额外的环境变量, 对应 CIBW_ENVIRONMENT_LINUX
│   │   │   ├── python          # 正常情况下不需要, 对应 CIBW_PROJECT_REQUIRES_PYTHON
│   │   │   └── requirements
│   │   │       ├── rpm         # 定义依赖包, 如果依赖包不存在可以通过调用 scripts/build.sh 从源代码编译, 被 build-ci.sh 调用
│   │   │       └── rust        # 如果存在此文件则表示需要 rust, 被 build-ci.sh 调用
│   │   │   └── scripts
│   │   │       ├── build.sh    # 编译前执行的命令, 被 build-ci.sh 调用
│   │   │       └── prepare.sh  # 外部初始化脚本, 比如 pyyaml 项目中需要先编译 libyaml
│   │   └── README.md           # 当 package 说明文档
├── README.md
└── scripts                     # 通用脚本库
```

```log
┌────────────────┐
│    ci.yml      │ ◄─── GitHub Actions
└───────┬────────┘      (每日触发)
        │
        ▼
┌────────────────┐
│   action.yml   │ ◄─── 加载模板任务
└───────┬────────┘
        │
        ▼
┌────────────────┐
│   get sdist    │ ◄─── 下载源码包并解压
└───────┬────────┘      (检查版本是否已构建)
        │
        ▼
┌────────────────┐
│   prepare.sh   │ ◄─── 如果存在则执行
└───────┬────────┘      (外部初始化)
        │
        ▼
┌────────────────┐
│ check prepare  │ ◄─── 检查 version/abi/python/env
└───────┬────────┘      (CIBW_*)
        │
        ▼
┌────────────────┐
│  build-ci.sh   │ ◄─── CIBW_BEFORE_ALL_LINUX
└───────┬────────┘
        │
        ├─────────┐
        ▼         ▼
┌──────────┐ ┌──────────┐
│   rpm    │ │   rust   │ ◄─── 安装依赖
└────┬─────┘ └────┬─────┘      (系统包/Rust)
     │            │
     └───────┐    │
             ▼    ▼
     ┌────────────────┐
     │    build.sh    │ ◄─── 如果存在则执行
     └───────┬────────┘      (编译依赖)
             │
             ▼
     ┌────────────────┐
     │  wheels build  │ ◄─── cibuildwheel
     └───────┬────────┘      (自动构建和打包)
             │
             ▼
     ┌────────────────┐
     │ wheels upload  │ ◄─── GitLab PyPI
     └────────────────┘      (上传制品)
```