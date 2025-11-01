# ==============================================
# 致旧铁 | 附魔排序模块 - 核心排序处理
# 作者：QQ酱779138
# 说明：仅保留成功提示，无效操作不提示
# ==============================================

# 初始化分数板
scoreboard players set #enchant_total enchant_sort_count 0
scoreboard players set #current_index enchant_sort_temp 0
scoreboard players set #sort_flag enchant_sort_temp 0
scoreboard players set #is_tool enchant_sort_debug 0
scoreboard players set #is_book enchant_sort_debug 0

# 1. 标记物品类型（工具/装备=1，附魔书=2）
execute as @e[tag=valid_enchant_sort_frame,limit=1] if data entity @s Item.tag.Enchantments run scoreboard players set #is_tool enchant_sort_debug 1
execute as @e[tag=valid_enchant_sort_frame,limit=1] if data entity @s Item.tag.StoredEnchantments run scoreboard players set #is_book enchant_sort_debug 1

# 2. 循环统计附魔数量（工具/装备）
execute if score #is_tool enchant_sort_debug matches 1 run function zhi_jiu_tie:enchant_sort/_count_tool_enchants

# 3. 循环统计附魔数量（附魔书）
execute if score #is_book enchant_sort_debug matches 1 run function zhi_jiu_tie:enchant_sort/_count_book_enchants

# 4. 标记排序开关（附魔数量≥1时激活）
execute if score #enchant_total enchant_sort_count matches 1.. run scoreboard players set #sort_flag enchant_sort_temp 1

# 5. 工具/装备排序逻辑
execute if score #sort_flag enchant_sort_temp matches 1 if score #is_tool enchant_sort_debug matches 1 as @e[tag=valid_enchant_sort_frame,limit=1] run data modify storage zhi_jiu_tie:sort_temp first_enchant set from entity @s Item.tag.Enchantments[0]
execute if score #sort_flag enchant_sort_temp matches 1 if score #is_tool enchant_sort_debug matches 1 as @e[tag=valid_enchant_sort_frame,limit=1] run data remove entity @s Item.tag.Enchantments[0]
execute if score #sort_flag enchant_sort_temp matches 1 if score #is_tool enchant_sort_debug matches 1 as @e[tag=valid_enchant_sort_frame,limit=1] if data storage zhi_jiu_tie:sort_temp first_enchant run data modify entity @s Item.tag.Enchantments append from storage zhi_jiu_tie:sort_temp first_enchant

# 6. 附魔书排序逻辑
execute if score #sort_flag enchant_sort_temp matches 1 if score #is_book enchant_sort_debug matches 1 as @e[tag=valid_enchant_sort_frame,limit=1] run data modify storage zhi_jiu_tie:sort_temp first_enchant set from entity @s Item.tag.StoredEnchantments[0]
execute if score #sort_flag enchant_sort_temp matches 1 if score #is_book enchant_sort_debug matches 1 as @e[tag=valid_enchant_sort_frame,limit=1] run data remove entity @s Item.tag.StoredEnchantments[0]
execute if score #sort_flag enchant_sort_temp matches 1 if score #is_book enchant_sort_debug matches 1 as @e[tag=valid_enchant_sort_frame,limit=1] if data storage zhi_jiu_tie:sort_temp first_enchant run data modify entity @s Item.tag.StoredEnchantments append from storage zhi_jiu_tie:sort_temp first_enchant

# 7. 材料消耗控制
execute if score #sort_flag enchant_sort_temp matches 1 as @e[tag=target_enchant_sort_item,limit=1] run kill @s
execute if score #sort_flag enchant_sort_temp matches 1 as @e[tag=target_enchant_sort_item,limit=1] run tag @s add enchant_sort_cooldown

# 8. 结果反馈（仅保留成功提示，无效操作无提示）
execute if score #sort_flag enchant_sort_temp matches 1 run tellraw @a {"text":"[附魔排序] ✅ 成功！第一个附魔已移至最后一位。","color":"#4CAF50"}

# 9. 清除暂存数据
data remove storage zhi_jiu_tie:sort_temp first_enchant
scoreboard players set #enchant_total enchant_sort_count 0
scoreboard players set #current_index enchant_sort_temp 0
scoreboard players set #sort_flag enchant_sort_temp 0
scoreboard players set #is_tool enchant_sort_debug 0
scoreboard players set #is_book enchant_sort_debug 0