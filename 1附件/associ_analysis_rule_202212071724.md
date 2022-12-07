|id|name|data_type|analyzer_class|analyzer_jar_url|message_template|rule_group_id|
|--|----|---------|--------------|----------------|----------------|-------------|
|1|检测连接VPN时证书状态|VPN_LOG|com.pekall.cmc.associ.analysis.analyzer.VpnLogCertStatusAnalyzer||证书${objectStatus}, 仍成功接入VPN|1|
|2|检测设备注册时证书状态|DEVICE_REGISTER_LOG|com.pekall.cmc.associ.analysis.analyzer.DeviceRegisterCertStatusAnalyzer||证书${objectStatus}, 仍成功注册终端|1|
|3|检测用户登录时证书状态|USER_LOGIN_LOG|com.pekall.cmc.associ.analysis.analyzer.UserLoginCertStatusAnalyzer||证书${objectStatus}, 仍成功登录|1|
|4|检测使用警务应用时证书状态|APP_USE_LOG|com.pekall.cmc.associ.analysis.analyzer.AppUseCertStatusAnalyzer||证书${objectStatus}, 仍成功使用警务应用“${appName}”|1|
|5|检测访问资源服务时证书状态|RES_VISIT_LOG|com.pekall.cmc.associ.analysis.analyzer.ResVisitCertStatusAnalyzer||证书${objectStatus}, 仍成功调用资源服务“${ressvcName}”|1|
|11|检测连接VPN时设备状态|VPN_LOG|com.pekall.cmc.associ.analysis.analyzer.VpnLogDeviceStatusAnalyzer||终端${objectStatus}, 仍成功接入VPN|2|
|12|检测用户登录时设备状态|USER_LOGIN_LOG|com.pekall.cmc.associ.analysis.analyzer.UserLoginDeviceStatusAnalyzer||终端${objectStatus}, 仍成功登录|2|
|13|检测使用警务应用时设备状态|APP_USE_LOG|com.pekall.cmc.associ.analysis.analyzer.AppUseDeviceStatusAnalyzer||终端${objectStatus}, 仍成功使用警务应用“${appName}”|2|
|14|检测访问资源服务时设备状态|RES_VISIT_LOG|com.pekall.cmc.associ.analysis.analyzer.ResVisitDeviceStatusAnalyzer||终端${objectStatus}, 仍成功调用资源服务“${ressvcName}”|2|
|21|检测连接VPN时用户状态|VPN_LOG|com.pekall.cmc.associ.analysis.analyzer.VpnLogUserStatusAnalyzer||用户${objectStatus}, 仍成功接入VPN|3|
|22|检测设备注册时用户状态|DEVICE_REGISTER_LOG|com.pekall.cmc.associ.analysis.analyzer.DeviceRegisterUserStatusAnalyzer||用户${objectStatus},仍成功注册终端|3|
|23|检测用户登录时用户状态|USER_LOGIN_LOG|com.pekall.cmc.associ.analysis.analyzer.UserLoginUserStatusAnalyzer||用户${objectStatus}, 仍成功登录|3|
|24|检测使用警务应用时用户状态|APP_USE_LOG|com.pekall.cmc.associ.analysis.analyzer.AppUseUserStatusAnalyzer||用户${objectStatus}, 仍成功使用警务应用“${appName}”|3|
|25|检测访问资源服务时用户状态|RES_VISIT_LOG|com.pekall.cmc.associ.analysis.analyzer.ResVisitUserStatusAnalyzer||用户${objectStatus}, 仍成功调用资源服务“${ressvcName}”|3|
|34|检测使用警务应用时用户的授权状态|APP_USE_LOG|com.pekall.cmc.associ.analysis.analyzer.AppUseUserAuthorizationAnalyzer||用户使用未授权应用“${appName}”|4|
