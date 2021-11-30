
# Error:(79, 25) java: 无法访问org.springframework.plugin.core.Plugin 找不到SimplePluginMetadata

![[./_resources/Error_(79,_25)_java__无法访问org.springframework.plugin.core.Plugin_找不到SimplePluginMetadata_imyar-CSDN博客.resources/original.png]]
[起个亮瞎眼的名字真难](https://blog.csdn.net/a462464126) 2019-08-15 11:07:11 ![[./_resources/Error_(79,_25)_java__无法访问org.springframework.plugin.core.Plugin_找不到SimplePluginMetadata_imyar-CSDN博客.resources/articleReadEyes.png]] 4560  

		
分类专栏： [java](https://blog.csdn.net/a462464126/category_2160769.html)

很奇怪的问题，引用swagger2时，return new Docket(DocumentationType.SWAGGER\_2)

DocumentationType.SWAGGER\_2报的错

，其他module没有问题，通过maven引入spring-plugin-metadata也没有解决问题。

尝试拷贝idea其他正常的 .iml并覆盖出错的module 的.iml文件问题解决

    Created at: 2021-02-24T14:08:17+08:00
    Updated at: 2021-02-24T14:08:17+08:00

