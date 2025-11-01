# ==============================================
# 致旧铁 | 强制附魔模块 - 流程控制
# 作者：QQ酱779138
# 作用：1. 标记“就绪状态”（展示框+附魔书均存在）；2. 调用成功逻辑；3. 重置标签
# 说明：作为“检测→执行”的中间环节，避免重复触发附魔
# ==============================================
# 1. 标记“就绪状态”（仅当有效展示框+目标附魔书同时存在时）
execute as @e[tag=valid_enchant_frame,limit=1] at @s if entity @e[tag=target_book,limit=1] run tag @s add ready_to_enchant

# 2. 执行强制附魔（直接调用成功逻辑，减少重复代码）
execute as @e[tag=ready_to_enchant,limit=1] at @s run function zhi_jiu_tie:enchant/enchant_success

# 3. 重置标签（避免同一组目标重复触发附魔）
execute as @e[tag=ready_to_enchant] run tag @s remove ready_to_enchant
execute as @e[tag=target_book] run tag @s remove target_book