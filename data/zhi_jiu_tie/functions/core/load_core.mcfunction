# ==============================================
# 致旧铁 | 核心加载文件
# 作者：QQ酱779138
# 作用：1. 注册全局分数板（版本管理+状态控制）；2. 初始化全局运行状态；3. 发送加载提示
# 说明：数据包核心入口，支持多模块协同运行，版本号映射便于扩展兼容  
# ==============================================
# 注册全局分数板（同步版本号为v0.6.1，描述匹配当前版本）
scoreboard objectives add packet_version dummy "数据包版本（v0.7.1）"
scoreboard objectives add global_state dummy "全局状态（0=未初始化，1=正常运行）"

# 版本号映射：v0.7.1 → 数值8（遵循版本递进规则，便于后续版本管理）
scoreboard players set version packet_version 8
scoreboard players set server global_state 0

# 顶部分隔线
tellraw @a {"text":"\n====================================================","color":"gray"}
# 加载完成提示（更新表述）
tellraw @a {"text":"[致旧铁] 核心模块加载完成（支持多模块协同）","color":"gray"}