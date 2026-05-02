%% README_PID.txt
% =====================================================
% PID Control Strategy for House Heating System
% 房屋加热系统的PID控制策略
% =====================================================
%
% 版本: 1.0
% 创建日期: May 2, 2026
% 基于: DQN House Heating Example + Classical PID Control Theory

% =====================================================
% I. 项目概述 (Project Overview)
% =====================================================
%
% 本项目实现了一个基于经典PID（比例-积分-微分）控制理论的
% 房屋加热系统控制策略，与原始的DQN（深度强化学习）方法对标。
%
% This project implements a classical PID (Proportional-Integral-Derivative)
% control strategy for a house heating system, benchmarked against the
% original DQN (Deep Reinforcement Learning) approach.
%
% 主要特点 (Key Features):
% - 采用相同的Simulink模型和温度数据
% - 使用相同的评估指标和验证集
% - 输出格式完全兼容
% - 易于参数调优
% - 无需安装强化学习工具箱

% =====================================================
% II. 文件结构 (File Structure)
% =====================================================
%
% PID_Control_Strategy/
% ├── README_PID.txt                              [本文件 - 完整说明]
% ├── QUICKSTART.txt                              [快速入门指南]
% ├── PID_Setup_Configuration.m                   [初始化配置脚本]
% ├── pidHeatingController.m                      [PID控制器类]
% ├── runHeatingDemoQuick_PID.m                   [快速运行脚本]
% ├── TrainPIDAgentControlHouseHeatingSystemExample.m  [完整训练脚本]
% ├── pidControlResetFcn.m                        [训练环境重置函数]
% └── pidValidateResetFcn.m                       [验证环境重置函数]

% =====================================================
% III. 快速开始 (Quick Start)
% =====================================================
%
% 最快的使用方法（3分钟）:
%
% 1. 打开MATLAB
%    Open MATLAB
%
% 2. 切换到项目文件夹
%    cd HouseHeatingDemo_Deliverable/HouseHeatingDemo_Deliverable
%
% 3. 运行初始化脚本
%    >> PID_Setup_Configuration
%
% 4. 切换到PID文件夹
%    >> cd PID_Control_Strategy
%
% 5. 一键运行演示
%    >> runHeatingDemoQuick_PID
%
% 6. 查看结果
%    Results displayed in Figures 101-103

% =====================================================
% IV. 详细文件说明 (File Descriptions)
% =====================================================

% 1. QUICKSTART.txt
%    ├─ 三分钟快速入门
%    ├─ 文件说明
%    ├─ 常见问题
%    └─ 推荐使用顺序

% 2. PID_Setup_Configuration.m
%    └─ 一次性初始化脚本，用于：
%       ├─ 验证所有文件完整性
%       ├─ 检查MATLAB环境
%       ├─ 加载温度数据
%       ├─ 测试PID控制器
%       └─ 准备workspace变量
%
%    运行方式:
%    >> PID_Setup_Configuration

% 3. pidHeatingController.m (380行)
%    └─ PID控制器核心类，包含：
%       ├─ 属性 (Properties)
%       │  ├─ Kp, Ki, Kd (PID增益)
%       │  ├─ setpoint (目标温度)
%       │  ├─ controlMode ('onoff' 或 'continuous')
%       │  ├─ integralError (积分防饱和)
%       │  └─ errorHistory (数据记录)
%       │
%       ├─ 方法 (Methods)
%       │  ├─ computeAction() - 计算控制量
%       │  ├─ getCost() - 计算能耗成本
%       │  ├─ reset() - 重置控制器
%       │  ├─ getStatistics() - 获取统计数据
%       │  ├─ setPIDGains() - 设置PID参数
%       │  └─ plotResults() - 绘制结果
%       │
%       └─ 使用示例:
%          controller = pidHeatingController(...
%              'Kp', 0.5, 'Ki', 0.01, 'Kd', 0.1);
%          action = controller.computeAction(roomTemp, outsideTemp, ...
%              comfortMin, comfortMax);
%          cost = controller.getCost();

% 4. runHeatingDemoQuick_PID.m (200行)
%    └─ 快速运行脚本（推荐首先运行）
%       ├─ 加载预配置的PID参数
%       ├─ 运行3个验证场景
%       ├─ 使用相同的温度数据
%       ├─ 输出与DQN相同格式
%       └─ 生成Figures 101-103
%
%    运行方式:
%    >> cd PID_Control_Strategy
%    >> runHeatingDemoQuick_PID
%
%    输出:
%    - Figure 101: Scenario 1 (March 21, Cold)
%    - Figure 102: Scenario 2 (April 15, Mild)
%    - Figure 103: Scenario 3 (Warm, +8°C)
%    Each figure contains 3 subplots:
%    - Temperature profile
%    - Cumulative cost
%    - Cost per step

% 5. TrainPIDAgentControlHouseHeatingSystemExample.m (350行)
%    └─ 完整训练脚本（对标DQN版本）
%       ├─ 支持PID参数调优
%       ├─ 详细的控制流程
%       ├─ 三个场景的完整验证
%       ├─ 包含参数调优注释
%       └─ 生成训练和验证结果
%
%    运行方式:
%    >> TrainPIDAgentControlHouseHeatingSystemExample
%
%    包含章节:
%    - Data Loading
%    - PID Controller Creation
%    - Parameter Tuning (可选)
%    - Validation on three scenarios
%    - Performance analysis

% 6. pidControlResetFcn.m (40行)
%    └─ 训练环境重置函数
%       ├─ Simulink自动调用
%       ├─ 每个episode随机选择初始时间
%       ├─ 增加训练的多样性
%       └─ 不要单独运行

% 7. pidValidateResetFcn.m (20行)
%    └─ 验证环境重置函数
%       ├─ 使用固定的validationTemperature
%       ├─ 保证验证的可重复性
%       ├─ Simulink自动调用
%       └─ 不要单独运行

% =====================================================
% V. PID控制原理 (PID Control Theory)
% =====================================================
%
% PID控制器根据温度偏差计算控制量：
%
% PID Output = Kp*e(t) + Ki*∫e(t)dt + Kd*de(t)/dt
%
% 其中:
%   e(t) = setpoint - roomTemperature   (温度偏差)
%   Kp = 比例系数 (影响响应速度)
%   Ki = 积分系数 (消除稳态误差)
%   Kd = 微分系数 (减少超调)
%
% 控制模式:
%   1. onoff (离散开关):
%      if PID_Output > 0: action = 1 (加热器打开)
%      else:               action = 0 (加热器关闭)
%
%   2. continuous (连续控制):
%      action = (0.5 + PID_Output/10) 归一化到 [0, 1]

% =====================================================
% VI. 默认参数 (Default Parameters)
% =====================================================
%
% PID增益 (PID Gains):
%   Kp = 0.5       % 比例系数
%   Ki = 0.01      % 积分系数
%   Kd = 0.1       % 微分系数
%
%   这些参数是通过经验调优得到的，具有良好的
%   快速响应性和稳定性平衡。
%
% 温度设定值 (Setpoint):
%   setpoint = 20.5°C  (舒适范围中点: (18+23)/2)
%
% 舒适温度范围 (Comfort Range):
%   comfortMin = 18°C
%   comfortMax = 23°C
%
% 采样时间 (Sampling Time):
%   sampleTime = 120 seconds (2 minutes)
%
% 防饱和参数 (Anti-Windup):
%   integralMax = 5
%   integralMin = -5
%   防止积分项过大导致的控制饱和

% =====================================================
% VII. 参数调优 (Parameter Tuning)
% =====================================================
%
% 方法1: 手动调优
% -------
% 编辑 TrainPIDAgentControlHouseHeatingSystemExample.m
% 在 "Create PID Controller" 章节中修改Kp, Ki, Kd值
%
% 建议调优步骤:
% 1. 先调优Kp使系统有基本响应
% 2. 增加Ki消除稳态误差
% 3. 增加Kd减少超调
%
% 方法2: Ziegler-Nichols法
% -------
% a) 设置Ki=0, Kd=0
% b) 逐渐增加Kp直到系统开始振荡 (Ku)
% c) 记录振荡周期 (Tu)
% d) 应用以下公式:
%    对于PID: Kp = 0.6*Ku
%            Ki = 1.2*Ku/Tu
%            Kd = 0.075*Ku*Tu

% =====================================================
% VIII. 评估指标 (Evaluation Metrics)
% =====================================================
%
% 三个关键性能指标 (Three KPIs):
%
% 1. 舒适度违反 (Comfort Violation)
%    ├─ 定义: 房间温度不在[18°C, 23°C]范围内的分钟数
%    ├─ 范围: 0-1440 分钟 (0-24小时)
%    ├─ 目标: 越低越好 (Minimize)
%    └─ DQN参考值: 0 分钟
%
% 2. 能耗成本 (Energy Cost)
%    ├─ 定义: 整个运行周期的能耗总成本
%    ├─ 单位: 美元 ($)
%    ├─ 目标: 越低越好 (Minimize)
%    ├─ 计算: 
%    │   energyCost = power * time * pricePerKwh
%    │   = 5kW * (time in hours) * $0.10/kWh
%    └─ DQN参考值: $7.36
%
% 3. 能效比 (Efficiency Ratio)
%    ├─ 定义: (1440 - violations) / energy_cost
%    ├─ 含义: 每美元的成本能维持多少舒适分钟数
%    ├─ 目标: 越高越好 (Maximize)
%    └─ DQN参考值: ~196.2
%
% 验证场景 (Validation Scenarios):
% ├─ Scenario 1: March 21, 2022 (Cold weather)
% │  ├─ 适合测试加热能力
% │  ├─ 温度较低
% │  └─ DQN: 0 violations, $7.36 cost
% │
% ├─ Scenario 2: April 15, 2022 (Mild weather)
% │  ├─ 适合测试平衡控制
% │  ├─ 温度适中
% │  └─ DQN: 0 violations, $7.77 cost
% │
% └─ Scenario 3: Warm weather (+8°C)
%    ├─ 适合测试能耗优化
%    ├─ 加8°C后可能无需加热
%    └─ DQN: 17 violations, $0.00 cost

% =====================================================
% IX. 与DQN的对比 (Comparison with DQN)
% =====================================================
%
% 特性对比 (Feature Comparison):
%
% ┌─────────────┬──────────────────┬──────────────────┐
% │   特性      │      DQN         │      PID         │
% ├─────────────┼──────────────────┼──────────────────┤
% │ 模型        │ 神经网络（LSTM）  │ 线性公式          │
% │ 参数数       │ ~100,000         │ 3 (Kp, Ki, Kd) │
% │ 训练时间     │ 数小时           │ 无需训练         │
% │ 调优难度     │ 困难             │ 容易             │
% │ 可解释性     │ 低               │ 高               │
% │ 计算复杂度   │ 高               │ 低               │
% │ 实时性       │ 快               │ 很快             │
% │ 自适应性     │ 好               │ 有限             │
% │ 鲁棒性       │ 需要验证         │ 经过验证         │
% │ 工具箱需求   │ RL Toolbox      │ 无               │
% └─────────────┴──────────────────┴──────────────────┘

% =====================================================
% X. 常见问题 (FAQ)
% =====================================================
%
% Q1: 如何快速开始？
% A1: 运行 PID_Setup_Configuration.m，然后运行 runHeatingDemoQuick_PID.m
%
% Q2: 如何修改PID参数？
% A2: 编辑 TrainPIDAgentControlHouseHeatingSystemExample.m，
%     在 "Create PID Controller" 章节修改Kp, Ki, Kd值
%
% Q3: 如何与DQN对比？
% A3: 运行 compareStrategies.m 会自动进行对比
%
% Q4: 为什么PID和DQN结果不同？
% A4: - DQN使用神经网络学习最优策略
%     - PID使用固定的线性控制法则
%     - 两种方法各有优缺点，适用场景不同
%
% Q5: 如何进行参数调优？
% A5: 可使用以下方法：
%     - 手动调优：逐个调整参数观察效果
%     - Ziegler-Nichols法：系统的调参方法
%     - 网格搜索：遍历参数空间找最优值
%
% Q6: 模拟为什么很慢？
% A6: 使用的是完整的Simscape物理模型，
%     每个场景运行720步(12小时)，这是正常的
%
% Q7: 如何使用Simulink模型进行仿真？
% A7: 参考 TrainPIDAgentControlHouseHeatingSystemExample.m
%     中的Simulink集成部分

% =====================================================
% XI. 故障排除 (Troubleshooting)
% =====================================================
%
% 问题: 文件找不到
% 解决: 检查当前目录，确保在
%      HouseHeatingDemo_Deliverable/HouseHeatingDemo_Deliverable
%      目录下
%
% 问题: 温度数据加载失败
% 解决: 确保 temperatureMar21toApr15_2022.mat 在上级目录
%
% 问题: PID控制器创建失败
% 解决: 检查 pidHeatingController.m 是否在路径中
%      使用 addpath(pwd) 添加当前目录到路径
%
% 问题: 仿真结果异常
% 解决: - 检查PID参数是否合理
%      - 尝试重置控制器 controller.reset()
%      - 查看控制器统计信息 controller.getStatistics()

% =====================================================
% XII. 扩展功能 (Advanced Features)
% =====================================================
%
% 该实现支持以下扩展功能：
%
% 1. 多策略对比
%    可将PID与其他控制方法对比，如：
%    - 模糊逻辑控制
%    - MPC (Model Predictive Control)
%    - 强化学习（DQN, PPO等）
%
% 2. 参数自动调优
%    可实现网格搜索或其他优化算法来自动选择最优参数
%
% 3. 在线学习
%    可实现自适应PID，根据环境变化调整参数
%
% 4. 多房间控制
%    可扩展为多个房间的分布式控制

% =====================================================
% XIII. 许可和引用 (License and References)
% =====================================================
%
% 该项目基于：
% - MathWorks 的 DQN House Heating 示例
% - 经典PID控制理论
%
% 作者: Generated for House Heating Control Comparison
% 日期: May 2, 2026
% 版本: 1.0

% =====================================================
% XIV. 支持和反馈 (Support)
% =====================================================
%
% 更多信息请参考：
% - QUICKSTART.txt (快速开始指南)
% - 各脚本中的详细注释
% - MATLAB 帮助文档
%
% =====================================================
% 开始使用! (GET STARTED NOW!)
% =====================================================
%
% 在 MATLAB 命令窗口中运行：
% 
% >> cd PID_Control_Strategy
% >> PID_Setup_Configuration
% >> runHeatingDemoQuick_PID
%
% 查看 Figures 101-103 中的结果
%
% 享受! Enjoy!
