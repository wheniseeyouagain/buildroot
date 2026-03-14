################################################################################
#
# Quectel QConnectManager Linux v1.6.7 Buildroot package
#
################################################################################

QUECTEL_CM_VERSION = v1.6.7
QUECTEL_CM_SITE = $(call github,quectel-open-source,Quectel_QConnectManager_Linux,$(QUECTEL_CM_VERSION))
QUECTEL_CM_LICENSE = LGPL-2.1
QUECTEL_CM_LICENSE_FILES = LICENSE

define QUECTEL_CM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) release
endef

define QUECTEL_CM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/quectel-CM $(TARGET_DIR)/usr/bin/quectel-CM
	$(INSTALL) -D -m 0755 $(@D)/quectel-atc-proxy $(TARGET_DIR)/usr/bin/quectel-atc-proxy
	$(INSTALL) -D -m 0755 $(@D)/default.script $(TARGET_DIR)/etc/udhcpc/default.script
	$(INSTALL) -D -m 0755 $(@D)/default.script_ip $(TARGET_DIR)/etc/udhcpc/default.script_ip
	$(INSTALL) -D -m 0755 $(@D)/default.script $(TARGET_DIR)/usr/share/udhcpc/default.script
	$(INSTALL) -D -m 0755 $(@D)/default.script_ip $(TARGET_DIR)/usr/share/udhcpc/default.script_ip
endef

$(eval $(generic-package))
