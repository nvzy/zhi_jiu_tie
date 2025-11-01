# ==============================================
# 统计附魔书附魔数量（1.20.1兼容版）
# 说明：用静态索引循环检查，避免动态变量导致的语法错误
# ==============================================

# 获取当前索引值（从#current_index读取）
scoreboard players set #i enchant_sort_temp 0
execute store result score #i enchant_sort_temp run scoreboard players get #current_index enchant_sort_temp

# 检查StoredEnchantments[当前索引]是否存在（核心修复：用静态索引语法）
## 索引0
execute if score #i enchant_sort_temp matches 0 as @e[tag=valid_enchant_sort_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[0] run scoreboard players set #has_enchant enchant_sort_debug 1
## 索引1
execute if score #i enchant_sort_temp matches 1 as @e[tag=valid_enchant_sort_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[1] run scoreboard players set #has_enchant enchant_sort_debug 1
## 索引2
execute if score #i enchant_sort_temp matches 2 as @e[tag=valid_enchant_sort_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[2] run scoreboard players set #has_enchant enchant_sort_debug 1
## 索引3
execute if score #i enchant_sort_temp matches 3 as @e[tag=valid_enchant_sort_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[3] run scoreboard players set #has_enchant enchant_sort_debug 1
## 索引4（最多支持5个附魔）
execute if score #i enchant_sort_temp matches 4 as @e[tag=valid_enchant_sort_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[4] run scoreboard players set #has_enchant enchant_sort_debug 1

# 若存在附魔，计数+1，索引+1，继续循环（最多5次）
execute if score #has_enchant enchant_sort_debug matches 1 if score #current_index enchant_sort_temp matches ..3 run scoreboard players add #enchant_total enchant_sort_count 1
execute if score #has_enchant enchant_sort_debug matches 1 if score #current_index enchant_sort_temp matches ..3 run scoreboard players add #current_index enchant_sort_temp 1
execute if score #has_enchant enchant_sort_debug matches 1 if score #current_index enchant_sort_temp matches ..3 run function zhi_jiu_tie:enchant_sort/_count_book_enchants

# 重置临时变量
scoreboard players set #has_enchant enchant_sort_debug 0
scoreboard players set #i enchant_sort_temp 0