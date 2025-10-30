# ==============================================
# 致旧铁-v0.6.1 | 附魔升级等级处理
# 作者：QQ酱779138
# 作用：处理等级调整、清除附魔，控制边界规则（0-255级）
# 说明：响应有效操作并反馈结果，超上限不消耗材料
# ==============================================

# 初始化分数板标记（避免残留值干扰）
scoreboard players set #max_level enchant_up_level_temp 255
scoreboard players set #enchant_count enchant_up_enchant_count 0
scoreboard players set #is_last_enchant enchant_up_effect 0
scoreboard players set #exit_flag enchant_up_level_temp 0
scoreboard players set #effect enchant_up_effect 0
scoreboard players set #current_level enchant_up_level_temp 0
scoreboard players set #new_level enchant_up_level_temp 0


# 统计当前附魔数量（区分是否为最后一个）
execute if score #exit_flag enchant_up_level_temp matches 0 run scoreboard players set #enchant_count enchant_up_enchant_count 0
execute if score #exit_flag enchant_up_level_temp matches 0 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[0] run execute store result score #enchant_count enchant_up_enchant_count run data get entity @s Item.tag.StoredEnchantments 1
execute if score #exit_flag enchant_up_level_temp matches 0 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.Enchantments[0] run execute store result score #enchant_count enchant_up_enchant_count run data get entity @s Item.tag.Enchantments 1


# 标记是否为最后一个附魔
execute if score #exit_flag enchant_up_level_temp matches 0 if score #enchant_count enchant_up_enchant_count matches 1 run scoreboard players set #is_last_enchant enchant_up_effect 1


# 读取升级物品对应效果
  # 清除附魔
execute if score #exit_flag enchant_up_level_temp matches 0 as @e[tag=target_enchant_up_item,limit=1,nbt={Item:{id:"minecraft:charcoal"}}] run scoreboard players set #effect enchant_up_effect -999
  # 等级-1
execute if score #exit_flag enchant_up_level_temp matches 0 as @e[tag=target_enchant_up_item,limit=1,nbt={Item:{id:"minecraft:copper_ingot"}}] run scoreboard players set #effect enchant_up_effect -1
  # 等级+1
execute if score #exit_flag enchant_up_level_temp matches 0 as @e[tag=target_enchant_up_item,limit=1,nbt={Item:{id:"minecraft:iron_ingot"}}] run scoreboard players set #effect enchant_up_effect 1
  # 等级+10
execute if score #exit_flag enchant_up_level_temp matches 0 as @e[tag=target_enchant_up_item,limit=1,nbt={Item:{id:"minecraft:gold_ingot"}}] run scoreboard players set #effect enchant_up_effect 10
  # 等级+50
execute if score #exit_flag enchant_up_level_temp matches 0 as @e[tag=target_enchant_up_item,limit=1,nbt={Item:{id:"minecraft:diamond"}}] run scoreboard players set #effect enchant_up_effect 50


# 处理清除附魔逻辑
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -999 if score #is_last_enchant enchant_up_effect matches 0 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[0] run data remove entity @s Item.tag.StoredEnchantments[0]
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -999 if score #is_last_enchant enchant_up_effect matches 0 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.Enchantments[0] run data remove entity @s Item.tag.Enchantments[0]
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -999 if score #is_last_enchant enchant_up_effect matches 1 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[0] run data remove entity @s Item.tag.StoredEnchantments[0]
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -999 if score #is_last_enchant enchant_up_effect matches 1 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.Enchantments[0] run data remove entity @s Item.tag.Enchantments[0]

# 消耗材料+精简反馈
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -999 as @e[tag=target_enchant_up_item,limit=1] run kill @s
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -999 if score #is_last_enchant enchant_up_effect matches 1 run tellraw @a {"text":"[附魔升级] 已清除最后一个附魔。","color":"#b9a810"}
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -999 if score #is_last_enchant enchant_up_effect matches 0 run tellraw @a {"text":"[附魔升级] 已清除第一项附魔。","color":"#b9a810"}


# 处理等级调整（含边界控制）
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[0] run execute store result score #current_level enchant_up_level_temp run data get entity @s Item.tag.StoredEnchantments[0].lvl 1
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.Enchantments[0] run execute store result score #current_level enchant_up_level_temp run data get entity @s Item.tag.Enchantments[0].lvl 1

execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 run scoreboard players operation #new_level enchant_up_level_temp = #current_level enchant_up_level_temp
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 run scoreboard players operation #new_level enchant_up_level_temp += #effect enchant_up_effect

# 等级上限（精简提示）
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches 256.. run tellraw @a {"text":"[附魔升级] 已达最大等级255，操作无效。","color":"red"}
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches 256.. as @e[tag=target_enchant_up_item,limit=1] run tag @s add enchant_up_cooldown
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches 256.. as @e[tag=target_enchant_up_item,limit=1] run data modify entity @s Motion[0] set value 0.5
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches 256.. as @e[tag=target_enchant_up_item,limit=1] run data modify entity @s Motion[1] set value 0.5
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches 256.. as @e[tag=target_enchant_up_item,limit=1] run data modify entity @s Motion[2] set value -0.5

# 有效等级（精简反馈）
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches 0..255 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[0] run execute store result entity @s Item.tag.StoredEnchantments[0].lvl short 1 run scoreboard players get #new_level enchant_up_level_temp
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches 0..255 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.Enchantments[0] run execute store result entity @s Item.tag.Enchantments[0].lvl short 1 run scoreboard players get #new_level enchant_up_level_temp
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches 0..255 as @e[tag=target_enchant_up_item,limit=1] run kill @s
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches 1.. if score #new_level enchant_up_level_temp matches 0..255 run tellraw @a [{"text":"[附魔升级] 等级提升至：","color":"green"},{"score":{"name":"#new_level","objective":"enchant_up_level_temp"},"color":"white"},{"text":"级","color":"green"}]
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1 if score #new_level enchant_up_level_temp matches 0..255 run tellraw @a [{"text":"[附魔升级] 等级降低至：","color":"green"},{"score":{"name":"#new_level","objective":"enchant_up_level_temp"},"color":"white"},{"text":"级","color":"green"}]

# 等级下限（精简反馈）
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches ..-1 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.StoredEnchantments[0] run data modify entity @s Item.tag.StoredEnchantments[0].lvl set value 0
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches ..-1 as @e[tag=valid_enchant_up_frame,limit=1] if data entity @s Item.tag.Enchantments[0] run data modify entity @s Item.tag.Enchantments[0].lvl set value 0
execute if score #exit_flag enchant_up_level_temp matches 0 if score #effect enchant_up_effect matches -1..50 if score #new_level enchant_up_level_temp matches ..-1 as @e[tag=target_enchant_up_item,limit=1] run kill @s
execute if score #exit_flag enchant_up_level_temp matches 0 if score #new_level enchant_up_level_temp matches ..-1 run tellraw @a {"text":"[附魔升级] 等级已降至最低0级。","color":"green"}


# 重置标记（避免影响下次执行）
scoreboard players set #current_level enchant_up_level_temp 0
scoreboard players set #effect enchant_up_effect 0
scoreboard players set #new_level enchant_up_level_temp 0
scoreboard players set #enchant_count enchant_up_enchant_count 0
scoreboard players set #is_last_enchant enchant_up_effect 0
scoreboard players set #exit_flag enchant_up_level_temp 0