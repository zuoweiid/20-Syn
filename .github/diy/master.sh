#!/bin/bash
function git_sparse_clone() {                                                 ## 只下载指定的目录，并移动到根目录
branch="$1" rurl="$2" localdir="$3" && shift 3                                ## 变量：branch=分支   rurl=链接    localdir=本地根目录
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
# git clone -b 1 --depth 1 --filter=blob:none --sparse 2 3
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd ..
rm -rf $localdir
}
# 如果单独使用方法：git_sparse_clone openwrt-23.05 "https://github.com/openwrt/openwrt" "openwrt" package/base-files package/network/config/firewall4


function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./                                       ## 移动分支内所有文件到 当前目录，  -n 不覆盖已存在的文件
rm -rf $1
}


git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb                 # 克隆到 .github 目录内, 与diy、workflows、同个路径
# git clone --depth 1 https://github.com/kenzok78/luci-app-adguardhome
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced
git clone --depth 1 https://github.com/honwen/luci-app-aliddns
git clone --depth 1 https://github.com/sbwml/luci-app-alist openwrt-alist && mv -n openwrt-alist/*alist ./ ; rm -rf openwrt-alist alist            ## 保留目录：luci-app-alist   删除目录：openwrt-alist + alist
git clone --depth 1 https://github.com/messense/aliyundrive-webdav aliyundrive-webdav && mv -n aliyundrive-webdav/openwrt/* ./ ; rm -rf aliyundrive-webdav
git clone --depth 1 https://github.com/ophub/luci-app-amlogic amlogic && mv -n amlogic/luci-app-amlogic ./;rm -rf amlogic

git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon

git clone --depth 1 https://github.com/kenzok78/luci-app-argone-config
git clone --depth 1 https://github.com/kenzok78/luci-theme-argone

git clone --depth 1 https://github.com/hubbylei/luci-app-clash
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go ddnsgo && mv -n ddnsgo/luci-app-ddns-go ./; rm -rf ddnsgo
git clone --depth 1 https://github.com/gngpp/luci-app-design-config
git clone --depth 1 https://github.com/gngpp/luci-theme-design

git clone --depth 1 https://github.com/kiddin9/luci-app-dnsfilter
git clone --depth 1 https://github.com/lisaac/luci-app-dockerman dockerman && mv -n dockerman/applications/* ./; rm -rf dockerman
git clone --depth 1 https://github.com/ntlf9t/luci-app-easymesh
git clone --depth 1 https://github.com/Huangjoe123/luci-app-eqos
git clone --depth 1 https://github.com/kenzok78/luci-app-fileassistant
git clone --depth 1 https://github.com/immortalwrt/homeproxy
git clone --depth 1 https://github.com/yaof2/luci-app-ikoolproxy
git clone --depth 1 https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/{luci-app-istorex,luci-app-quickstart} ./; rm -rf nas-packages-luci    # 保留插件：luci-app-istorex + luci-app-quickstart
rm -rf luci-app-quickstart
git clone --depth 1 https://github.com/jefferymvp/luci-app-koolproxyR
git clone --depth 1 https://github.com/sirpdboy/luci-app-lucky
git clone --depth 1 https://github.com/vernesong/OpenClash && mv -n OpenClash/luci-app-openclash ./; rm -rf OpenClash
git clone --depth 1 https://github.com/sirpdboy/luci-app-partexp
git clone --depth 1 -b lede https://github.com/pymumu/luci-app-smartdns

git clone --depth 1 https://github.com/linkease/istore && mv -n istore/luci/* ./; rm -rf istore taskd   # 保留插件：luci-app-store + luci-lib-taskd + luci-lib-xterm
# mkdir -p istore && mv {luci-app-store,luci-lib-taskd,luci-lib-xterm,taskd} istore

git clone --depth 1 -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic
git clone --depth 1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush


git clone --depth 1 https://github.com/kenzok8/litte && mv -n litte/luci-theme-atmaterial_new litte/luci-theme-tomato ./ ; rm -rf litte   # 保留插件：luci-theme-atmaterial_new + luci-theme-tomato

git clone --depth 1 https://github.com/kenzok8/luci-theme-ifit ifit && mv -n ifit/luci-theme-ifit ./;rm -rf ifit
git clone --depth 1 https://github.com/sirpdboy/luci-theme-opentopd
git clone --depth 1 https://github.com/linkease/nas-packages && mv -n nas-packages/network/services/{ddnsto,quickstart} ./; rm -rf nas-packages   # 保留插件：ddnsto + quickstart
git clone --depth 1 https://github.com/kenzok8/wall && mv -n wall/ddns-go wall/gost wall/smartdns wall/adguardhome wall/filebrowser ./ ; rm -rf wall   # 保留插件：smartdns + gost + filebrowser + ddns-go + adguardhome
rm -rf ddns-go smartdns

# git clone --depth 1 https://github.com/QiuSimons/openwrt-mos && mv -n openwrt-mos/*mosdns ./ ; rm -rf openwrt-mos   # 保留插件：mosdns + luci-app-mosdns
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns openwrt-mos && mv -n openwrt-mos/{*mosdns,v2dat} ./; rm -rf openwrt-mos      # 保留插件：v2dat + mosdns + luci-app-mosdns



sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?2. Clash For OpenWRT?3. Applications?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
-e 's/ca-certificates/ca-bundle/' \
*/Makefile

sed -i 's/luci-lib-ipkg/luci-base/g' luci-app-store/Makefile
sed -i 's/+dockerd/+dockerd +cgroupfs-mount/' luci-app-docker*/Makefile
sed -i '$i /etc/init.d/dockerd restart &' luci-app-docker*/root/etc/uci-defaults/*
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-design/' luci-theme-design-config/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argone/' luci-app-argone-config/Makefile
#sed -i -e 's/nas/services/g' -e 's/NAS/Services/g' $(grep -rl 'nas\|NAS' luci-app-fileassistant)
#sed -i '65,73d' adguardhome/Makefile
sed -i '/entry({"admin", "nas"}, firstchild(), "NAS", 45).dependent = false/d; s/entry({"admin", "network", "eqos"}, cbi("eqos"), _("EQoS"))/entry({"admin", "network", "eqos"}, cbi("eqos"), _("EQoS"), 121).dependent = true/' luci-app-eqos/luasrc/controller/eqos.lua
#sed -i '/^\t\$(call Build\/Prepare\/Default)/a \\tif [ -d "$(BUILD_DIR)\/AdGuardHome-$(PKG_VERSION)" ]; then \\\n\t\tmv "$(BUILD_DIR)\/AdGuardHome-$(PKG_VERSION)\/"* "$(BUILD_DIR)\/adguardhome-$(PKG_VERSION)\/"; \\\n\tfi' adguardhome/Makefile
#sed -i '/gzip -dc $(DL_DIR)\/$(FRONTEND_FILE) | $(HOST_TAR) -C $(PKG_BUILD_DIR)\/ $(TAR_OPTIONS)/a \\t( cd "$(BUILD_DIR)\/adguardhome-$(PKG_VERSION)"; go mod tidy )' adguardhome/Makefile
rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore create_acl_for_luci.err create_acl_for_luci.ok create_acl_for_luci.warn
rm -rf adguardhome/patches
#sed -i '59s/.*/local port=luci.sys.exec("awk \x27\/^dns:\/ {found_dns=1} found_dns \x26\x26 \/\^ port:\/ {print $2; exit}\x27 "..configpath.." 2>nul")/' luci-app-adguardhome/luasrc/model/cbi/AdGuardHome/base.lua
exit 0

