#
# Copyright (C) 2016-2017 GitHub <sqm-zh-cn>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-i18n-sqm
PKG_VERSION:=1.1.3
PKG_RELEASE:=1
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-i18n-sqm
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=X. Luci-i18n
  TITLE:=LuCI support for the sqm language package
  PKGARCH:=all
endef

define Package/luci-i18n-sqm/description
	Language Support Packages.
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-i18n-sqm/preinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f "/usr/lib/sqm/layer_cake.qos.help" ]; then
		rm /usr/lib/sqm/layer_cake.qos.help
	fi
	if [ -f "/usr/lib/sqm/piece_of_cake.qos.help" ]; then
		rm /usr/lib/sqm/piece_of_cake.qos.help
	fi
	if [ -f "/usr/lib/sqm/simple.qos.help" ]; then
		rm /usr/lib/sqm/simple.qos.help
	fi
	if [ -f "/usr/lib/sqm/simplest.qos.help" ]; then
		rm /usr/lib/sqm/simplest.qos.help
	fi
	if [ -f "/usr/lib/sqm/simplest_tbf.qos.help" ]; then
		rm /usr/lib/sqm/simplest_tbf.qos.help
	fi	
fi
exit 0
endef

define Package/luci-i18n-sqm/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DIR) $(1)/usr/lib/sqm
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/sqm.*.lmo $(1)/usr/lib/lua/luci/i18n/
	$(INSTALL_DATA) ./help/*.help $(1)/usr/lib/sqm
endef

$(eval $(call BuildPackage,luci-i18n-sqm))
