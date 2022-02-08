
# Jersey是一个什么框架,价值在哪里？

[![[8知识管理/InBox/evernote/参考/_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/webp.webp]]](https://www.jianshu.com/u/0200b1f7befa)

[随风而去霸](https://www.jianshu.com/u/0200b1f7befa)
_![[./_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/embedded.svg]]_0.2572019.04.10 12:28:41字数 413阅读 12,476

Jersey是一个RESTFUL请求服务JAVA框架，与常规的JAVA编程使用的struts框架类似，它主要用于处理业务逻辑层。

与springmvc 的区别：

    1. jersey同样提供DI，是由glassfish hk2实现，也就是说，如果想单独使用jersey一套，需要另外学习Bean容器；
    
    2. MVC出发点即是WEB，但jersey出发点确实RESTFull，体现点在与接口的设计方面，
    如MVC返回复杂结构需要使用ModelAndView,而jersey仅仅需要返回一个流或者文件句柄；
    
    3. jersey提供一种子资源的概念，这也是RESTFull中提倡所有url都是资源；
    
    4. jersey直接提供application.wadl资源url说明；
    
    5. MVC提供Session等状态管理，jersey没有，这个源自RESTFull设计无状态化；
    
    6. Response方法支持更好返回结果，方便的返回Status，包括200，303，401，403；
    
    7. 提供超级特别方便的方式访问RESTFull;
    1234567891011121314

## Jersey是一个是 webservice框架。

jersey
1.X的版本是sun公司提供的独立的jar包，
在2.X版本中，已经将jersey融合到JavaSE中，在javax.ws.rs.\*包中。

与Struts类似，它同样可以和hibernate,spring框架整合。

> 什么是REST？
> REST指的是一种架构风格的名称，这里的风格，不同于我们通常所说的个性化的含义，它代表的一组特征，在软件领域我们把它叫做架构约束。

    由于Struts2+hibernate+spring整合在市场的占有率太高，所以很少一部分人去关注Jersey。
    
    所以网上有关于Jersey的介绍很少。
    但是它确实是一个非常不错的框架。
    对于请求式服务，对于GET,DELETE请求，你甚至只需要给出一个URI即可完成操作。
    
    举个简单的例子：如果你想获得服务器数据库中的所有数据；
    
    那么你可以在浏览器或者利用Ajax的GET方法，将路径设置好；
    例如：localhost:8080/Student(项目名称)/studentinfo(项目服务总体前缀)/student(处理student对象的签注)/getStudentInfo(最后前缀)。
    
    你可以选择GET获取的数据的返回类型：JSON,XML,TEXT_HTML(String)..获取之后，你可以通过JS将这些数据塞到html或者jsp页面上。
    123456789101112

> jersey常用注解解释：

    @Path
    uri路径
    定义资源的访问路径，client通过这个路径访问资源。比如：@Path("user")
    
    @Produces
    返回
    指定返回MIME格式
    资源按照那种数据格式返回，可取的值有：MediaType.APPLICATION_XXX。比如：@Produces(MediaType.APPLICATION_XML)
    
    @Consumes
    接收入参
    接受指定的MIME格式
    只有符合这个参数设置的请求再能访问到这个资源。比如@Consumes("application/x-www-form-urlencoded")
    
    @PathParam
    uri路径参数
    写在方法的参数中，获得请求路径参数。比如：@PathParam("username")  String userName
    
    123456789101112131415161718

> 资源加载器，将各种资源加载进来，暴露给client。

有两种加载资源的方式，一种是使用自己的资源加载器去加载资源，需要给出自己资源加载器的位置。另一种是使用默认的资源加载器加载，需要给出资源所在的package。

第一种，写一个自己的资源加载器去加载想要加载的资源，这样感觉可控性强一点，可以加载业务资源以外，还可以加载日子和其他的需要一些工具资源等等

或者package下的某个资源不想被暴露，就不要加载进来就可以了。

    package com.jersey.service;
    import org.glassfish.jersey.server.ResourceConfig;
    public class MyServiceRegister extends ResourceConfig {
        public MyServiceRegister() {
            //需要加载的资源放进来
            register(HelloWorld.class);
        }
    }
    12345678

在web.xml中添加配置，引入jersey，同时配置资源加载器

    <servlet>
        <servlet-name>jersey-servlet</servlet-name>
        <servlet-class>
            org.glassfish.jersey.servlet.ServletContainer
        </servlet-class>
        <!-- 配置自己的资源加载类去加载资源 -->
        <init-param>
            <param-name>javax.ws.rs.Application</param-name>
            <param-value>com.jersey.service.MyServiceRegister</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
      </servlet>
      <servlet-mapping>
        <servlet-name>jersey-servlet</servlet-name>
        <url-pattern>/rest/*</url-pattern>
      </servlet-mapping>
    12345678910111213141516

> 客户端调用webservice接口:

    package com.jersey.client;
     
    import javax.ws.rs.client.Client;
    import javax.ws.rs.client.ClientBuilder;
    import javax.ws.rs.client.WebTarget;
    import javax.ws.rs.client.Invocation.Builder;
    import javax.ws.rs.core.MediaType;
     
    public class TestClient {
     
        public static void main(String[] args) {
            String url = "http://192.168.1.134:8080/MyJersey/rest";
            Client client = ClientBuilder.newClient();
            WebTarget webTarget = client.target(url).path("HelloWorld").path("sayHello/admin");
            Builder builder = webTarget.request(MediaType.APPLICATION_JSON);
            String result = builder.get(String.class);
            System.out.println(result);
        }
    }
    12345678910111213141516171819

![[8知识管理/InBox/evernote/参考/_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/webp.1.webp]]

image.png

    <!-- jersey restful -->
            <dependency>
                 <groupId>com.sun.jersey</groupId>
                 <artifactId>jersey-client</artifactId>
                 <version>${jersey.version}</version>
            </dependency>
            <dependency>
                 <groupId>com.sun.jersey</groupId>
                 <artifactId>jersey-server</artifactId>
                 <version>${jersey.version}</version>
            </dependency>
            <!-- Jersey restful+ Spring -->
            <dependency>
                 <groupId>com.sun.jersey.contribs</groupId>
                 <artifactId>jersey-spring</artifactId>
                 <version>${jersey.version}</version>
                 <exclusions>
                      <exclusion>
                          <groupId>org.springframework</groupId>
                          <artifactId>spring</artifactId>
                      </exclusion>
                      <exclusion>
                          <groupId>org.springframework</groupId>
                          <artifactId>spring-core</artifactId>
                      </exclusion>
                      <exclusion>
                          <groupId>org.springframework</groupId>
                          <artifactId>spring-web</artifactId>
                      </exclusion>
                      <exclusion>
                          <groupId>org.springframework</groupId>
                          <artifactId>spring-beans</artifactId>
                      </exclusion>
                      <exclusion>
                          <groupId>org.springframework</groupId>
                          <artifactId>spring-context</artifactId>
                      </exclusion>
                      <exclusion>
                          <groupId>org.springframework</groupId>
                          <artifactId>spring-aop</artifactId>
                      </exclusion>
                      <exclusion>
                          <groupId>org.springframework</groupId>
                          <artifactId>spring-asm</artifactId>
                      </exclusion>
                 </exclusions>
            </dependency>
    1234567891011121314151617181920212223242526272829303132333435363738394041424344454647

_![[./_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/embedded.1.svg]]_
4人点赞_![[./_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/embedded.2.svg]]_

_![[./_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/embedded.4.svg]]_web架构](https://www.jianshu.com/nb/35750979)

_![[./_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/embedded.5.svg]]_

[![[8知识管理/InBox/evernote/参考/_resources/Jersey是一个什么框架,价值在哪里？_-_简书.resources/webp.2.webp]]](https://www.jianshu.com/u/0200b1f7befa)

[随风而去霸](https://www.jianshu.com/u/0200b1f7befa)xushuai互联网电子商务 产品建设 及 技术研发
总资产117 (约8.38元)共写了2.6W字获得35个赞共14个粉丝

    Created at: 2020-11-13T11:54:13+08:00
    Updated at: 2020-11-13T11:54:13+08:00

