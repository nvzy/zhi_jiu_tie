# ==============================================
# 致旧铁-v0.6.1 | 强制附魔模块 - 附魔书叠加处理
# 作者：QQ酱779138
# 作用：1. 强制初始化StoredEnchantments为数组（避免空值错误）；2. 无相同附魔时追加；3. 修正等级类型
# 说明：仅针对“展示框内的附魔书”生效，确保NBT格式兼容1.20.1
# ==============================================
# 1. 初始化StoredEnchantments数组（防止后续追加时因空值报错）
execute as @e[tag=valid_enchant_frame,limit=1] at @s unless data entity @s Item.tag.StoredEnchantments run data modify entity @s Item.tag.StoredEnchantments set value []

# 2. 无相同附魔时追加（避免重复添加同一附魔）
execute as @e[tag=valid_enchant_frame,limit=1] at @s unless data entity @s Item.tag.StoredEnchantments[{id:{"nbt":"Item.tag.StoredEnchantments[0].id","entity":"@e[tag=target_book,limit=1]"}}] run data modify entity @s Item.tag.StoredEnchantments append from entity @e[tag=target_book,limit=1] Item.tag.StoredEnchantments[0]

# 3. 修正等级类型为“短整数”（1.20.1 NBT格式要求，避免类型错误）
execute as @e[tag=valid_enchant_frame,limit=1] run execute store result entity @s Item.tag.StoredEnchantments[-1].lvl short 1 run scoreboard players get #book_lvl enchant_random

# 4. 数组结构调试（仅触发一次，避免重复输出）
execute as @e[tag=valid_enchant_frame,limit=1] at @s if score @s nbt_debug matches 0 run tellraw @a [{"text":"[附魔书调试] StoredEnchantments数组：","color":"gray"},{"nbt":"Item.tag.StoredEnchantments","entity":"@s","color":"white"}]