# ==============================================
# 附魔升级模块 - 核心调度（每tick运行）
# ==============================================
# 1. 标记「就绪状态」（同时存在有效展示框和升级物品）
execute as @e[tag=valid_enchant_up_frame,limit=1] at @s if entity @e[tag=target_enchant_up_item,limit=1] run tag @s add ready_to_enchant_up

# 2. 触发等级处理逻辑（仅就绪状态执行）
execute as @e[tag=ready_to_enchant_up,limit=1] at @s run function zhi_jiu_tie:enchant_up/_handle_level_change

# 3. 重置标签（避免重复触发，与原有模块标签隔离）
execute as @e[tag=ready_to_enchant_up] run tag @s remove ready_to_enchant_up
execute as @e[tag=target_enchant_up_item] run tag @s remove target_enchant_up_item