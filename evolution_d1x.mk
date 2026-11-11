#
# Evolution X product for the Samsung Galaxy Note10 5G (d1x / SM-N971N)
#
# lineage_d1x.mk 已经继承了 vendor/lineage/config/common_full_phone.mk
# （在 Evolution X 里 vendor/lineage 就是 vendor_evolution 的落点，
#   EVO_VERSION_BASE=12.4 / PRODUCT_VERSION_MAJOR=17），
# 所以这里只需要继承设备产品并换掉产品名。
#
$(call inherit-product, device/samsung/d1x/lineage_d1x.mk)

PRODUCT_NAME := evolution_d1x
PRODUCT_DEVICE := d1x
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-N971N
PRODUCT_MANUFACTURER := samsung

# 保留 lineage_d1x.mk 里的指纹覆盖，避免与 crDroid/Lineage 的构建指纹冲突

# 中国大陆优化 + 性能调优（详见 cn-optimize.mk 里的注释）
$(call inherit-product, $(LOCAL_PATH)/cn-optimize.mk)
