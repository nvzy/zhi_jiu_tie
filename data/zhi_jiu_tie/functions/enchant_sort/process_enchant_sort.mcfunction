# ==============================================
# 致旧铁 | 附魔排序模块 - 流程控制
# 作者：QQ酱779138
# 作用：1. 标记就绪状态；2. 调用排序逻辑；3. 重置标签
# 说明：每tick运行，独立于原有模块流程
# ==============================================
# 1. 标记“就绪状态”（有效展示框+排序材料同时存在）
execute as @e[tag=valid_enchant_sort_frame,limit=1] at @s if entity @e[tag=target_enchant_sort_item,limit=1] run tag @s add ready_to_enchant_sort

# 2. 执行排序逻辑（仅就绪状态触发）
execute as @e[tag=ready_to_enchant_sort,limit=1] at @s run function zhi_jiu_tie:enchant_sort/_handle_enchant_sort

# 3. 重置标签（避免重复触发，独立标签不干扰原有模块）
execute as @e[tag=ready_to_enchant_sort] run tag @s remove ready_to_enchant_sort
execute as @e[tag=target_enchant_sort_item] run tag @s remove target_enchant_sort_item