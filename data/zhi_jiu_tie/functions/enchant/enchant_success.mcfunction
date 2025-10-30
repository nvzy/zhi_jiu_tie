# ==============================================
# 致旧铁-v0.6.1 | 强制附魔模块 - 成功逻辑
# 作者：QQ酱779138
# 作用：1. 管理员NBT调试；2. 提取附魔书等级；3. 按物品类型添加附魔；4. 消耗材料+反馈
# 说明：核心执行入口，根据展示框内物品类型调用对应处理函数
# ==============================================
# 1. 管理员专属NBT调试（2秒一次，避免刷屏）
execute as @e[tag=target_book,limit=1] at @s if score @s nbt_debug matches 0 run execute as @a[tag=admin] run tellraw @s [{"text":"[调试] 附魔书数据：","color":"dark_purple"},{"nbt":"Item.tag.StoredEnchantments","entity":"@s","color":"light_purple"}]
execute as @e[tag=valid_enchant_frame,limit=1] at @s if score @s nbt_debug matches 0 run execute as @a[tag=admin] run tellraw @s [{"text":"[调试] 目标物品数据：","color":"dark_purple"},{"nbt":"Item.tag.Enchantments","entity":"@s","color":"light_purple"}]

# 2. 提取附魔书等级（暂存到分数板，供后续修正使用）
execute as @e[tag=target_book,limit=1] run execute store result score #book_lvl enchant_random run data get entity @s Item.tag.StoredEnchantments[0].lvl 1

# 3. 按物品类型调用对应附魔函数（区分附魔书/工具）
execute as @e[tag=valid_enchant_frame,limit=1] at @s if data entity @s Item.tag.Enchantments run function zhi_jiu_tie:enchant/_modify_tool_enchant
execute as @e[tag=valid_enchant_frame,limit=1] at @s if data entity @s Item.tag.StoredEnchantments run function zhi_jiu_tie:enchant/_modify_book_enchant
execute as @e[tag=valid_enchant_frame,limit=1] at @s unless data entity @s Item.tag.Enchantments unless data entity @s Item.tag.StoredEnchantments run function zhi_jiu_tie:enchant/_add_new_enchant

# 4. 消耗附魔书+精简成功提示（突出版本，避免冗余）
execute as @e[tag=target_book,limit=1] run kill @s
tellraw @a {"text":"[致旧铁-v0.6.1] ✅ 附魔成功！已为目标物品添加附魔（无视冲突）","color":"gray","bold":true}

# 5. 重置调试计数器（确保下次调试正常触发）
execute as @e[tag=valid_enchant_frame] run scoreboard players set @s nbt_debug 0
execute as @e[type=minecraft:item] run scoreboard players set @s nbt_debug 0