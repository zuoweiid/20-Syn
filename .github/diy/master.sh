#!/bin/bash
function git_sparse_clone() {                                                 ## 只下载指定的目录，并移动到根目录；
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


function git_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
# find package/ -follow -name $pkg -not -path "package/openwrt-packages/*" | xargs -rt rm -rf
    localdir=./                            # 变量= 保存的文件路径
    git clone --depth=1 --single-branch $1
    [ -d "$localdir" ] || mkdir -p "$localdir"   # 判断当前是否有 download 目录，如果不存在 则新创建 download 目录；= (-d 判断目录是否存在)  (mkdir -p 判断结果：如果目录不存在，则新创建 download 目录)
    mv $2 "$localdir"                            # 移动下载的文件 至 download 目录内；
    rm -rf $repo
}
# git_package https://github.com/coolsnowwolf/luci luci/applications/luci-app-ddns # 命令案例




function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./                                       ## 移动分支内所有文件到 当前目录；  -n 不覆盖已存在的文件
rm -rf $1
}

# 插件源码       # 克隆到 .github 目录内, 与diy、workflows、同个路径
git clone --depth 1 https://github.com/kiddin9/openwrt-packages && mv -n openwrt-packages/{luci-app-bypass,lua-maxminddb,lua-neturl} ./ ; rm -rf openwrt-packages     # 保留：luci-app-bypass + 插件依赖包
###### git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb.git																								  # luci-app-bypass插件的其中一个依赖包
git clone --depth 1 https://github.com/vernesong/OpenClash.git && mv -n OpenClash/luci-app-openclash ./; rm -rf OpenClash                       # OenClash小猫咪
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1  # passwall1（主插件！！）
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2          # passwall2（主插件！！）
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages                                    # passwall     插件依赖包
git clone --depth 1 https://github.com/fw876/helloworld && mv -n helloworld/{luci-app-ssr-plus,tuic-client,shadow-tls} ./ ; rm -rf helloworld   # 保留：luci-app-ssr-plus + tuic-client + shadow-tls
git clone --depth 1 https://github.com/ophub/luci-app-amlogic.git amlogic && mv -n amlogic/luci-app-amlogic ./;rm -rf amlogic                   # 晶晨宝盒（N1或电视盒子）
git clone --depth 1 https://github.com/honwen/luci-app-aliddns.git																				# 阿里DDNS
git clone --depth 1 https://github.com/sbwml/luci-app-alist.git luci-alist && mv -n luci-alist/*alist ./ ; rm -rf luci-alist					# 保留：luci-app-alist + alist（阿雅网盘）
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git OpenAppFilter && mv -n OpenAppFilter/luci-app-oaf ./; rm -rf OpenAppFilter    # OpenAppFilter 应用访问过滤
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot.git                                                                            # PushBot 全能推送，改名后
git clone --depth 1 https://github.com/sirpdboy/netspeedtest.git                                                                                # 网络速度测试
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset.git                                                                        # 定时设置插件
git clone --depth 1 https://github.com/sirpdboy/luci-app-poweroffdevice.git                                                                     # 设备关机插件
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced.git                                                                           # 系统高级设置
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git ddnsgo && mv -n ddnsgo/luci-app-ddns-go ./; rm -rf ddnsgo                  # ddns-go动态域名
git clone --depth 1 https://github.com/sirpdboy/luci-app-netwizard.git                                                                          # 设置向导
git clone --depth 1 https://github.com/kenzok8/wall.git && mv -n wall/gost wall/adguardhome wall/filebrowser ./ ; rm -rf wall					# 保留：adguardhome filebrowser（网盘） gost



# git clone --depth 1 https://github.com/messense/aliyundrive-webdav.git aliyundrive && mv -n aliyundrive/openwrt/* ./ ; rm -rf aliyundrive		# 保留：aliyundrive-webdav + luci-app-aliyundrive-webdav
# git clone --depth 1 https://github.com/hubbylei/luci-app-clash.git
# git clone --depth 1 https://github.com/gngpp/luci-app-design-config.git



# git clone https://github.com/tuanqing/install-program package/install-program                  # 下载N1写入包（编译前勾选：Utilities--> install-program）
# git clone https://github.com/Hyy2001X/luci-app-autoupdate package/luci-app-autoupdate          # 在线更新固件插件
# git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff       # 关机插件（不选择！！！）
# git clone https://github.com/Hyy2001X/luci-app-shutdown package/luci-app-shutdown              # 一键关机/重启
        
# git clone https://github.com/destan19/openappfilter.git package/OpenAppFilter                  # 下载OpenAppFilter 应用访问过滤
# git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan        # 下载ServerChan微信推送
# git clone https://github.com/zzsj0928/luci-app-serverchand.git package/luci-app-serverchand   # 钉钉机器人推送（已弃用）（不选择！！！）
# git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot                # PushBot 全能推送，改名后
# git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic          # 下载新版网易云解锁
        
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon        # 下载新版Argon主题
# git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config           # 下载新版Argon主题设置
# git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus     # 京东签到
# git clone https://github.com/jenson85/luci-theme-darkmatter.git package/luci-theme-darkmatter        # 下载darkmatter黑暗主题
# git clone https://github.com/rosywrt/luci.git package/luci-rosy                                      # rosy玫瑰红主题
#git clone https://github.com/project-openwrt/openwrt-tmate.git package/luci-openwrt-tmate            # 不知名主题
# git clone https://github.com/openwrt-develop/luci-theme-atmaterial package/luci-theme-atmaterial     # 经典主题
#git clone --depth=1 -b openwrt-18.06 https://github.com/rosywrt/luci-theme-rosy                      # rosy玫瑰红主题

# git clone https://github.com/fangli/openwrt-vm-tools package/otherapp/open-vm-tools                                            ## open-vm-tools 工具；（Utilities--->>open-vm-tools   选择设置为 M 模块化功能）源码自带的有了
# git clone https://github.com/tindy2013/openwrt-subconverter.git package/otherapp/luci-app-openwrt-subconverter                 ## subconverter 订阅转换
# git clone https://github.com/rufengsuixing/luci-app-onliner.git package/luci-app-onliner                                       ## nlbwmon 网络带宽监视器  需要luci-app-nlbwmon
# git clone --depth 1 https://github.com/project-openwrt/openwrt.git package/otherapp/luci-app-diskman                           ## 不显示
#git clone https://github.com/cjbassi/gotop.git package/otherapp/gotop                      # gotop 活动监视器
#git clone https://github.com/xxxserxxx/gotop.git package/otherapp/luci-app-gotop   # gotop 活动监视器



# lede跟Lienol源码增加luci-app-bypass的话，把以下代码放入diy-1.sh里面就行
# git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
# svn co https://github.com/garypang13/openwrt-packages/trunk/lua-maxminddb
# find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
# find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}

# Project源码增加luci-app-bypass的话，把以下代码放入diy-1.sh里面就行
# git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
# svn co https://github.com/garypang13/openwrt-packages/trunk/lua-maxminddb


# git clone --depth 1 https://github.com/kiddin9/luci-app-dnsfilter.git
# git clone --depth 1 https://github.com/lisaac/luci-app-dockerman.git dockerman && mv -n dockerman/applications/* ./; rm -rf dockerman
# git clone --depth 1 https://github.com/ntlf9t/luci-app-easymesh.git
# git clone --depth 1 https://github.com/Huangjoe123/luci-app-eqos.git
# git clone --depth 1 https://github.com/kenzok78/luci-app-fileassistant.git
# git clone --depth 1 https://github.com/immortalwrt/homeproxy.git
# git clone --depth 1 https://github.com/yaof2/luci-app-ikoolproxy.git
# git clone --depth 1 https://github.com/linkease/nas-packages-luci.git && mv -n nas-packages-luci/luci/{luci-app-istorex,luci-app-quickstart} ./; rm -rf nas-packages-luci    # 保留插件：luci-app-istorex + luci-app-quickstart
# rm -rf luci-app-quickstart
# git clone --depth 1 https://github.com/jefferymvp/luci-app-koolproxyR.git
# git clone --depth 1 https://github.com/sirpdboy/luci-app-lucky.git

# git clone --depth 1 https://github.com/sirpdboy/luci-app-partexp.git
# git clone --depth 1 -b lede https://github.com/pymumu/luci-app-smartdns.git

# git clone --depth 1 https://github.com/linkease/istore.git && mv -n istore/luci/* ./; rm -rf istore taskd   # 保留插件：luci-app-store + luci-lib-taskd + luci-lib-xterm
# # mkdir -p istore && mv {luci-app-store,luci-lib-taskd,luci-lib-xterm,taskd} istore

# git clone --depth 1 -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git
# git clone --depth 1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git
# git clone --depth 1 https://github.com/lisaac/luci-app-diskman.git                                  # Diskman 磁盘分区
# git clone --depth 1 https://github.com/rufengsuixing/luci-app-onliner.git                           # 在线设备查看，需要luci-app-nlbwmon


# git clone --depth 1 https://github.com/linkease/nas-packages.git && mv -n nas-packages/network/services/{ddnsto,quickstart} ./; rm -rf nas-packages   # 保留插件：ddnsto + quickstart


# # git clone --depth 1 https://github.com/QiuSimons/openwrt-mos.git && mv -n openwrt-mos/*mosdns ./ ; rm -rf openwrt-mos   # 保留插件：mosdns + luci-app-mosdns
# git clone --depth 1 https://github.com/sbwml/luci-app-mosdns.git openwrt-mos && mv -n openwrt-mos/{*mosdns,v2dat} ./; rm -rf openwrt-mos      # 保留插件：v2dat + mosdns + luci-app-mosdns

# git clone https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk.git package/otherapp/mentohust                                                ##校园网认证
# git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk package/otherapp/MentoHUST-OpenWrt-ipk                              ## luci-app-mentohust
# git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust     # luci-app-mentohust

# git clone --depth=1 https://github.com/garypang13/luci-app-dnsfilter package/luci-app-dnsfilter   # DNS的广告过滤



# git clone -b master  https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/otherapp/luci-app-unblockneteasemusic   ##解锁网易云（可以编译但是插件无效）
# git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/otherapp/luci-app-unblockneteasemusic              ##解锁网易云(编译后,不显示插件)

# git clone --depth=1 https://github.com/ysc3839/luci-proto-minieap   #  luci-proto-minieap


# git clone --depth=1 https://github.com/KFERMercer/luci-app-dockerman    # Docker
# git clone --depth=1 https://github.com/lisaac/luci-app-dockerman        # Docker 管理插件
        
# git clone --depth=1 https://github.com/project-openwrt/openwrt-gowebdav   # WebDav 服务端程序
#git clone  https://github.com/bigbugcc/OpenwrtApp package/otherapp/OpenwrtApp           ##作者的插件包


# # 主题源码
# git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git                          # Argon最新主题设置
# git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git                               # Argon最新主题源码（匹配Lede源码）



# # git clone --depth 1 https://github.com/kenzok78/luci-app-argone-config.git                        # Argon主题设置
# # git clone --depth 1 https://github.com/kenzok78/luci-theme-argone.git                             # Argon主题
# git clone --depth 1 https://github.com/thinktip/luci-theme-neobird.git                              # neobird主题
# git clone --depth 1 https://github.com/kenzok8/luci-theme-ifit.git ifit && mv -n ifit/luci-theme-ifit ./;rm -rf ifit
# git clone --depth 1 https://github.com/kenzok8/litte.git && mv -n litte/luci-theme-atmaterial_new litte/luci-theme-tomato ./ ; rm -rf litte   # 保留插件：luci-theme-atmaterial_new + luci-theme-tomato
# git clone --depth 1 https://github.com/sirpdboy/luci-theme-opentopd.git
# git clone --depth 1 https://github.com/gngpp/luci-theme-design.git

# 单独下载
# 使用方法：git_sparse_clone   openwrt-23.05   "https://github.com/openwrt/openwrt"   "openwrt"    package/base-files   package/network/config/firewall4
#           git_sparse_clone   分支名          仓库地址                               保存文件名   仓库文件路径         保存至本地的路径


# ------------------------------------------------------------------------------------
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

