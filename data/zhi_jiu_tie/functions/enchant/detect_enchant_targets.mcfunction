# ==============================================
# 致旧铁-v0.6.1 | 强制附魔模块 - 目标检测
# 作者：QQ酱779138
# 作用：1. 筛选固体方块上的有效展示框；2. 标记展示框上方的目标附魔书；3. 管理员调试
# 说明：仅保留核心检测逻辑，调试消息20tick一次（仅管理员可见，避免刷屏）
# ==============================================
# 1. 检测“固体方块上”的物品展示框（排除空气/液体上方）
execute as @e[type=minecraft:item_frame] at @s if block ~ ~-1 ~ minecraft:air run tag @s remove valid_enchant_frame
execute as @e[type=minecraft:item_frame] at @s unless block ~ ~-1 ~ minecraft:air unless block ~ ~-1 ~ minecraft:water unless block ~ ~-1 ~ minecraft:lava run tag @s add valid_enchant_frame

# 2. 排除“无物品”的展示框（仅保留含物品的展示框）
execute as @e[tag=valid_enchant_frame] at @s unless data entity @s Item run tag @s remove valid_enchant_frame

# 3. 标记“展示框上方0-2格内”的附魔书（作为目标材料）
execute as @e[type=minecraft:item,nbt={Item:{id:"minecraft:enchanted_book"}}] at @s if entity @e[tag=valid_enchant_frame,distance=0..2] run tag @s add target_book

# 4. 管理员专属调试（20tick一次，避免消息冗余）
scoreboard players add @a debug_step 1
execute as @a[tag=admin,scores={debug_step=20}] run tellraw @s [{"text":"[调试] 有效展示框：","color":"dark_gray"},{"text":"@e[tag=valid_enchant_frame]","color":"aqua"},{"text":" | 目标附魔书：","color":"dark_gray"},{"text":"@e[tag=target_book]","color":"yellow"}]
execute as @a[scores={debug_step=20}] run scoreboard players set @s debug_step 0