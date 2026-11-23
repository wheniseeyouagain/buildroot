################################################################################
#
# PPSSPP
#
################################################################################
PPSSPP_VERSION = 1.20.4
PPSSPP_SOURCE = ppsspp-$(PPSSPP_VERSION).tar.xz
PPSSPP_SITE = https://github.com/hrydgard/ppsspp/releases/download/v$(PPSSPP_VERSION)

PPSSPP_DEPENDENCIES = sdl2 sdl2_ttf fontconfig zlib zstd libpng libzip wayland \
	source-han-sans-cn ffmpeg
PPSSPP_SUPPORTS_IN_SOURCE_BUILD = NO

PPSSPP_CONF_OPTS += \
	-DUSING_X11=OFF \
	-DUSING_X11_VULKAN=OFF \
	-DUSING_EGL=ON \
	-DUSING_GLES2=ON \
	-DARM_NO_VULKAN=ON \
	-DUSE_FFMPEG=ON \
	-DUSE_SYSTEM_FFMPEG=ON \
	-DUSE_DISCORD=OFF \
	-DUSE_SYSTEM_LIBSDL2=ON \
	-DUSE_SYSTEM_LIBZIP=ON \
	-DUSE_SYSTEM_LIBPNG=ON \
	-DUSE_SYSTEM_ZSTD=ON

ifeq ($(BR2_aarch64),y)
PPSSPP_CONF_OPTS += -DARM64=ON
endif

define PPSSPP_INSTALL_TARGET_LIBS
	$(INSTALL) -D $(@D)/buildroot-build/lib/*.so* $(TARGET_DIR)/usr/lib/
endef
PPSSPP_POST_INSTALL_TARGET_HOOKS += PPSSPP_INSTALL_TARGET_LIBS

define PPSSPP_REPLACE_ROBOTO_FONT
	$(foreach w,Regular Bold,\
		$(INSTALL) -D -m 0644 \
			$(TARGET_DIR)/usr/share/fonts/source-han-sans-cn/SourceHanSansCN-$w.otf \
			$(TARGET_DIR)/usr/share/ppsspp/assets/Roboto_Condensed-$w.ttf
	)
endef
PPSSPP_POST_INSTALL_TARGET_HOOKS += PPSSPP_REPLACE_ROBOTO_FONT

define PPSSPP_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(PPSSPP_PKGDIR)/S50ppsspp \
		$(TARGET_DIR)/etc/init.d/S51ppsspp
endef

$(eval $(cmake-package))
