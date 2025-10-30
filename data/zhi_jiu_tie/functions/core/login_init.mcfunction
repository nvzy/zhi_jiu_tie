# ==============================================
# 登录初始化入口（延迟执行，解决加载太快问题）
# 延迟x秒（1秒=20 tick）
# ==============================================

# 延迟1秒（20 tick）执行原有初始化函数，等待玩家加载
schedule function zhi_jiu_tie:core/load_core 20t
schedule function zhi_jiu_tie:core/init_core 20t
schedule function zhi_jiu_tie:enchant/init_enchant 20t
schedule function zhi_jiu_tie:enchant_up/init_enchant_up 20t