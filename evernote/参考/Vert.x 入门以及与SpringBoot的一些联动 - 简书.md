
# Vert.x 入门以及与SpringBoot的一些联动

[![[./_resources/Vert.x_入门以及与SpringBoot的一些联动_-_简书.resources/webp.1.webp]]](https://www.jianshu.com/u/2ad4a4a092f3)

[人形大叔](https://www.jianshu.com/u/2ad4a4a092f3)
_![[./_resources/Vert.x_入门以及与SpringBoot的一些联动_-_简书.resources/embedded.svg]]_0.5362019.06.14 22:36:57字数 2,158阅读 7,301

*   小字：这篇文章探讨的仅仅是Vert.x入门，简要实现以及帮助理解

> ### 按照我的习惯先上结论

生而为了微服务，生而为了高并发，去除了锁概念的框架，Vertx。因为有EventBus的存在打散了传统开发层于层之间的关系，让层的关系变得"松散而有序"，每个Vertx实例都会维护一个队列，所以也就没有了锁的需要（本来在现实中锁这个概念就有点不符合逻辑），这大大的提升了效率。
举一个不太恰当的例子，以前的开发就好比有一个马厩，里面有一个水槽，一次只能容纳一匹马喝水，其他的马想喝水那么就必须排队（阻塞）。好了现在有那么几匹马不太守规矩，从宁一边来抢这个水槽（高并发），为了阻止这种情况出现，我们有了围栏让马儿依次喝水（锁）。
现在有了Vertx，里面的EvevtBus干了一件事情，把这个水槽拉得很长，长到所有的马都可以喝水，不但马可以喝水，其他鹿啊，狗啊，猫啊都可以来喝水，牛逼~

并且Vertx里面还有个执行单元的概念，一个执行单元被注册好之后，开启。如果现在吞吐量到顶了，好了现在骚操作来了，你可以再开启一次。吞吐量翻倍，Vertx里里面的x居然是复数的意思。

> # Vert.x：你随便啊，你有机器我没在怕啊。

> ### 1\. `Vert.x` 简介

*   JVM上的Reative开发套件。`Vert.x`目前是见过最功能最强大，第三方库依赖最少的Java框架，它只依赖`Netty4`以及`Jacskon`。
*   `Vert.x`最大的特点就在于异步（底层基于`Netty`），通过事件循环（`EventLoop`）来调起存储在异步任务队列（`CallBackQueue`）中的任务，大大降低了传统阻塞模型中线程对于操作系统的开销。因此相比较传统的阻塞模型，异步模型能够很大层度的提高系统的并发量。
*   `Vert.x`除了异步之外，还提供了非常多的吸引人的技术，比如`EventBus`，通过`EventBus`可以非常简单的实现分布式消息，进而为分布式系统调用，微服务奠定基础。除此之外，还提供了对多种客户端的支持，比如`Redis`，`RabbitMQ`，`Kafka`等等。
*   多语言使用
*   `Java`版本实现HTTP服务

    public class MyHttpServer extends AbstractVerticle {
        public static void main(String[] args) {
            // 创建服务
            MyHttpServer verticle = new MyHttpServer();
            Vertx vertx = Vertx.vertx();
            // 部署服务，会执行MyHttpServer的start方法
            vertx.deployVerticle(verticle);
        }
        @Override
        public void start() throws Exception {
            // 在这里可以通过this.vertx获取到当前的Vertx
            Vertx vertx = this.vertx;
            // 创建一个HttpServer
            HttpServer server = vertx.createHttpServer();
            server.requestHandler(request -> {
                // 获取到response对象
                HttpServerResponse response = request.response();
                // 设置响应头
                response.putHeader("Content-type", "text/html;charset=utf-8");
                // 响应数据
                response.end("SUCCESS");
            });
            // 指定监听80端口
            server.listen(80);
        }
    }
    1234567891011121314151617181920212223242526

*   `JavaScript`实现HTTP服务

    vertx.createHttpServer()
    .requestHandler(function (req) {
        req.response()
        .putHeader("content-type", "text/plain")
        .end("Hello from ``Vert.x``!");
    }).listen(8080);
    123456

*   另外还可以使用`Groovy`, `Ruby`, `Ceylon`, `Scala` , `Kotlin`;
    
*   不依赖中间件
    
*   完善的生态
    
*   为微服务而生
    

> ### 2\. `Vert.x` 能做什么事情？

Java能做的，`Vert.x`都能做。Node能做的`Vert.x`也能做

*   Web开发，`Vert.x`封装了Web开发常用的组件，支持`路由`、`Session管理`、`模板`等，可以非常方便的进行Web开发。重要的是不需要容器
*   TCP/UDP开发，`Vert.x`底层基于`Netty`，并且进行了完善的封装。
*   原生提供了`WebSocket`的支持。
*   `EventBus`（事件总线）是`Vert.x`的神经系统，通过`EventBus`可以实现分布式消息，远程方法调用等等。正是因为EventBus的存在，`Vert.x`可以非常便捷的开发微服务应用。
*   支持主流的数据和消息的访问`redis`,`mongodb`,`rabbitmq`,`kafka` 等

> ### 3\. 什么是异步编程？

对于习惯使用springboot的我来说异步编程是一个新名词。异步编程是`Vert.x`的一大特性，也是`Vert.x`的核心。可以用`Ajax`来做类比。

    //$.ajax方法并不会阻塞，
    //而是直接向下执行，
    //等到远程服务器响应之后，才会回调success方法，
    //那么这时候success方法才会执行。
    //ajax下面的代码不会等到success方法执行完毕之后再执行
    console.log("1");
    $.ajax({
        "url" : "/hello",
        "type" : "post",
        "dataType" : "json",
        "success" : function(val) {
            console.log("2");
        }
    });
    console.log("3");
    123456789101112131415

类比`Vert.x`

    //可以看到是极为相似的
    System.out.println("1")
    WebClient
        .create(vertx)
        .postAbs(REQUEST_URL) // 这里指定的是请求的地址
        .sendBuffer(buffer, res -> { // buffer是请求的数据
            if (res.succeeded()) {  
                // 请求远程服务成功
                System.out.println("2")
            } else {
                // 请求失败
                resultHandler.handle(Future.failedFuture("请求服务器失败..."));
            }
        });
    System.out.println("3")
    123456789101112131415

> ### 4.性能

*   先看图

\[站外图片上传中...(image-fa87bd-1560523010556)\]

错误率

平均响应时间

*   摘自 [Spring Boot同步架构与Vert.x异步架构高并发性能对比](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fu013615903%2Farticle%2Fdetails%2F79599446)

> 该测试使用jmeter完成，模拟一秒内10000用户同时发出http请求，服务端返回Json数据这样一个流程。第一套架构是Vert.x家族自己的Vert.x-web框架加上Vert.x-JDBC持久化框架；第二套是Vert.x-web与Spring Boot和JPA两个框架整合；第三套是传统的Spring MVC，Spring Boot和JPA框架。三个测试用例均为单http服务器，前两者是Vert.x自带的netty，后者是内嵌的Tomcat。数据库使用的是hsqldb内存数据库，连接池是hikariCP，最大连接数设置为100。Tomcat的线程池最大连接数设置为了1000，可以认为是已经设置到最大值了。出错时，报的错误均为java.net.ConnectException异常，错误消息为Connection refused: connect。应该是并发链接超过了上限，请求被拒绝了。

> 从结果上看，第二套架构性能最优，其吞吐量约为第三套传统架构的3.3倍，错误率也相对较低，第一套虽然错误率高，单吞吐量也大幅超越了传统架构。因此在较为极限的并发测试下，Vert.x架构的性能较传统Spring Boot是有明显优势的。

> 测试框架版本：
> Vert.x系列：3.5.1
> Spring Boot系列：1.5.10.RELEASE
> 测试环境：
> OS：windows 7 64位
> CPU：英特尔 至强 E3-1231 V3
> 内存：8G

> ### 5.思考

`Vert.x`确实非常好，把`Java8`的新特性用得淋漓尽致，而且从上面的性能分析来看，优于传统框架。

*   但是：异步编程以及面向函数的思想和以前太不一样了。还有大量使用`Java8`的新特性。比如`lambda`表达式，可以简化匿名内部类的编写。所以要写好`Vert.x`你必须熟悉`Java`的新特性，不然写出来的代码难以维护。其次是`Vert.x`没有对关系型数据库的`ORM`支持，在传统开发种我们可以选择`Hibernate`或者是`MyBatits`这种`ORM`框架来对数据库进行操作。但`Vert.x`这方面就比较弱了，但也不是不能用只不过封装的比较浅。总之就是一句话，东西是好东西，就是用起来不习惯尤其是数据库操作很繁琐还有大量的匿名内部类。

> ### 6.整合

*   终于说到重点了，那就是`springboot`处理具体业务对接`Vert.x`的URL控制，而且上面的性能分析也指出这种模式比纯Vert.x还要好一点，而且兼顾了传统开发的语法，算是一种过渡，并且积极拥抱新技术，对Java新特性的理解也非常友好。
    
*   首先建立一个springboot项目，并且去掉内置tomcat，我们使用Vert.x来接管路由。
    新建一个StaticServer类来创建一个http服务
    

    /**
     * 交给springboot管理周期
     */
    @Component
    public class StaticServer extends AbstractVerticle {
        private final AppConfiguration configuration;
        private final IServicePrint2Page iServicePrint2Page;
    
        @Autowired
        public StaticServer(AppConfiguration configuration, IServicePrint2Page iServicePrint2Page) {
            //加载配置文件
            this.configuration = configuration;
            this.iServicePrint2Page = iServicePrint2Page;
        }
        @Override
        public void start() {
            //创建路由对象
            Router router = Router.router(vertx);
            //获取整个消息体 放进RoutingContext
            router.route().handler(BodyHandler.create());
            //创建http服务
            HttpServer server = vertx.createHttpServer();
            //发送消息
            //如果后期添加上mybaitis需要用blockingHandler方法来执行操作
            //创建新的线程执行（一般用于执行阻塞调用）
            router.get("/text").blockingHandler(iServicePrint2Page::sendMsg);
            //启动监听
            server.requestHandler(router::accept).listen(configuration.httpPort());
        }
    
    
        /**
         * 结束的时候可以进行一些操作
         * <p>
         * throws Exception
         */
        @Override
        public void stop() throws Exception {
            super.stop();
        }
    }
    1234567891011121314151617181920212223242526272829303132333435363738394041

*   在SpringBoot启动类上添加initVerticle方法添加@PostConstruct注解来让SpringBoot启动的时候执行一次

    
        private final StaticServer staticServer;
        /****
         * 注入Http服务类
         * @param staticServer
         */
        @Autowired
        public SptingvertxApplication(StaticServer staticServer) {
            this.staticServer = staticServer;
        }
        /**
         * 部署Vertx方法
         * <p>
         * PostConstruct 修饰的方法会在服务器加载的时候运行，并且只会被服务器执行一次
         */
        @PostConstruct
        public void initVerticle() {
            Vertx.vertx().deployVerticle(staticServer);
        }
    12345678910111213141516171819

> ### 7.`EventBus`

*   它是Vert.X的核心，在集群中容器之间的通信，各个Verticle之间的通讯都是经过Event Bus来实现的
    
    *   寻址
        消息EventBus发送到一个字符串地址上（address）。任意字符串都是合法的。
    *   处理器
        消息在处理器（Handler）中被接收。您可以在某个地址上注册一个处理器来接收消息。
        同一个地址可以注册许多不同的处理器，一个处理器也可以注册在多个不同的地址上。（**说人话就是：地址可以重复，并且向这个重复的地址发送消息的时候，所有用这个地址注册的Handler都会执行**）
    *   EventBus发布消息
        消息将被发布到一个地址中，发布意味着会将信息传递给 所有 注册在该地址上的处理器。这和 发布/订阅模式 很类似。
    
*   简要实现
    

1.  向`EventBus`发送一条消息

    //唤起一个时间总线
    EventBus eventBus = routingContext.vertx().eventBus();
    //发布消息
    //地址上的所有方法都会收到消息
    //eventBus.send(
    //发送一个简单消息
    //如果使用send。就是点对点模式
    //消息将被发送到一个地址中，
    //Vert.x将会把消息分发到某个注册在该地址上的处理器。
    //若这个地址上有不止一个注册过的处理器，
    //它将使用 不严格的轮询算法 选择其中一个。
    eventBus.send(
        // 消息地址
        SpringVerticle.GET_HELLO_MSG_SERVICE_ADDRESS,
        // 消息内容
        "测试", info -> {//异步处理结果
        if (info.succeeded()) {
            //访问成功
            response.end(info.result().body().toString());
        } else {
            //访问失败
            response.setStatusCode(400).end(info.cause().toString());
        }
    });
    123456789101112131415161718192021222324

2.  `EventBus`消息提取

    //唤起时间总线，注册一个事件处理者（时间消费者
    EventBus eventBus = this.vertx.eventBus();
    eventBus.consumer(GET_HELLO_MSG_SERVICE_ADDRESS).handler(msg -> {
        //获取时间内容吼，调用service服务
        System.out.println("eventBus里面的消息是" + msg.body());
        List<User> users = userService.getAll();
        //把结果返回消息体
        msg.reply(users.toString());
    });
    123456789

3.  注册执行端元

    //我们需要需要把这俩执行端元放在一个Vertx实例里面
    Vertx vertx = Vertx.vertx();
    //注册服务
    vertx.deployVerticle(staticServer);
    vertx.deployVerticle(springVerticle);
    12345

# 参考

> [Vert.x(vertx) 简明介绍](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fking_kgh%2Farticle%2Fdetails%2F80772657)

> [Spring Boot同步架构与Vert.x异步架构高并发性能对比](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fu013615903%2Farticle%2Fdetails%2F79599446)

_![[./_resources/Vert.x_入门以及与SpringBoot的一些联动_-_简书.resources/embedded.1.svg]]_
5人点赞_![[./_resources/Vert.x_入门以及与SpringBoot的一些联动_-_简书.resources/embedded.2.svg]]_

_![[./_resources/Vert.x_入门以及与SpringBoot的一些联动_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/Vert.x_入门以及与SpringBoot的一些联动_-_简书.resources/embedded.4.svg]]_工作上遇到的问题](https://www.jianshu.com/nb/6222363)

_![[./_resources/Vert.x_入门以及与SpringBoot的一些联动_-_简书.resources/embedded.5.svg]]_

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下
[![[./_resources/Vert.x_入门以及与SpringBoot的一些联动_-_简书.resources/webp.webp]]](https://www.jianshu.com/u/2ad4a4a092f3)

[人形大叔](https://www.jianshu.com/u/2ad4a4a092f3)
总资产1 (约0.11元)共写了3945字获得7个赞共5个粉丝

    Created at: 2020-09-27T16:29:02+08:00
    Updated at: 2020-09-27T16:29:02+08:00

