# ==============================================
# 致旧铁-v0.6.1 | 加载核心提示
# 作者：QQ酱779138
# 作用：向玩家展示核心功能与操作入口，避免消息冗余
# 说明：只保留关键信息，引导用户通过说明书了解细节
# ==============================================
# 标题（简洁突出版本）
tellraw @a {"text":"===== 致旧铁-v0.6.1 双模块系统 =====","color":"gray","bold":true}
# 核心功能（合并同类说明，减少行数）
tellraw @a {"text":"• 强制附魔：","color":"gray"}
tellraw @a {"text":"无视冲突添加附魔；附魔升级：用物品调整等级（上限255级，暂不可改）","color":"gray"}

# 操作概要（简化步骤）
tellraw @a {"text":"• 通用操作：","color":"gray"}
tellraw @a {"text":"固体方块上的展示框→放带附魔物品→上方扔对应物品（附魔书/升级材料）","color":"gray"}

# 说明书入口（保留引导）
tellraw @a [{"text":"• 点击领取详细指南：","color":"gray"},{"text":"[点此领取]","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function zhi_jiu_tie:guide/give_guide"},"hoverEvent":{"action":"show_text","value":{"text":"获取操作+配置指南","color":"green"}}}]
tellraw @a {"text":"--------------------------------------","color":"gray"}