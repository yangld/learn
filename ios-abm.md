1. configuration_web_url，配置成一个登录页面，需要输入用户名，密码，点击登录按钮
2. 调用web_login接口，内部进行loginId，获取ticket，生成设备信息等逻辑，之后跳转到tenant_profile接口，会传递challenge，表示某个设备
3. 