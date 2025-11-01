# ==============================================
# 致旧铁 | 附魔排序模块 - 目标检测
# 作者：QQ酱779138
# 作用：1. 标记有效排序展示框；2. 识别排序材料；3. 冷却管理
# 说明：仅检测带附魔的物品，无附魔时不触发排序
# ==============================================
# 1. 清除旧标签（避免重复检测）
execute as @e[type=minecraft:item_frame] run tag @s remove valid_enchant_sort_frame
execute as @e[type=minecraft:item] run tag @s remove target_enchant_sort_item
# 新增：不在玩家5格内的展示框，直接移除标签（初始过滤）
execute as @e[type=minecraft:item_frame] at @s unless entity @a[distance=0..5] run tag @s remove valid_enchant_sort_frame

# 2. 标记“玩家5格内+固体方块上的展示框”（补充距离条件，与其他模块统一）
execute as @e[type=minecraft:item_frame] at @s unless block ~ ~-1 ~ minecraft:air unless block ~ ~-1 ~ minecraft:water unless block ~ ~-1 ~ minecraft:lava if entity @a[distance=0..5] run tag @s add valid_enchant_sort_frame

# 3. 过滤“无附魔的展示框”（核心：仅带附魔的物品可排序）
execute as @e[tag=valid_enchant_sort_frame] unless data entity @s Item run tag @s remove valid_enchant_sort_frame
execute as @e[tag=valid_enchant_sort_frame] unless data entity @s Item.tag.Enchantments unless data entity @s Item.tag.StoredEnchantments run tag @s remove valid_enchant_sort_frame
execute as @e[tag=valid_enchant_sort_frame] if data entity @s Item.tag.Enchantments unless data entity @s Item.tag.Enchantments[0] run tag @s remove valid_enchant_sort_frame
execute as @e[tag=valid_enchant_sort_frame] if data entity @s Item.tag.StoredEnchantments unless data entity @s Item.tag.StoredEnchantments[0] run tag @s remove valid_enchant_sort_frame

# 4. 标记排序材料（选择绿宝石作为触发物，不与原有材料冲突）
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:emerald"}},tag=!enchant_sort_cooldown] at @s if entity @e[tag=valid_enchant_sort_frame,distance=0..2] run tag @s add target_enchant_sort_item

# 5. 冷却管理（10tick=0.5秒，避免高频触发）
scoreboard players add #sort_cooldown_timer enchant_sort_debug 1
execute if score #sort_cooldown_timer enchant_sort_debug matches 10 run tag @e[tag=enchant_sort_cooldown] remove enchant_sort_cooldown
execute if score #sort_cooldown_timer enchant_sort_debug matches 10 run scoreboard players set #sort_cooldown_timer enchant_sort_debug 0