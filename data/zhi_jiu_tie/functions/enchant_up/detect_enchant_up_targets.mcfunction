# ==============================================
# 附魔升级模块 - 目标检测（确保无附魔物品不被识别）
# ==============================================
# 1. 清除旧标签
execute as @e[type=minecraft:item_frame] run tag @s remove valid_enchant_up_frame
execute as @e[type=minecraft:item] run tag @s remove target_enchant_up_item

# 2. 标记固体方块上的展示框
execute as @e[type=minecraft:item_frame] at @s unless block ~ ~-1 ~ minecraft:air unless block ~ ~-1 ~ minecraft:water unless block ~ ~-1 ~ minecraft:lava run tag @s add valid_enchant_up_frame

# 3. 过滤无附魔物品（核心保留）
execute as @e[tag=valid_enchant_up_frame] unless data entity @s Item run tag @s remove valid_enchant_up_frame
execute as @e[tag=valid_enchant_up_frame] unless data entity @s Item.tag.Enchantments unless data entity @s Item.tag.StoredEnchantments run tag @s remove valid_enchant_up_frame
execute as @e[tag=valid_enchant_up_frame] if data entity @s Item.tag.Enchantments unless data entity @s Item.tag.Enchantments[0] run tag @s remove valid_enchant_up_frame
execute as @e[tag=valid_enchant_up_frame] if data entity @s Item.tag.StoredEnchantments unless data entity @s Item.tag.StoredEnchantments[0] run tag @s remove valid_enchant_up_frame

# 4. 标记升级物品
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:charcoal"}},tag=!enchant_up_cooldown] at @s if entity @e[tag=valid_enchant_up_frame,distance=0..2] run tag @s add target_enchant_up_item
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:copper_ingot"}},tag=!enchant_up_cooldown] at @s if entity @e[tag=valid_enchant_up_frame,distance=0..2] run tag @s add target_enchant_up_item
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:iron_ingot"}},tag=!enchant_up_cooldown] at @s if entity @e[tag=valid_enchant_up_frame,distance=0..2] run tag @s add target_enchant_up_item
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:gold_ingot"}},tag=!enchant_up_cooldown] at @s if entity @e[tag=valid_enchant_up_frame,distance=0..2] run tag @s add target_enchant_up_item
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:diamond"}},tag=!enchant_up_cooldown] at @s if entity @e[tag=valid_enchant_up_frame,distance=0..2] run tag @s add target_enchant_up_item

# 5. 冷却管理
scoreboard players add #cooldown_timer enchant_up_debug_step 1
execute if score #cooldown_timer enchant_up_debug_step matches 10 run tag @e[tag=enchant_up_cooldown] remove enchant_up_cooldown
execute if score #cooldown_timer enchant_up_debug_step matches 10 run scoreboard players set #cooldown_timer enchant_up_debug_step 0