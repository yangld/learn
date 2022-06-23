1. 范围
	1. 清理应用管理，应用市场，运营的download的多余文件
2. 步骤
	1. 在运营中获取不能删除的文件uuid, 生成文件列表
		在根目录下创建子目录，将下面的脚本拷贝到子目录下，执行，拷贝生成的文件到应用管理的upload_data目录中
		![[export-op-uuid.sh]]
	2. 在应用管理中获取不能删除的uuid，生成文件列表
		在/apps/pekall/upload_data目录中执行下面的脚本
		![[export-app-uuid.sh]]
	3. 在应用管理的upload_data目录中，将不能删除的文件移动到其它文件夹
		在/apps/pekall/upload_data目录中执行下面的脚本，生成/apps/pekall/tmp目录
		![[move-uuid-file.sh]]
	4. 将tmp目录改名成upload_data	
