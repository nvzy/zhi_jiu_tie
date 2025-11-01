# ==============================================
# 致旧铁 | 附魔升级模块初始化
# 作者：QQ酱779138
# 作用：注册分数板、初始化默认值，启动模块
# 说明：为升级功能提供数据基础，仅加载时执行一次
# ==============================================
# 注册必要分数板
scoreboard objectives add enchant_up_level_temp dummy "等级暂存"
scoreboard objectives add enchant_up_effect dummy "效果值暂存"
scoreboard objectives add enchant_up_enchant_count dummy "附魔数量统计"
scoreboard objectives add enchant_up_debug_step dummy "调试计时器"

# 初始化实体默认值
scoreboard players set @e[type=minecraft:item_frame] enchant_up_level_temp 0
scoreboard players set @e[type=minecraft:item] enchant_up_effect 0
scoreboard players set #global_timer enchant_up_debug_step 0
scoreboard players set #enchant_count enchant_up_enchant_count 0

# 精简模块加载提示（避免重复）
tellraw @a {"text":"[致旧铁] 附魔升级模块就绪，默认材料：木炭/铜/铁/金/钻石。","color":"gray"}
