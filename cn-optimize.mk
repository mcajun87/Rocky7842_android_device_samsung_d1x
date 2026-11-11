# ---------------------------------------------------------------------------
# d1x 中国大陆优化 + 性能调优
#
# 由 device/samsung/d1x/lineage_d1x.mk 与 evolution_d1x.mk 共同 inherit。
# 这里的属性全部是"产品级默认值"，用户可以在系统里改回去。
# ---------------------------------------------------------------------------

# ---- 1. 语言 / 时区 / 运营商（开箱就是国内环境）----
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.locale=zh-CN \
    persist.sys.timezone=Asia/Shanghai \
    ro.telephony.default_network=9 \
    persist.radio.calls.on.ims=1 \
    persist.dbg.volte_avail_ovr=1 \
    persist.radio.jbims=1

# ---- 2. 国内可达的 DNS / NTP ----
# 默认的 8.8.8.8 在国内经常被污染或超时，换成阿里 + 腾讯公共 DNS。
PRODUCT_PROPERTY_OVERRIDES += \
    net.dns1=223.5.5.5 \
    net.dns2=119.29.29.29 \
    net.rmnet0.dns1=223.5.5.5 \
    net.rmnet0.dns2=119.29.29.29

# ---- 3. 12GB 机型的内存 / Dalvik 调优 ----
# d1x 是 12GB RAM，AOSP 默认的堆参数是按 4GB 给的，偏保守。
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=32m \
    dalvik.vm.heapgrowthlimit=512m \
    dalvik.vm.heapsize=768m \
    dalvik.vm.heaptargetutilization=0.5 \
    dalvik.vm.heapminfree=8m \
    dalvik.vm.heapmaxfree=32m \
    dalvik.vm.usejit=true \
    dalvik.vm.usejitprofiles=true \
    dalvik.vm.dex2oat-threads=4 \
    dalvik.vm.image-dex2oat-threads=4

# ---- 4. SurfaceFlinger / 渲染（国内用户最直观的"跟手"）----
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.latch_unsignaled=1 \
    debug.sf.enable_gl_backpressure=1 \
    debug.sf.enable_hwc_vds=0 \
    ro.hwui.render_ahead=1 \
    ro.hwui.disable_vsync=true

# ---- 5. 关掉一堆调试日志，省 CPU 和存储 ----
PRODUCT_PROPERTY_OVERRIDES += \
    persist.log.tag=D \
    ro.logd.size=262144 \
    ro.logd.kernel=0 \
    persist.traced.enable=0 \
    debug.atrace.tags.enableflags=0

# ---- 6. 低内存/后台策略（国内 App 常驻多，适当放宽）----
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.max_starting_bg=12 \
    ro.config.low_ram=false

# ---- 7. 明确禁止 ROM 侧还原官方 recovery ----
# /vendor/etc/recovery.img 与 vendor_flash_recovery 这套文件本来就不在本 ROM 的
# proprietary-files.txt 里；这里再把 persist 属性按住，避免任何残留机制触发。
# OrangeFox 侧的 disablestockrecovery.sh 会做同样的兜底。
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.recovery_update=false
