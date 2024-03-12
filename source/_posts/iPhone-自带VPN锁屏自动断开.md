---
title: iPhone 自带VPN锁屏自动断开
abbrlink: 61ee676c
date: 2024-03-12 13:09:37
tags:
---

一、 Mobileconfig

iOS Mobileconfig是苹果iOS操作系统中的配置文件。这些配置文件以.mobileconfig文件扩展名存储，通常用于配置设备上的各种设置，如VPN配置、电子邮件账户设置、Wi-Fi网络配置、安全策略等。用户可以通过安装.mobileconfig文件来快速轻松地配置设备，而无需手动逐项设置。

Mobileconfig文件采用XML格式，可以包含各种配置指令和参数，让用户和管理员可以方便地搭建和管理iOS设备的配置。通过安装Mobileconfig文件，用户可以一次性完成多项配置，提高了配置的效率和便捷性。这对于企业中需要大规模配置iOS设备时特别有用，管理员可以通过Mobileconfig文件轻松地为员工设备进行批量配置。

总的来说，iOS Mobileconfig文件是一种用于配置iOS设备各项设置的文件格式，能够简化配置流程，提高效率，适用于个人、企业以及其他组织对iOS设备的管理和配置需求。



二、自动断开重连

[VPN.IPSec | Apple Developer Documentation](https://developer.apple.com/documentation/devicemanagement/vpn/ipsec)

1. 通过配置MobileConfig实现自动识别重连，我这里使用的是Cisco IPSec，下面这个模版用来参考

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>PayloadContent</key>
  <array>
    <dict>
      <key>IPSec</key>
      <dict>
        <key>AuthenticationMethod</key>
        <string>SharedSecret</string>
        <key>LocalIdentifier</key>
        <string>***** 群租名称 ****</string>
        <key>LocalIdentifierType</key>
        <string>KeyID</string>
        <key>RemoteAddress</key>
        <string>***** 服务器 ****</string>
        <key>SharedSecret</key>
        <string>***** 密钥 ****</string>
      </dict>
      <key>IPv4</key>
      <dict>
        <key>OverridePrimary</key>
        <integer>1</integer>
      </dict>
      <key>OnDemandEnabled</key>
      <integer>1</integer>
      <key>OnDemandRules</key>
      <array>
          <dict>
              <key>Action</key>
              <string>Connect</string>
          </dict>
          <dict>
              <key>Action</key>
              <string>Connect</string>
              <key>InterfaceTypeMatch</key>
              <string>Cellular</string>
          </dict>
          <dict>
              <key>Action</key>
              <string>Connect</string>
              <key>InterfaceTypeMatch</key>
              <string>WiFi</string>
          </dict>
          <dict>
              <key>Action</key>
              <string>Ignore</string>
          </dict>
      </array>
      <key>PayloadDescription</key>
      <string>defualt payload desc</string>
      <key>PayloadDisplayName</key>
      <string>VPN</string>
      <key>PayloadIdentifier</key>
      <string>com.apple.vpn.managed.087D3518-3EE4-44AB-B20B-84B150C5825E</string>
      <key>PayloadOrganization</key>
      <string>default playload org</string>
      <key>PayloadType</key>
      <string>com.apple.vpn.managed</string>
      <key>PayloadUUID</key>
      <string>B6E58B82-F683-4CC9-8A05-DFA9A3B06BB4</string>
      <key>PayloadVersion</key>
      <integer>1</integer>
      <key>Proxies</key>
      <dict>
        <key>HTTPEnable</key>
        <integer>0</integer>
        <key>HTTPSEnable</key>
        <integer>0</integer>
        <key>ProxyAutoConfigEnable</key>
        <integer>0</integer>
        <key>ProxyAutoDiscoveryEnable</key>
        <integer>0</integer>
      </dict>
      <key>UserDefinedName</key>
      <string>连接VPN</string>
      <key>VPNType</key>
      <string>IPSec</string>
    </dict>
  </array>
  <key>PayloadDescription</key>
  <string>defualt payload desc</string>
  <key>PayloadDisplayName</key>
  <string>VPN</string>
  <key>PayloadIdentifier</key>
  <string>D5CF7299-AF60-45A5-8B40-0051E80C8048</string>
  <key>PayloadOrganization</key>
  <string>default playload org</string>
  <key>PayloadRemovalDisallowed</key>
  <false/>
  <key>PayloadType</key>
  <string>Configuration</string>
  <key>PayloadUUID</key>
  <string>222010E8-2D18-4BBE-BD19-58B192C4CCE4</string>
  <key>PayloadVersion</key>
  <integer>1</integer>
</dict>
</plist>

```

这里你只需要填写下面几个参数

```
LocalIdentifier: 群租名称
RemoteAddress: 服务器
SharedSecret: 密钥
```

你会发现里面没有**用户名**和**密码**，是因为用户名和密码不在这个里面填写，所以不需要填，到后面的时候自然会有地方填。

下面对应IOS中Cisco IPSec的客户端界面。



![image-20240312132344341](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20240312132344341.png)





2. 将上面的模版修改以后，保存为后缀.mobileconfig的文件，放在网站上，保证可以被下载。

你可以启动一个小web file服务器，用来读取到远端的file并下载。可以参考这篇Blog [python3 http.server 本地服务支持跨域 - hoey94 - 博客园 (cnblogs.com)](https://www.cnblogs.com/hoey94/p/11353214.html)

3. 使用手机端下载.mobileconfig文件，并安装描述文件。
4. 在安装的过程中输入用户名和密码即可



三、 其他

如果你使用的是L2TP，你可以参考下面的这个模版，这个模版我没有测试，可以自己测一下，据网友反映是可以使用的。

这里也有关于它的讨论，可以看一下[iPhone 打开自带VPN后，锁屏没过多久，… - Apple 社区](https://discussionschinese.apple.com/thread/253949421?sortBy=best&page=1)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>PayloadContent</key>
	<array>
		<dict>
			<key>IPSec</key>
			<dict>
				<key>AuthenticationMethod</key>
				<string>SharedSecret</string>
			</dict>
			<key>IPv4</key>
			<dict>
				<key>OverridePrimary</key>
				<integer>1</integer>
			</dict>
			<key>PPP</key>
			<dict>
				<key>CommRemoteAddress</key>
				<string>****此处输入 VPN 服务器地址****</string>
			</dict>
			<key>PayloadDisplayName</key>
			<string>VPN</string>
			<key>PayloadIdentifier</key>
			<string>com.apple.vpn.managed.087D3518-3EE4-44AB-B20B-84B150C5825E</string>
			<key>PayloadType</key>
			<string>com.apple.vpn.managed</string>
			<key>PayloadUUID</key>
			<string>B6E40B84-A912-4249-A73D-DA224AAAC470</string>
			<key>PayloadVersion</key>
			<integer>1</integer>
			<key>UserDefinedName</key>
			<string>****此处可以自定义 VPN 显示的名字****</string>
			<key>VPNType</key>
			<string>L2TP</string>
			<key>IPv4</key>
			<dict>
				<key>OverridePrimary</key>
				<integer>1</integer>
			</dict>
			<key>OnDemandEnabled</key>
			<integer>1</integer>
			<key>OnDemandRules</key>
			<array>
				<dict>
					<key>Action</key>
					<string>Connect</string>
				</dict>
				<dict>
					<key>Action</key>
					<string>Connect</string>
					<key>InterfaceTypeMatch</key>
					<string>Cellular</string>
				</dict>
				<dict>
					<key>Action</key>
					<string>Connect</string>
					<key>InterfaceTypeMatch</key>
					<string>WiFi</string>
				</dict>
				<dict>
					<key>Action</key>
					<string>Ignore</string>
				</dict>
			</array>
		</dict>
	</array>
	<key>PayloadDisplayName</key>
	<string>****此处自定义描述文件的名字****</string>
	<key>PayloadIdentifier</key>
	<string>D653CCA3-DC03-413C-9DE8-D19878CE48A3</string>
	<key>PayloadType</key>
	<string>Configuration</string>
	<key>PayloadUUID</key>
	<string>EAB66BD6-D1D4-4326-BF83-09A9042C5507</string>
	<key>PayloadVersion</key>
	<integer>1</integer>
</dict>
</plist>
```





