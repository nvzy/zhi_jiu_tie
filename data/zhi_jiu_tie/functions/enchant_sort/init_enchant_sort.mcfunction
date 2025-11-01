# ==============================================
# 致旧铁 | 附魔排序模块初始化  
# 作者：QQ酱779138
# 作用：1. 注册排序专用分数板；2. 初始化实体默认值；3. 加载提示
# 说明：仅数据包加载时执行，不影响原有模块数据
# ==============================================

# 注册排序专属分数板（前缀enchant_sort_避免冲突）
scoreboard objectives add enchant_sort_temp dummy "排序数据暂存"
scoreboard objectives add enchant_sort_count dummy "附魔数量统计"
scoreboard objectives add enchant_sort_debug dummy "排序调试计时器"

# 初始化实体默认值（清除残留值）
scoreboard players set @e[type=minecraft:item_frame] enchant_sort_temp 0
scoreboard players set @e[type=minecraft:item] enchant_sort_temp 0
scoreboard players set #sort_global_timer enchant_sort_debug 0

# 加载提示
tellraw @a {"text":"[致旧铁] 附魔排序模块就绪，排序材料：绿宝石（扔至展示框上方）。","color":"gray"}

tellraw @a {"text":"====================================================\n","color":"gray"}
