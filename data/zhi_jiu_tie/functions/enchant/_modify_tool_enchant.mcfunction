# ==============================================
# 致旧铁-v0.6.1 | 强制附魔模块 - 工具附魔处理
# 作者：QQ酱779138
# 作用：1. 初始化工具的Enchantments数组；2. 无相同附魔时追加；3. 修正等级类型
# 说明：针对“展示框内的工具/武器/装备”生效，无视原版附魔冲突规则
# ==============================================
# 1. 初始化Enchantments数组（防止空值导致的追加失败）
execute as @e[tag=valid_enchant_frame,limit=1] at @s unless data entity @s Item.tag.Enchantments run data modify entity @s Item.tag.Enchantments set value []

# 2. 无相同附魔时追加（避免重复，强制添加新附魔）
execute as @e[tag=valid_enchant_frame,limit=1] at @s unless data entity @s Item.tag.Enchantments[{id:{"nbt":"Item.tag.StoredEnchantments[0].id","entity":"@e[tag=target_book,limit=1]"}}] run data modify entity @s Item.tag.Enchantments append from entity @e[tag=target_book,limit=1] Item.tag.StoredEnchantments[0]

# 3. 修正等级为短整数（符合1.20.1物品NBT规范）
execute as @e[tag=valid_enchant_frame,limit=1] run execute store result entity @s Item.tag.Enchantments[-1].lvl short 1 run scoreboard players get #book_lvl enchant_random

# 4. 数组结构调试（仅输出一次，减少干扰）
execute as @e[tag=valid_enchant_frame,limit=1] at @s if score @s nbt_debug matches 0 run tellraw @a [{"text":"[工具调试] Enchantments数组：","color":"gray"},{"nbt":"Item.tag.Enchantments","entity":"@s","color":"white"}]