# ==============================================
# 致旧铁 | 加载核心提示
# 作者：QQ酱779138
# 作用：向玩家展示多模块核心功能与操作入口，避免消息冗余
# 说明：只保留关键信息，引导用户通过说明书了解细节
# ==============================================
# 标题
tellraw @a {"text":"===== 致旧铁 多模块系统 =====","color":"gray","bold":true}
# 核心功能
tellraw @a {"text":"• 已集成模块：","color":"gray"}
tellraw @a {"text":"强制附魔（无视冲突）、附魔升级（等级调整）、附魔排序（顺序调整）","color":"gray"}
tellraw @a {"text":"支持未来模块扩展","color":"gray"}
# 操作概要
tellraw @a {"text":"• 通用操作：","color":"gray"}
tellraw @a {"text":"固体方块上的展示框→放目标物品→上方扔对应材料（按模块需求）","color":"gray"}
# 说明书入口
tellraw @a [{"text":"• 点击领取多模块指南：","color":"gray"},{"text":"[点此领取]","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function zhi_jiu_tie:guide/give_guide"},"hoverEvent":{"action":"show_text","value":{"text":"获取所有模块操作+配置指南","color":"green"}}}]
tellraw @a {"text":"--------------------------------------","color":"gray"}