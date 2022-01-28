1. 获取运行中的源代码
	1. `jad --source-only com.example.demo.arthas.user.UserController > /tmp/UserController.java`
2. 编辑源代码
3. 编译源代码
	1. 获取classLoader
		1. `sc -d *UserController | grep classLoaderHash`
	2. 编译修改后的源代码, 使用获取的classLoader
		1. `mc -c 1be6f5c3 /tmp/UserController.java -d /tmp`
4. 热更新
	1. `redefine /tmp/com/example/demo/arthas/user/UserController.class`