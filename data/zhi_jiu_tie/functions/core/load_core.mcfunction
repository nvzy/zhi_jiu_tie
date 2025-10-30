# ==============================================
# 致旧铁-v0.6.1 | 核心加载文件
# 作者：QQ酱779138
# 作用：1. 注册全局分数板（版本管理+状态控制）；2. 初始化全局运行状态；3. 发送加载提示
# 说明：数据包核心入口，版本号映射数值便于后续版本更新与兼容判断
# ==============================================
# 注册全局分数板（同步版本号为v0.6.1，描述匹配当前版本）
scoreboard objectives add packet_version dummy "数据包版本（v0.6.1）"
scoreboard objectives add global_state dummy "全局状态（0=未初始化，1=正常运行）"

# 版本号映射：v0.6.1 → 数值7（遵循版本递进规则，便于后续版本管理）
scoreboard players set version packet_version 7
scoreboard players set server global_state 0

# 顶部分隔线（优化视觉区分，保持原有格式）
tellraw @a {"text":"\n====================================================","color":"gray"}

# 加载完成提示（明确当前版本，与整体模块版本一致）
tellraw @a {"text":"[致旧铁-v0.6.1] 核心模块加载完成","color":"gray"}