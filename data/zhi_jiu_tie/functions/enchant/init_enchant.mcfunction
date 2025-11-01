# ==============================================
# 致旧铁 | 强制附魔模块 - 初始化  
# 作者：QQ酱779138
# 作用：1. 注册所有依赖的分数板（解决报黄）；2. 初始化计时器默认值；3. 加载提示
# 说明：仅在数据包加载时执行一次，为强制附魔功能提供数据基础（1.20.1兼容）
# ==============================================

# 注册核心分数板（解决debug_counter、enchant_random等报黄问题）
scoreboard objectives add debug_counter dummy "调试计数器"
scoreboard objectives add enchant_random dummy "附魔数据暂存（等级/ID）"
scoreboard objectives add debug_step dummy "环节调试计时器"
scoreboard objectives add block_debug dummy "方块ID调试计时器"
scoreboard objectives add item_nbt_debug dummy "物品NBT调试计时器"
scoreboard objectives add book_pos_debug dummy "附魔书位置计时器"
scoreboard objectives add _global_timer dummy "全局状态计时器"
scoreboard objectives add target_debug dummy "附魔书标签调试计时器"
scoreboard objectives add nbt_debug dummy "NBT调试频率控制器"

# 初始化计时器默认值（避免残留值干扰）
scoreboard players set _global_timer debug_counter 0
scoreboard players set @e[type=minecraft:item_frame] nbt_debug 0
scoreboard players set @e[type=minecraft:item] nbt_debug 0

# 精简加载提示（移除版本号）
tellraw @a {"text":"[致旧铁] 强制附魔模块加载完成！","color":"gray"}
tellraw @a {"text":"• 核心规则：","color":"gray"}
tellraw @a {"text":"固体方块→展示框（含物品）→上方扔附魔书→强制附魔（无视冲突，消耗1本）","color":"gray"}