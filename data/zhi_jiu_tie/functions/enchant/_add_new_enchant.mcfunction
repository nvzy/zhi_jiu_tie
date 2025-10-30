# ==============================================
# 致旧铁-v0.6.1 | 强制附魔模块 - 新物品附魔
# 作者：QQ酱779138
# 作用：1. 为“无任何附魔标签”的新物品初始化数组；2. 追加附魔；3. 修正等级
# 说明：针对首次附魔的物品（无Enchantments/StoredEnchantments），避免空值错误
# ==============================================
# 1. 初始化标签与Enchantments数组（确保新物品有基础NBT结构）
execute as @e[tag=valid_enchant_frame,limit=1] at @s unless data entity @s Item.tag run data modify entity @s Item.tag set value {"Enchantments": []}
execute as @e[tag=valid_enchant_frame,limit=1] at @s unless data entity @s Item.tag.Enchantments run data modify entity @s Item.tag.Enchantments set value []

# 2. 追加附魔（无视原版冲突，强制添加）
data modify entity @s Item.tag.Enchantments append from entity @e[tag=target_book,limit=1] Item.tag.StoredEnchantments[0]

# 3. 修正等级为短整数（1.20.1兼容，避免NBT类型错误）
execute as @e[tag=valid_enchant_frame,limit=1] run execute store result entity @s Item.tag.Enchantments[-1].lvl short 1 run scoreboard players get #book_lvl enchant_random

# 4. 新物品数组调试（仅输出一次，明确初始化结果）
execute as @e[tag=valid_enchant_frame,limit=1] at @s if score @s nbt_debug matches 0 run tellraw @a [{"text":"[新物品调试] Enchantments数组：","color":"#b87612"},{"nbt":"Item.tag.Enchantments","entity":"@s","color":"white"}]