
# 第五篇 : SpringBoot 自定义starter

[![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/webp.1.webp]]](https://www.jianshu.com/u/95b81907fe14)

[程序员果果](https://www.jianshu.com/u/95b81907fe14)
_![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/embedded.svg]]_42018.12.03 23:30:55字数 588阅读 9,909

> 文章首发于微信公众号《程序员果果》
> 地址：[https://mp.weixin.qq.com/s/F\_1j-ng49QNlbj04Q9bqFQ](https://links.jianshu.com/go?to=https%3A%2F%2Fmp.weixin.qq.com%2Fs%2FF_1j-ng49QNlbj04Q9bqFQ)
> 本篇源码：[https://github.com/gf-huanchupk/SpringBootLearning](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fgf-huanchupk%2FSpringBootLearning)

## 一、简介

SpringBoot 最强大的功能就是把我们常用的场景抽取成了一个个starter（场景启动器），我们通过引入springboot 为我提供的这些场景启动器，我们再进行少量的配置就能使用相应的功能。即使是这样，springboot也不能囊括我们所有的使用场景，往往我们需要自定义starter，来简化我们对springboot的使用。

## 二、如何自定义starter

### 1.实例

#### 如何编写自动配置 ？

我们参照@WebMvcAutoConfiguration为例，我们看看们需要准备哪些东西，下面是WebMvcAutoConfiguration的部分代码：

    @Configuration
    @ConditionalOnWebApplication
    @ConditionalOnClass({Servlet.class, DispatcherServlet.class, WebMvcConfigurerAdapter.class})
    @ConditionalOnMissingBean({WebMvcConfigurationSupport.class})
    @AutoConfigureOrder(-2147483638)
    @AutoConfigureAfter({DispatcherServletAutoConfiguration.class, ValidationAutoConfiguration.class})
    public class WebMvcAutoConfiguration {
    
        @Import({WebMvcAutoConfiguration.EnableWebMvcConfiguration.class})
        @EnableConfigurationProperties({WebMvcProperties.class, ResourceProperties.class})
        public static class WebMvcAutoConfigurationAdapter extends WebMvcConfigurerAdapter {
    
            @Bean
            @ConditionalOnBean({View.class})
            @ConditionalOnMissingBean
            public BeanNameViewResolver beanNameViewResolver() {
                BeanNameViewResolver resolver = new BeanNameViewResolver();
                resolver.setOrder(2147483637);
                return resolver;
            }
        }
    }
    12345678910111213141516171819202122

我们可以抽取到我们自定义starter时同样需要的一些配置。

    @Configuration  //指定这个类是一个配置类
    @ConditionalOnXXX  //指定条件成立的情况下自动配置类生效
    @AutoConfigureOrder  //指定自动配置类的顺序
    @Bean  //向容器中添加组件
    @ConfigurationProperties  //结合相关xxxProperties来绑定相关的配置
    @EnableConfigurationProperties  //让xxxProperties生效加入到容器中
    
    自动配置类要能加载需要将自动配置类，配置在META-INF/spring.factories中
    org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
    org.springframework.boot.autoconfigure.admin.SpringApplicationAdminJmxAutoConfiguration,\
    org.springframework.boot.autoconfigure.aop.AopAutoConfiguration,\
    1234567891011

#### 模式

我们参照 **spring-boot-starter** 我们发现其中没有代码：

![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/webp.2.webp]]

我们在看它的pom中的依赖中有个 **springboot-starter**

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter</artifactId>
    </dependency>
    1234

我们再看看 **spring-boot-starter** 有个 **spring-boot-autoconfigure**

    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-autoconfigure</artifactId>
    </dependency>
    1234

关于web的一些自动配置都写在了这里 ，所以我们有总结：

    启动器starter只是用来做依赖管理
    需要专门写一个类似spring-boot-autoconfigure的配置模块
    用的时候只需要引入启动器starter，就可以使用自动配置了
    123

#### 命名规范

**官方命名空间**

*   前缀：spring-boot-starter-
*   模式：spring-boot-starter-模块名
*   举例：spring-boot-starter-web、spring-boot-starter-jdbc

**自定义命名空间**

*   后缀：-spring-boot-starter
*   模式：模块-spring-boot-starter
*   举例：mybatis-spring-boot-starter

## 三、自定义starter实例

我们需要先创建两个工程 **hello-spring-boot-starter** 和 **hello-spring-boot-starter-autoconfigurer**

### 1\. hello-spring-boot-starter

#### 1.pom.xml

    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>
    
        <groupId>com.gf</groupId>
        <artifactId>hello-spring-boot-starter</artifactId>
        <version>0.0.1-SNAPSHOT</version>
        <packaging>jar</packaging>
    
        <name>hello-spring-boot-starter</name>
    
        <!-- 启动器 -->
        <dependencies>
            <!-- 引入自动配置模块 -->
            <dependency>
                <groupId>com.gf</groupId>
                <artifactId>hello-spring-boot-starter-autoconfigurer</artifactId>
                <version>0.0.1-SNAPSHOT</version>
            </dependency>
        </dependencies>
    
    
    </project>
    
    12345678910111213141516171819202122232425

同时删除 启动类、resources下的文件，test文件。

### 2\. hello-spring-boot-starter-autoconfigurer

#### 1\. pom.xml

    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>
    
        <groupId>com.gf</groupId>
        <artifactId>hello-spring-boot-starter-autoconfigurer</artifactId>
        <version>0.0.1-SNAPSHOT</version>
        <packaging>jar</packaging>
    
        <name>hello-spring-boot-starter-autoconfigurer</name>
        <description>Demo project for Spring Boot</description>
    
        <parent>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-parent</artifactId>
            <version>1.5.9.RELEASE</version>
            <relativePath/> <!-- lookup parent from repository -->
        </parent>
    
        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
            <java.version>1.8</java.version>
        </properties>
    
        <dependencies>
            <!-- 引入spring-boot-starter，所有starter的基本配合 -->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter</artifactId>
            </dependency>
    
        </dependencies>
    
    
    </project>
    
    1234567891011121314151617181920212223242526272829303132333435363738

#### 2\. HelloProperties

    package com.gf.service;
    
    import org.springframework.boot.context.properties.ConfigurationProperties;
    
    @ConfigurationProperties(prefix = "gf.hello")
    public class HelloProperties {
    
        private String prefix;
        private String suffix;
    
        public String getPrefix() {
            return prefix;
        }
    
        public void setPrefix(String prefix) {
            this.prefix = prefix;
        }
    
        public String getSuffix() {
            return suffix;
        }
    
        public void setSuffix(String suffix) {
            this.suffix = suffix;
        }
    
    }
    
    12345678910111213141516171819202122232425262728

#### 3\. HelloService

    package com.gf.service;
    
    
    public class HelloService {
    
        HelloProperties helloProperties;
    
        public HelloProperties getHelloProperties() {
            return helloProperties;
        }
    
        public void setHelloProperties(HelloProperties helloProperties) {
            this.helloProperties = helloProperties;
        }
    
        public String sayHello(String name ) {
            return helloProperties.getPrefix()+ "-" + name + helloProperties.getSuffix();
        }
    }
    
    1234567891011121314151617181920

#### 4\. HelloServiceAutoConfiguration

    package com.gf.service;
    
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
    import org.springframework.boot.context.properties.EnableConfigurationProperties;
    import org.springframework.context.annotation.Bean;
    import org.springframework.context.annotation.Configuration;
    
    @Configuration
    @ConditionalOnWebApplication //web应该生效
    @EnableConfigurationProperties(HelloProperties.class)
    public class HelloServiceAutoConfiguration {
    
        @Autowired
        HelloProperties helloProperties;
    
        @Bean
        public HelloService helloService() {
            HelloService service = new HelloService();
            service.setHelloProperties( helloProperties  );
            return service;
        }
    
    
    }
    
    1234567891011121314151617181920212223242526

#### 5\. spring.factories

在 **resources** 下创建文件夹 **META-INF** 并在 **META-INF** 下创建文件 **spring.factories** ，内容如下：

    # Auto Configure
    org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
    com.gf.service.HelloServiceAutoConfiguration
    123

到这儿，我们的配置自定义的starter就写完了 ，我们hello-spring-boot-starter-autoconfigurer、hello-spring-boot-starter 安装成本地jar包。

## 三、测试自定义starter

我们创建个项目 **hello-spring-boot-starter-test**，来测试系我们写的stater。

### 1\. pom.xml

    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>
    
        <groupId>com.gf</groupId>
        <artifactId>hello-spring-boot-starter-test</artifactId>
        <version>0.0.1-SNAPSHOT</version>
        <packaging>jar</packaging>
    
        <name>hello-spring-boot-starter-test</name>
        <description>Demo project for Spring Boot</description>
    
        <parent>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-parent</artifactId>
            <version>1.5.9.RELEASE</version>
            <relativePath/> <!-- lookup parent from repository -->
        </parent>
    
        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
            <java.version>1.8</java.version>
        </properties>
    
        <dependencies>
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-web</artifactId>
            </dependency>
    
            <!-- 引入自定义starter -->
            <dependency>
                <groupId>com.gf</groupId>
                <artifactId>hello-spring-boot-starter</artifactId>
                <version>0.0.1-SNAPSHOT</version>
            </dependency>
    
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-test</artifactId>
                <scope>test</scope>
            </dependency>
        </dependencies>
    
        <build>
            <plugins>
                <plugin>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-maven-plugin</artifactId>
                </plugin>
            </plugins>
        </build>
    
    
    </project>
    
    12345678910111213141516171819202122232425262728293031323334353637383940414243444546474849505152535455565758

### 2\. HelloController

    package com.gf.controller;
    
    import com.gf.service.HelloService;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.PathVariable;
    import org.springframework.web.bind.annotation.RestController;
    
    @RestController
    public class HelloController {
    
        @Autowired
        HelloService helloService;
    
        @GetMapping("/hello/{name}")
        public String hello(@PathVariable(value = "name") String name) {
            return helloService.sayHello( name + " , " );
        }
    
    }
    
    123456789101112131415161718192021

### 3\. application.properties

    gf.hello.prefix = hi
    gf.hello.suffix = what's up man ?
    12

我运行项目访问 [http://127.0.0.1:8080/hello/zhangsan](https://links.jianshu.com/go?to=http%3A%2F%2F127.0.0.1%3A8080%2Fhello%2Fzhangsan)，结果如下：

    hi-zhangsan , what's up man ? 
    1

源码下载: [https://github.com/gf-huanchupk/SpringBootLearning](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fgf-huanchupk%2FSpringBootLearning)

![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/webp.3.webp]]

_![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/embedded.1.svg]]_
35人点赞_![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/embedded.2.svg]]_

_![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/embedded.3.svg]]_

[_![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/embedded.4.svg]]_Spring Boot](https://www.jianshu.com/nb/31369204)

_![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/embedded.5.svg]]_

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下
[![[./_resources/第五篇___SpringBoot_自定义starter_-_简书.resources/webp.webp]]](https://www.jianshu.com/u/95b81907fe14)

[程序员果果](https://www.jianshu.com/u/95b81907fe14)欢迎关注公众号——《程序员果果》 ，分享SpringBoot、SpringCloud、Dubb...
总资产145 (约12.35元)共写了5.0W字获得1,587个赞共466个粉丝

    Created at: 2020-09-10T13:56:50+08:00
    Updated at: 2020-09-10T13:56:50+08:00

