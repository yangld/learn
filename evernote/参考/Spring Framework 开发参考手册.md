
[![[./_resources/Spring_Framework_开发参考手册.resources/unknown_filename.jpeg]]](http://www.springframework.org/)[![[./_resources/Spring_Framework_开发参考手册.resources/unknown_filename.1.png]]](http://www.springsource.com/)

# Spring Framework 开发参考手册

## Authors

Rod Johnson, Juergen Hoeller, Alef Arendsen, Colin Sampaleanu, Rob Harrop, Thomas Risberg, Darren Davison, Dmitriy Kopylenko, Mark Pollack, Thierry Templier, Erwin Vervaet, Portia Tung, Ben Hale, Adrian Colyer, John Lewis, Costin Leau, Mark Fisher, Sam Brannen, Ramnivas Laddad

2.5.2

Copies of this document may be made for your own use and for distribution to others, provided that you do not charge any fee for such copies and further provided that each copy contains this Copyright Notice, whether distributed in print or electronically.

* * *

**Table of Contents**

[前言](http://shouce.jb51.net/spring/preface.html)
1\. [简介](http://shouce.jb51.net/spring/introduction.html)

1.1. [概览](http://shouce.jb51.net/spring/introduction.html#introduction-overview)

1.1.1. [使用场景](http://shouce.jb51.net/spring/introduction.html#overview-usagescenarios)

2\. [Spring 2.0和 2.5的新特性](http://shouce.jb51.net/spring/new-in-2.html)

2.1. [简介](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-intro)
2.2. [控制反转(IoC)容器](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-ioc)

2.2.1. [新的bean作用域](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-ioc-scopes)
2.2.2. [更简单的XML配置](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-ioc-configuration)
2.2.3. [可扩展的XML编写](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-ioc-custom-configuration)
2.2.4. [Annotation(注解)驱动配置](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-ioc-annotations)
2.2.5. [在classpath中自动搜索组件](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-ioc-component-scanning)

2.3. [面向切面编程(AOP)](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-aop)

2.3.1. [更加简单的AOP XML配置](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-aop-configuration)
2.3.2. [对@AspectJ 切面的支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-aop-aspectj)
2.3.3. [对bean命名pointcut( bean name pointcut element)的支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-aop-bean-pointcuts)
2.3.4. [对AspectJ装载时织入（AspectJ load-time weaving）的支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-aop-load-time-weaving)

2.4. [中间层](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-middle-tier)

2.4.1. [在XML里更为简单的声明性事务配置](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-middle-tier-transaction-configuration)
2.4.2. [对Websphere 事务管理的完整支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-middle-tier-websphere)
2.4.3. [JPA](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-middle-tier-jpa)
2.4.4. [异步的JMS](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-middle-tier-async-jms)
2.4.5. [JDBC](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-middle-tier-jdbc)

2.5. [Web层](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-web)

2.5.1. [Spring MVC合理的默认值](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-web-convention)
2.5.2. [Portlet 框架](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-web-portlet)
2.5.3. [基于Annotation的控制器](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-web-annotations)
2.5.4. [Spring MVC的表单标签库](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-web-form-tags)
2.5.5. [对Tiles 2 支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-web-tiles2)
2.5.6. [对JSF 1.2支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-web-jsf12)
2.5.7. [JAX-WS支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-web-jaxws)

2.6. [其他](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other)

2.6.1. [动态语言支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other-dynamic-language-support)
2.6.2. [增强的测试支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other-testing)
2.6.3. [JMX 支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other-jmx)
2.6.4. [将Spring 应用程序上下文部署为JCA adapter](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other-jca)
2.6.5. [计划任务](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other-taskexecutor)
2.6.6. [对Java 5 (Tiger) 支持](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other-java5)

2.7. [移植到Spring 2.5](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating)

2.7.1. [改变](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-changes)

2.7.1.1. [支持的JDK版本](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-jdk)
2.7.1.2. [Spring 2.5的Jar打包](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-packaging)
2.7.1.3. [XML配置](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-xml-configuration)
2.7.1.4. [Deprecated（淘汰）的类和方法](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-deprecated)
2.7.1.5. [Apache OJB](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-ojb)
2.7.1.6. [iBATIS](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-ibatis)
2.7.1.7. [Hibernate](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-hibernate)
2.7.1.8. [JDO](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-jdo)
2.7.1.9. [UrlFilenameViewController](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-migrating-UrlFilenameViewController)

2.8. [更新的样例应用](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other-applications)
2.9. [改进的文档](http://shouce.jb51.net/spring/new-in-2.html#new-in-2-other-documentation)

I. [核心技术](http://shouce.jb51.net/spring/spring-core.html)

3\. [IoC(控制反转)容器](http://shouce.jb51.net/spring/beans.html)

3.1. [简介](http://shouce.jb51.net/spring/beans.html#beans-introduction)
3.2. [基本原理 - 容器和bean](http://shouce.jb51.net/spring/beans.html#beans-basics)

3.2.1. [容器](http://shouce.jb51.net/spring/beans.html#beans-factory)

3.2.1.1. [配置元数据](http://shouce.jb51.net/spring/beans.html#beans-factory-metadata)

3.2.2. [实例化容器](http://shouce.jb51.net/spring/beans.html#beans-factory-instantiation)

3.2.2.1. [XML配置元数据的结构](http://shouce.jb51.net/spring/beans.html#beans-factory-xml-import)

3.2.3. [多种bean](http://shouce.jb51.net/spring/beans.html#beans-definition)

3.2.3.1. [bean的命名](http://shouce.jb51.net/spring/beans.html#beans-beanname)
3.2.3.2. [实例化bean](http://shouce.jb51.net/spring/beans.html#beans-factory-class)

3.2.4. [使用容器](http://shouce.jb51.net/spring/beans.html#beans-factory-client)

3.3. [依赖](http://shouce.jb51.net/spring/beans.html#beans-dependencies)

3.3.1. [注入依赖](http://shouce.jb51.net/spring/beans.html#beans-factory-collaborators)

3.3.1.1. [构造器注入](http://shouce.jb51.net/spring/beans.html#beans-constructor-injection)
3.3.1.2. [Setter注入](http://shouce.jb51.net/spring/beans.html#beans-setter-injection)
3.3.1.3. [一些例子](http://shouce.jb51.net/spring/beans.html#beans-some-examples)

3.3.2. [依赖配置详解](http://shouce.jb51.net/spring/beans.html#beans-factory-properties-detailed)

3.3.2.1. [直接变量(基本类型、Strings类型等。)](http://shouce.jb51.net/spring/beans.html#beans-value-element)
3.3.2.2. [引用其它的bean（协作者）](http://shouce.jb51.net/spring/beans.html#beans-ref-element)
3.3.2.3. [内部bean](http://shouce.jb51.net/spring/beans.html#beans-inner-beans)
3.3.2.4. [集合](http://shouce.jb51.net/spring/beans.html#beans-collection-elements)
3.3.2.5. [Nulls](http://shouce.jb51.net/spring/beans.html#beans-null-element)
3.3.2.6. [XML配置文件的简写及其他](http://shouce.jb51.net/spring/beans.html#xml-config-shortcuts)
3.3.2.7. [组合属性名称](http://shouce.jb51.net/spring/beans.html#beans-compound-property-names)

3.3.3. [使用depends-on](http://shouce.jb51.net/spring/beans.html#beans-factory-dependson)
3.3.4. [延迟初始化bean](http://shouce.jb51.net/spring/beans.html#beans-factory-lazy-init)
3.3.5. [自动装配（autowire）协作者](http://shouce.jb51.net/spring/beans.html#beans-factory-autowire)

3.3.5.1. [将bean排除在自动装配之外](http://shouce.jb51.net/spring/beans.html#beans-factory-autowire-candidate)

3.3.6. [依赖检查](http://shouce.jb51.net/spring/beans.html#beans-factory-dependencies)
3.3.7. [方法注入](http://shouce.jb51.net/spring/beans.html#beans-factory-method-injection)

3.3.7.1. [Lookup方法注入](http://shouce.jb51.net/spring/beans.html#beans-factory-lookup-method-injection)
3.3.7.2. [自定义方法的替代方案](http://shouce.jb51.net/spring/beans.html#beans-factory-arbitrary-method-replacement)

3.4. [Bean的作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes)

3.4.1. [Singleton作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-singleton)
3.4.2. [Prototype作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-prototype)
3.4.3. [Singleton beans和prototype-bean的依赖](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-sing-prot-interaction)
3.4.4. [其他作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-other)

3.4.4.1. [初始化web配置](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-other-web-configuration)
3.4.4.2. [Request作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-request)
3.4.4.3. [Session作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-session)
3.4.4.4. [global session作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-global-session)
3.4.4.5. [作用域bean与依赖](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-other-injection)

3.4.5. [自定义作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-custom)

3.4.5.1. [创建自定义作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-custom-creating)
3.4.5.2. [使用自定义作用域](http://shouce.jb51.net/spring/beans.html#beans-factory-scopes-custom-using)

3.5. [定制bean特性](http://shouce.jb51.net/spring/beans.html#beans-factory-nature)

3.5.1. [生命周期回调](http://shouce.jb51.net/spring/beans.html#beans-factory-lifecycle)

3.5.1.1. [初始化回调](http://shouce.jb51.net/spring/beans.html#beans-factory-lifecycle-initializingbean)
3.5.1.2. [析构回调](http://shouce.jb51.net/spring/beans.html#beans-factory-lifecycle-disposablebean)
3.5.1.3. [缺省的初始化和析构方法](http://shouce.jb51.net/spring/beans.html#beans-factory-lifecycle-default-init-destroy-methods)
3.5.1.4. [组合生命周期机制](http://shouce.jb51.net/spring/beans.html#beans-factory-lifecycle-combined-effects)
3.5.1.5. [在非web应用中优雅地关闭Spring IoC容器](http://shouce.jb51.net/spring/beans.html#beans-factory-shutdown)

3.5.2. [了解自己](http://shouce.jb51.net/spring/beans.html#beans-factory-aware)

3.5.2.1. [BeanFactoryAware](http://shouce.jb51.net/spring/beans.html#beans-factory-aware-beanfactoryaware)
3.5.2.2. [BeanNameAware](http://shouce.jb51.net/spring/beans.html#beans-factory-aware-beannameaware)

3.6. [bean定义的继承](http://shouce.jb51.net/spring/beans.html#beans-child-bean-definitions)
3.7. [容器扩展点](http://shouce.jb51.net/spring/beans.html#beans-factory-extension)

3.7.1. [用BeanPostProcessor定制bean](http://shouce.jb51.net/spring/beans.html#beans-factory-extension-bpp)

3.7.1.1. [使用BeanPostProcessor的Hello World示例](http://shouce.jb51.net/spring/beans.html#beans-factory-extension-bpp-examples-hw)
3.7.1.2. [RequiredAnnotationBeanPostProcessor示例](http://shouce.jb51.net/spring/beans.html#beans-factory-extension-bpp-examples-rabpp)

3.7.2. [用BeanFactoryPostProcessor定制配置元数据](http://shouce.jb51.net/spring/beans.html#beans-factory-extension-factory-postprocessors)

3.7.2.1. [PropertyPlaceholderConfigurer示例](http://shouce.jb51.net/spring/beans.html#beans-factory-placeholderconfigurer)
3.7.2.2. [PropertyOverrideConfigurer示例](http://shouce.jb51.net/spring/beans.html#beans-factory-overrideconfigurer)

3.7.3. [使用FactoryBean定制实例化逻辑](http://shouce.jb51.net/spring/beans.html#beans-factory-extension-factorybean)

3.8. [The ApplicationContext](http://shouce.jb51.net/spring/beans.html#context-introduction)

3.8.1. [BeanFactory 还是 ApplicationContext?](http://shouce.jb51.net/spring/beans.html#context-introduction-ctx-vs-beanfactory)
3.8.2. [利用MessageSource实现国际化](http://shouce.jb51.net/spring/beans.html#context-functionality-messagesource)
3.8.3. [事件](http://shouce.jb51.net/spring/beans.html#context-functionality-events)
3.8.4. [底层资源的访问](http://shouce.jb51.net/spring/beans.html#context-functionality-resources)
3.8.5. [ApplicationContext在WEB应用中的实例化](http://shouce.jb51.net/spring/beans.html#context-create)

3.9. [粘合代码和可怕的singleton](http://shouce.jb51.net/spring/beans.html#beans-glue-code-and-singletons)
3.10. [以J2EE RAR文件的形式部署Spring ApplicationContext](http://shouce.jb51.net/spring/beans.html#beans-rar-deployment)
3.11. [基于注解（Annotation-based）的配置](http://shouce.jb51.net/spring/beans.html#beans-annotation-config)

3.11.1. [@Autowired](http://shouce.jb51.net/spring/beans.html#beans-autowired-annotation)
3.11.2. [基于注解的自动连接微调](http://shouce.jb51.net/spring/beans.html#beans-autowired-annotation-qualifiers)
3.11.3. [CustomAutowireConfigurer](http://shouce.jb51.net/spring/beans.html#beans-custom-autowire-configurer)
3.11.4. [@Resource](http://shouce.jb51.net/spring/beans.html#beans-resource-annotation)
3.11.5. [@PostConstruct 与 @PreDestroy](http://shouce.jb51.net/spring/beans.html#beans-postconstruct-and-predestroy-annotations)

3.12. [对受管组件的Classpath扫描](http://shouce.jb51.net/spring/beans.html#beans-classpath-scanning)

3.12.1. [@Component和更多典型化注解](http://shouce.jb51.net/spring/beans.html#beans-stereotype-annotations)
3.12.2. [自动检测组件](http://shouce.jb51.net/spring/beans.html#beans-scanning-autodetection)
3.12.3. [使用过滤器自定义扫描](http://shouce.jb51.net/spring/beans.html#beans-scanning-filters)
3.12.4. [自动检测组件的命名](http://shouce.jb51.net/spring/beans.html#beans-scanning-name-generator)
3.12.5. [为自动检测的组件提供一个作用域](http://shouce.jb51.net/spring/beans.html#beans-scanning-scope-resolver)
3.12.6. [用注解提供限定符元数据](http://shouce.jb51.net/spring/beans.html#beans-scanning-qualifiers)

3.13. [注册一个LoadTimeWeaver](http://shouce.jb51.net/spring/beans.html#context-load-time-weaver)

4\. [资源](http://shouce.jb51.net/spring/resources.html)

4.1. [简介](http://shouce.jb51.net/spring/resources.html#resources-introduction)
4.2. [Resource接口](http://shouce.jb51.net/spring/resources.html#resources-resource)
4.3. [内置 Resource 实现](http://shouce.jb51.net/spring/resources.html#resources-implementations)

4.3.1. [UrlResource](http://shouce.jb51.net/spring/resources.html#resources-implementations-urlresource)
4.3.2. [ClassPathResource](http://shouce.jb51.net/spring/resources.html#resources-implementations-classpathresource)
4.3.3. [FileSystemResource](http://shouce.jb51.net/spring/resources.html#resources-implementations-filesystemresource)
4.3.4. [ServletContextResource](http://shouce.jb51.net/spring/resources.html#resources-implementations-servletcontextresource)
4.3.5. [InputStreamResource](http://shouce.jb51.net/spring/resources.html#resources-implementations-inputstreamresource)
4.3.6. [ByteArrayResource](http://shouce.jb51.net/spring/resources.html#resources-implementations-bytearrayresource)

4.4. [ResourceLoader接口](http://shouce.jb51.net/spring/resources.html#resources-resourceloader)
4.5. [ResourceLoaderAware 接口](http://shouce.jb51.net/spring/resources.html#resources-resourceloaderaware)
4.6. [把Resource作为属性来配置](http://shouce.jb51.net/spring/resources.html#resources-as-dependencies)
4.7. [Application context 和Resource 路径](http://shouce.jb51.net/spring/resources.html#resources-app-ctx)

4.7.1. [构造application context](http://shouce.jb51.net/spring/resources.html#resources-app-ctx-construction)

4.7.1.1. [创建 ClassPathXmlApplicationContext 实例 - 简介](http://shouce.jb51.net/spring/resources.html#resources-app-ctx-classpathxml)

4.7.2. [Application context构造器中资源路径的通配符](http://shouce.jb51.net/spring/resources.html#resources-app-ctx-wildcards-in-resource-paths)

4.7.2.1. [Ant风格的pattern](http://shouce.jb51.net/spring/resources.html#resources-app-ctx-ant-patterns-in-paths)
4.7.2.2. [classpath\*: 前缀](http://shouce.jb51.net/spring/resources.html#resources-classpath-wildcards)
4.7.2.3. [其他关于通配符的说明](http://shouce.jb51.net/spring/resources.html#resources-wildcards-in-path-other-stuff)

4.7.3. [FileSystemResource 说明](http://shouce.jb51.net/spring/resources.html#resources-filesystemresource-caveats)

5\. [校验，数据绑定，BeanWrapper，与属性编辑器](http://shouce.jb51.net/spring/validation.html)

5.1. [简介](http://shouce.jb51.net/spring/validation.html#validation-introduction)
5.2. [使用Spring的Validator接口进行校验](http://shouce.jb51.net/spring/validation.html#validator)
5.3. [从错误代码到错误信息](http://shouce.jb51.net/spring/validation.html#validation-conversion)
5.4. [Bean处理和BeanWrapper](http://shouce.jb51.net/spring/validation.html#beans-beans)

5.4.1. [设置和获取属性值以及嵌套属性](http://shouce.jb51.net/spring/validation.html#beans-beans-conventions)
5.4.2. [内建的PropertyEditor实现](http://shouce.jb51.net/spring/validation.html#beans-beans-conversion)

5.4.2.1. [注册用户自定义的PropertyEditor](http://shouce.jb51.net/spring/validation.html#beans-beans-conversion-customeditor-registration)

6\. [使用Spring进行面向切面编程（AOP）](http://shouce.jb51.net/spring/aop.html)

6.1. [简介](http://shouce.jb51.net/spring/aop.html#aop-introduction)

6.1.1. [AOP概念](http://shouce.jb51.net/spring/aop.html#aop-introduction-defn)
6.1.2. [Spring AOP的功能和目标](http://shouce.jb51.net/spring/aop.html#aop-introduction-spring-defn)
6.1.3. [AOP代理](http://shouce.jb51.net/spring/aop.html#aop-introduction-proxies)

6.2. [@AspectJ支持](http://shouce.jb51.net/spring/aop.html#aop-ataspectj)

6.2.1. [启用@AspectJ支持](http://shouce.jb51.net/spring/aop.html#aop-aspectj-support)
6.2.2. [声明一个切面](http://shouce.jb51.net/spring/aop.html#aop-at-aspectj)
6.2.3. [声明一个切入点（pointcut）](http://shouce.jb51.net/spring/aop.html#aop-pointcuts)

6.2.3.1. [切入点指示符（PCD）的支持](http://shouce.jb51.net/spring/aop.html#aop-pointcuts-designators)
6.2.3.2. [组合切入点表达式](http://shouce.jb51.net/spring/aop.html#aop-pointcuts-combining)
6.2.3.3. [共享通用切入点定义](http://shouce.jb51.net/spring/aop.html#aop-common-pointcuts)
6.2.3.4. [示例](http://shouce.jb51.net/spring/aop.html#aop-pointcuts-examples)

6.2.4. [声明通知](http://shouce.jb51.net/spring/aop.html#aop-advice)

6.2.4.1. [前置通知](http://shouce.jb51.net/spring/aop.html#aop-advice-before)
6.2.4.2. [后置通知（After returning advice）](http://shouce.jb51.net/spring/aop.html#aop-advice-after-returning)
6.2.4.3. [异常通知（After throwing advice）](http://shouce.jb51.net/spring/aop.html#aop-advice-after-throwing)
6.2.4.4. [最终通知（After (finally) advice）](http://shouce.jb51.net/spring/aop.html#aop-advice-after-finally)
6.2.4.5. [环绕通知](http://shouce.jb51.net/spring/aop.html#aop-ataspectj-around-advice)
6.2.4.6. [通知参数（Advice parameters）](http://shouce.jb51.net/spring/aop.html#aop-ataspectj-advice-params)
6.2.4.7. [通知顺序](http://shouce.jb51.net/spring/aop.html#aop-ataspectj-advice-ordering)

6.2.5. [引入（Introduction）](http://shouce.jb51.net/spring/aop.html#aop-introductions)
6.2.6. [切面实例化模型](http://shouce.jb51.net/spring/aop.html#aop-instantiation-models)
6.2.7. [例子](http://shouce.jb51.net/spring/aop.html#aop-ataspectj-example)

6.3. [基于Schema的AOP支持](http://shouce.jb51.net/spring/aop.html#aop-schema)

6.3.1. [声明一个切面](http://shouce.jb51.net/spring/aop.html#aop-schema-declaring-an-aspect)
6.3.2. [声明一个切入点](http://shouce.jb51.net/spring/aop.html#aop-schema-pointcuts)
6.3.3. [声明通知](http://shouce.jb51.net/spring/aop.html#aop-schema-advice)

6.3.3.1. [前置通知](http://shouce.jb51.net/spring/aop.html#aop-schema-advice-before)
6.3.3.2. [后置通知](http://shouce.jb51.net/spring/aop.html#aop-schema-advice-after-returning)
6.3.3.3. [异常通知](http://shouce.jb51.net/spring/aop.html#aop-schema-advice-after-throwing)
6.3.3.4. [最终通知](http://shouce.jb51.net/spring/aop.html#aop-schema-advice-after-finally)
6.3.3.5. [环绕通知](http://shouce.jb51.net/spring/aop.html#aop-schema-advice-around)
6.3.3.6. [通知参数](http://shouce.jb51.net/spring/aop.html#aop-schema-params)
6.3.3.7. [通知顺序](http://shouce.jb51.net/spring/aop.html#aop-ordering)

6.3.4. [引入](http://shouce.jb51.net/spring/aop.html#aop-schema-introductions)
6.3.5. [切面实例化模型](http://shouce.jb51.net/spring/aop.html#aop-schema-instatiation-models)
6.3.6. [Advisor](http://shouce.jb51.net/spring/aop.html#aop-schema-advisors)
6.3.7. [例子](http://shouce.jb51.net/spring/aop.html#aop-schema-example)

6.4. [AOP声明风格的选择](http://shouce.jb51.net/spring/aop.html#aop-choosing)

6.4.1. [Spring AOP还是完全用AspectJ？](http://shouce.jb51.net/spring/aop.html#aop-spring-or-aspectj)
6.4.2. [Spring AOP中使用@AspectJ还是XML？](http://shouce.jb51.net/spring/aop.html#aop-ataspectj-or-xml)

6.5. [混合切面类型](http://shouce.jb51.net/spring/aop.html#aop-mixing-styles)
6.6. [代理机制](http://shouce.jb51.net/spring/aop.html#aop-proxying)

6.6.1. [理解AOP代理](http://shouce.jb51.net/spring/aop.html#aop-understanding-aop-proxies)

6.7. [以编程方式创建@AspectJ代理](http://shouce.jb51.net/spring/aop.html#aop-aspectj-programmatic)
6.8. [在Spring应用中使用AspectJ](http://shouce.jb51.net/spring/aop.html#aop-using-aspectj)

6.8.1. [在Spring中使用AspectJ进行domain object的依赖注入](http://shouce.jb51.net/spring/aop.html#aop-atconfigurable)

6.8.1.1. [@Configurable对象的单元测试](http://shouce.jb51.net/spring/aop.html#aop-configurable-testing)
6.8.1.2. [Working with multiple application contexts](http://shouce.jb51.net/spring/aop.html#aop-configurable-container)

6.8.2. [Spring中其他的AspectJ切面](http://shouce.jb51.net/spring/aop.html#aop-ajlib-other)
6.8.3. [使用Spring IoC来配置AspectJ的切面](http://shouce.jb51.net/spring/aop.html#aop-aj-configure)
6.8.4. [在Spring应用中使用AspectJ加载时织入（LTW）](http://shouce.jb51.net/spring/aop.html#aop-aj-ltw)

6.8.4.1. [第一个例子](http://shouce.jb51.net/spring/aop.html#aop-aj-ltw-first-example)
6.8.4.2. [切面](http://shouce.jb51.net/spring/aop.html#aop-aj-ltw-the-aspects)
6.8.4.3. ['META-INF/aop.xml'](http://shouce.jb51.net/spring/aop.html#aop-aj-ltw-aop_dot_xml)
6.8.4.4. [相关类库（JARS）](http://shouce.jb51.net/spring/aop.html#aop-aj-ltw-libraries)
6.8.4.5. [Spring配置](http://shouce.jb51.net/spring/aop.html#aop-aj-ltw-spring)
6.8.4.6. [特定环境的配置](http://shouce.jb51.net/spring/aop.html#aop-aj-ltw-environments)

6.9. [更多资源](http://shouce.jb51.net/spring/aop.html#aop-resources)

7\. [Spring AOP APIs](http://shouce.jb51.net/spring/aop-api.html)

7.1. [简介](http://shouce.jb51.net/spring/aop-api.html#aop-api-introduction)
7.2. [Spring中的切入点API](http://shouce.jb51.net/spring/aop-api.html#aop-api-pointcuts)

7.2.1. [概念](http://shouce.jb51.net/spring/aop-api.html#aop-api-concepts)
7.2.2. [切入点运算](http://shouce.jb51.net/spring/aop-api.html#aop-api-pointcut-ops)
7.2.3. [AspectJ切入点表达式](http://shouce.jb51.net/spring/aop-api.html#aop-api-pointcuts-aspectj)
7.2.4. [便利的切入点实现](http://shouce.jb51.net/spring/aop-api.html#aop-api-pointcuts-impls)

7.2.4.1. [静态切入点](http://shouce.jb51.net/spring/aop-api.html#aop-api-pointcuts-static)
7.2.4.2. [动态切入点](http://shouce.jb51.net/spring/aop-api.html#aop-api-pointcuts-dynamic)

7.2.5. [切入点的超类](http://shouce.jb51.net/spring/aop-api.html#aop-api-pointcuts-superclasses)
7.2.6. [自定义切入点](http://shouce.jb51.net/spring/aop-api.html#aop-api-pointcuts-custom)

7.3. [Spring的通知API](http://shouce.jb51.net/spring/aop-api.html#aop-api-advice)

7.3.1. [通知的生命周期](http://shouce.jb51.net/spring/aop-api.html#aop-api-advice-lifecycle)
7.3.2. [Spring里的通知类型](http://shouce.jb51.net/spring/aop-api.html#aop-api-advice-types)

7.3.2.1. [拦截环绕通知](http://shouce.jb51.net/spring/aop-api.html#aop-api-advice-around)
7.3.2.2. [前置通知](http://shouce.jb51.net/spring/aop-api.html#aop-api-advice-before)
7.3.2.3. [异常通知](http://shouce.jb51.net/spring/aop-api.html#aop-api-advice-throws)
7.3.2.4. [后置通知](http://shouce.jb51.net/spring/aop-api.html#aop-api-advice-after-returning)
7.3.2.5. [引入通知](http://shouce.jb51.net/spring/aop-api.html#aop-api-advice-introduction)

7.4. [Spring里的Advisor API](http://shouce.jb51.net/spring/aop-api.html#aop-api-advisor)
7.5. [使用ProxyFactoryBean创建AOP代理](http://shouce.jb51.net/spring/aop-api.html#aop-pfb)

7.5.1. [基础](http://shouce.jb51.net/spring/aop-api.html#aop-pfb-1)
7.5.2. [JavaBean属性](http://shouce.jb51.net/spring/aop-api.html#aop-pfb-2)
7.5.3. [基于JDK和CGLIB的代理](http://shouce.jb51.net/spring/aop-api.html#aop-pfb-proxy-types)
7.5.4. [对接口进行代理](http://shouce.jb51.net/spring/aop-api.html#aop-api-proxying-intf)
7.5.5. [对类进行代理](http://shouce.jb51.net/spring/aop-api.html#aop-api-proxying-class)
7.5.6. [使用“全局”通知器](http://shouce.jb51.net/spring/aop-api.html#aop-global-advisors)

7.6. [简化代理定义](http://shouce.jb51.net/spring/aop-api.html#aop-concise-proxy)
7.7. [使用ProxyFactory通过编程创建AOP代理](http://shouce.jb51.net/spring/aop-api.html#aop-prog)
7.8. [操作被通知对象](http://shouce.jb51.net/spring/aop-api.html#aop-api-advised)
7.9. [使用“自动代理（autoproxy）”功能](http://shouce.jb51.net/spring/aop-api.html#aop-autoproxy)

7.9.1. [自动代理bean定义](http://shouce.jb51.net/spring/aop-api.html#aop-autoproxy-choices)

7.9.1.1. [BeanNameAutoProxyCreator](http://shouce.jb51.net/spring/aop-api.html#aop-api-autoproxy)
7.9.1.2. [DefaultAdvisorAutoProxyCreator](http://shouce.jb51.net/spring/aop-api.html#aop-api-autoproxy-default)
7.9.1.3. [AbstractAdvisorAutoProxyCreator](http://shouce.jb51.net/spring/aop-api.html#aop-api-autoproxy-abstract)

7.9.2. [使用元数据驱动的自动代理](http://shouce.jb51.net/spring/aop-api.html#aop-autoproxy-metadata)

7.10. [使用TargetSource](http://shouce.jb51.net/spring/aop-api.html#aop-targetsource)

7.10.1. [热交换目标源](http://shouce.jb51.net/spring/aop-api.html#aop-ts-swap)
7.10.2. [池化目标源](http://shouce.jb51.net/spring/aop-api.html#aop-ts-pool)
7.10.3. [原型目标源](http://shouce.jb51.net/spring/aop-api.html#aop-ts-prototype)
7.10.4. [ThreadLocal目标源](http://shouce.jb51.net/spring/aop-api.html#aop-ts-threadlocal)

7.11. [定义新的Advice类型](http://shouce.jb51.net/spring/aop-api.html#aop-extensibility)
7.12. [更多资源](http://shouce.jb51.net/spring/aop-api.html#aop-api-resources)

8\. [测试](http://shouce.jb51.net/spring/testing.html)

8.1. [简介](http://shouce.jb51.net/spring/testing.html#testing-introduction)
8.2. [单元测试](http://shouce.jb51.net/spring/testing.html#unit-testing)

8.2.1. [Mock对象](http://shouce.jb51.net/spring/testing.html#mock-objects)

8.2.1.1. [JNDI](http://shouce.jb51.net/spring/testing.html#mock-objects-jndi)
8.2.1.2. [Servlet API](http://shouce.jb51.net/spring/testing.html#mock-objects-servlet)
8.2.1.3. [Portlet API](http://shouce.jb51.net/spring/testing.html#mock-objects-portlet)

8.2.2. [单元测试支持类](http://shouce.jb51.net/spring/testing.html#unit-testing-support-classes)

8.2.2.1. [通用工具类](http://shouce.jb51.net/spring/testing.html#unit-testing-utilities)
8.2.2.2. [Spring MVC](http://shouce.jb51.net/spring/testing.html#unit-testing-spring-mvc)

8.3. [集成测试](http://shouce.jb51.net/spring/testing.html#integration-testing)

8.3.1. [概览](http://shouce.jb51.net/spring/testing.html#integration-testing-overview)
8.3.2. [使用哪个支持框架](http://shouce.jb51.net/spring/testing.html#integration-testing-which-framework)
8.3.3. [通用目标](http://shouce.jb51.net/spring/testing.html#integration-testing-common-goals)

8.3.3.1. [上下文管理及缓存](http://shouce.jb51.net/spring/testing.html#testing-ctx-management)
8.3.3.2. [测试fixtures依赖注入](http://shouce.jb51.net/spring/testing.html#testing-fixture-di)
8.3.3.3. [事务管理](http://shouce.jb51.net/spring/testing.html#testing-tx)
8.3.3.4. [集成测试支持类](http://shouce.jb51.net/spring/testing.html#testing-support-classes)

8.3.4. [JDBC测试支持](http://shouce.jb51.net/spring/testing.html#integration-testing-support-jdbc)
8.3.5. [常用注解](http://shouce.jb51.net/spring/testing.html#integration-testing-common-annotations)
8.3.6. [JUnit 3.8遗留支持](http://shouce.jb51.net/spring/testing.html#junit38-legacy-support)

8.3.6.1. [上下文管理及缓存](http://shouce.jb51.net/spring/testing.html#junit38-legacy-ctx-management)
8.3.6.2. [测试fixture依赖注入](http://shouce.jb51.net/spring/testing.html#junit38-legacy-fixture-di)
8.3.6.3. [事务管理](http://shouce.jb51.net/spring/testing.html#junit38-legacy-tx)
8.3.6.4. [JUnit 3.8 遗留支持类](http://shouce.jb51.net/spring/testing.html#junit38-legacy-support-classes)
8.3.6.5. [Java 5+ 专有支持](http://shouce.jb51.net/spring/testing.html#junit38-legacy-java5-support)

8.3.7. [Spring TestContext Framework](http://shouce.jb51.net/spring/testing.html#testcontext-framework)

8.3.7.1. [主要的抽象](http://shouce.jb51.net/spring/testing.html#testcontext-key-abstractions)
8.3.7.2. [上下文管理和缓存](http://shouce.jb51.net/spring/testing.html#testcontext-ctx-management)
8.3.7.3. [测试fixture的依赖注入](http://shouce.jb51.net/spring/testing.html#testcontext-fixture-di)
8.3.7.4. [事务管理](http://shouce.jb51.net/spring/testing.html#testcontext-tx)
8.3.7.5. [TestContext支持类](http://shouce.jb51.net/spring/testing.html#testcontext-support-classes)
8.3.7.6. [TestContext框架注解支持](http://shouce.jb51.net/spring/testing.html#testcontext-annotations)

8.3.8. [PetClinic示例](http://shouce.jb51.net/spring/testing.html#testing-examples-petclinic)

8.4. [更多资源](http://shouce.jb51.net/spring/testing.html#testing-resources)

II. [中间层数据访问](http://shouce.jb51.net/spring/spring-middle-tier.html)

9\. [事务管理](http://shouce.jb51.net/spring/transaction.html)

9.1. [简介](http://shouce.jb51.net/spring/transaction.html#transaction-intro)
9.2. [动机](http://shouce.jb51.net/spring/transaction.html#transaction-motivation)
9.3. [关键抽象](http://shouce.jb51.net/spring/transaction.html#transaction-strategies)
9.4. [使用资源同步的事务](http://shouce.jb51.net/spring/transaction.html#tx-resource-synchronization)

9.4.1. [高层次方案](http://shouce.jb51.net/spring/transaction.html#tx-resource-synchronization-high)
9.4.2. [低层次方案](http://shouce.jb51.net/spring/transaction.html#tx-resource-synchronization-low)
9.4.3. [TransactionAwareDataSourceProxy](http://shouce.jb51.net/spring/transaction.html#tx-resource-synchronization-tadsp)

9.5. [声明式事务管理](http://shouce.jb51.net/spring/transaction.html#transaction-declarative)

9.5.1. [理解Spring的声明式事务管理实现](http://shouce.jb51.net/spring/transaction.html#tx-decl-explained)
9.5.2. [第一个例子](http://shouce.jb51.net/spring/transaction.html#transaction-declarative-first-example)
9.5.3. [回滚](http://shouce.jb51.net/spring/transaction.html#transaction-declarative-rolling-back)
9.5.4. [为不同的bean配置不同的事务语义](http://shouce.jb51.net/spring/transaction.html#transaction-declarative-diff-tx)
9.5.5. [<tx:advice/> 有关的设置](http://shouce.jb51.net/spring/transaction.html#transaction-declarative-txadvice-settings)
9.5.6. [使用 @Transactional](http://shouce.jb51.net/spring/transaction.html#transaction-declarative-annotations)

9.5.6.1. [@Transactional 有关的设置](http://shouce.jb51.net/spring/transaction.html#transaction-declarative-attransactional-settings)

9.5.7. [事务传播](http://shouce.jb51.net/spring/transaction.html#tx-propagation)

9.5.7.1. [required](http://shouce.jb51.net/spring/transaction.html#tx-propagation-required)
9.5.7.2. [RequiresNew](http://shouce.jb51.net/spring/transaction.html#tx-propagation-requires_new)
9.5.7.3. [Nested](http://shouce.jb51.net/spring/transaction.html#tx-propagation-nested)

9.5.8. [通知事务操作](http://shouce.jb51.net/spring/transaction.html#transaction-declarative-applying-more-than-just-tx-advice)
9.5.9. [结合AspectJ使用 @Transactional](http://shouce.jb51.net/spring/transaction.html#transaction-declarative-aspectj)

9.6. [编程式事务管理](http://shouce.jb51.net/spring/transaction.html#transaction-programmatic)

9.6.1. [使用TransactionTemplate](http://shouce.jb51.net/spring/transaction.html#tx-prog-template)

9.6.1.1. [指定事务设置](http://shouce.jb51.net/spring/transaction.html#tx-prog-template-settings)

9.6.2. [使用PlatformTransactionManager](http://shouce.jb51.net/spring/transaction.html#transaction-programmatic-ptm)

9.7. [选择编程式事务管理还是声明式事务管理](http://shouce.jb51.net/spring/transaction.html#tx-decl-vs-prog)
9.8. [与特定应用服务器集成](http://shouce.jb51.net/spring/transaction.html#transaction-application-server-integration)

9.8.1. [IBM WebSphere](http://shouce.jb51.net/spring/transaction.html#transaction-application-server-integration-websphere)
9.8.2. [BEA WebLogic](http://shouce.jb51.net/spring/transaction.html#transaction-application-server-integration-weblogic)
9.8.3. [Oracle OC4J](http://shouce.jb51.net/spring/transaction.html#transaction-application-server-integration-oc4j)

9.9. [常见问题的解决方法](http://shouce.jb51.net/spring/transaction.html#transaction-solutions-to-common-problems)

9.9.1. [对一个特定的 DataSource 使用了错误的事务管理器](http://shouce.jb51.net/spring/transaction.html#transaction-solutions-to-common-problems-wrong-ptm)

9.10. [更多的资源](http://shouce.jb51.net/spring/transaction.html#transaction-resources)

10\. [DAO支持](http://shouce.jb51.net/spring/dao.html)

10.1. [简介](http://shouce.jb51.net/spring/dao.html#dao-introduction)
10.2. [一致的异常层次](http://shouce.jb51.net/spring/dao.html#dao-exceptions)
10.3. [一致的DAO支持抽象类](http://shouce.jb51.net/spring/dao.html#dao-abstract-superclasses)

11\. [使用JDBC进行数据访问](http://shouce.jb51.net/spring/jdbc.html)

11.1. [简介](http://shouce.jb51.net/spring/jdbc.html#jdbc-introduction)

11.1.1. [选择一种工作模式](http://shouce.jb51.net/spring/jdbc.html#jdbc-choose-style)
11.1.2. [Spring JDBC包结构](http://shouce.jb51.net/spring/jdbc.html#jdbc-packages)

11.2. [利用JDBC核心类控制JDBC的基本操作和错误处理](http://shouce.jb51.net/spring/jdbc.html#jdbc-core)

11.2.1. [JdbcTemplate类](http://shouce.jb51.net/spring/jdbc.html#jdbc-JdbcTemplate)

11.2.1.1. [一些示例](http://shouce.jb51.net/spring/jdbc.html#jdbc-JdbcTemplate-examples)
11.2.1.2. [JdbcTemplate 的最佳实践](http://shouce.jb51.net/spring/jdbc.html#jdbc-JdbcTemplate-idioms)

11.2.2. [NamedParameterJdbcTemplate类](http://shouce.jb51.net/spring/jdbc.html#jdbc-NamedParameterJdbcTemplate)
11.2.3. [SimpleJdbcTemplate类](http://shouce.jb51.net/spring/jdbc.html#jdbc-SimpleJdbcTemplate)
11.2.4. [DataSource接口](http://shouce.jb51.net/spring/jdbc.html#jdbc-datasource)
11.2.5. [SQLExceptionTranslator接口](http://shouce.jb51.net/spring/jdbc.html#jdbc-SQLExceptionTranslator)
11.2.6. [执行SQL语句](http://shouce.jb51.net/spring/jdbc.html#jdbc-statements-executing)
11.2.7. [执行查询](http://shouce.jb51.net/spring/jdbc.html#jdbc-statements-querying)
11.2.8. [更新数据库](http://shouce.jb51.net/spring/jdbc.html#jdbc-updates)
11.2.9. [获取自动生成的主键](http://shouce.jb51.net/spring/jdbc.html#jdbc-auto-genereted-keys)

11.3. [控制数据库连接](http://shouce.jb51.net/spring/jdbc.html#jdbc-connections)

11.3.1. [DataSourceUtils类](http://shouce.jb51.net/spring/jdbc.html#jdbc-DataSourceUtils)
11.3.2. [SmartDataSource接口](http://shouce.jb51.net/spring/jdbc.html#jdbc-SmartDataSource)
11.3.3. [AbstractDataSource类](http://shouce.jb51.net/spring/jdbc.html#jdbc-AbstractDataSource)
11.3.4. [SingleConnectionDataSource类](http://shouce.jb51.net/spring/jdbc.html#jdbc-SingleConnectionDataSource)
11.3.5. [DriverManagerDataSource类](http://shouce.jb51.net/spring/jdbc.html#jdbc-DriverManagerDataSource)
11.3.6. [TransactionAwareDataSourceProxy类](http://shouce.jb51.net/spring/jdbc.html#jdbc-TransactionAwareDataSourceProxy)
11.3.7. [DataSourceTransactionManager类](http://shouce.jb51.net/spring/jdbc.html#jdbc-DataSourceTransactionManager)
11.3.8. [NativeJdbcExtractor](http://shouce.jb51.net/spring/jdbc.html#jdbc-NativeJdbcExtractor)

11.4. [JDBC批量操作](http://shouce.jb51.net/spring/jdbc.html#jdbc-advanced-jdbc)

11.4.1. [使用JdbcTemplate进行批量操作](http://shouce.jb51.net/spring/jdbc.html#jdbc-advanced-classic)
11.4.2. [使用SimpleJdbcTemplate进行批量操作](http://shouce.jb51.net/spring/jdbc.html#jdbc-advanced-simple)

11.5. [通过使用SimpleJdbc类简化JDBC操作](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc)

11.5.1. [使用SimpleJdbcInsert插入数据](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc-insert-1)
11.5.2. [使用SimpleJdbcInsert来获取自动生成的主键](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc-insert-2)
11.5.3. [指定SimpleJdbcInsert所使用的字段](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc-insert-3)
11.5.4. [使用SqlParameterSource提供参数值](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc-parameters)
11.5.5. [使用SimpleJdbcCall调用存储过程](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc-call-1)
11.5.6. [声明SimpleJdbcCall使用的参数](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc-call-2)
11.5.7. [如何定义SqlParameters](http://shouce.jb51.net/spring/jdbc.html#jdbc-params)
11.5.8. [使用SimpleJdbcCall调用内置函数](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc-call-3)
11.5.9. [使用SimpleJdbcCall返回的ResultSet/REF Cursor](http://shouce.jb51.net/spring/jdbc.html#jdbc-simple-jdbc-call-4)

11.6. [用Java对象来表达JDBC操作](http://shouce.jb51.net/spring/jdbc.html#jdbc-object)

11.6.1. [SqlQuery类](http://shouce.jb51.net/spring/jdbc.html#jdbc-SqlQuery)
11.6.2. [MappingSqlQuery类](http://shouce.jb51.net/spring/jdbc.html#jdbc-MappingSqlQuery)
11.6.3. [SqlUpdate类](http://shouce.jb51.net/spring/jdbc.html#jdbc-SqlUpdate)
11.6.4. [StoredProcedure类](http://shouce.jb51.net/spring/jdbc.html#jdbc-StoredProcedure)
11.6.5. [SqlFunction类](http://shouce.jb51.net/spring/jdbc.html#jdbc-SqlFunction)

11.7. [参数和数据处理的基本原则](http://shouce.jb51.net/spring/jdbc.html#jdbc-parameter-handling)

11.7.1. [为参数设置SQL类型信息](http://shouce.jb51.net/spring/jdbc.html#jdbc-type-information)
11.7.2. [处理BLOB 和 CLOB对象](http://shouce.jb51.net/spring/jdbc.html#jdbc-lob)
11.7.3. [在IN语句中传入一组参数值](http://shouce.jb51.net/spring/jdbc.html#jdbc-in-clause)
11.7.4. [处理复杂类型的存储过程调用](http://shouce.jb51.net/spring/jdbc.html#jdbc-complex-types)

12\. [使用ORM工具进行数据访问](http://shouce.jb51.net/spring/orm.html)

12.1. [简介](http://shouce.jb51.net/spring/orm.html#orm-introduction)
12.2. [Hibernate](http://shouce.jb51.net/spring/orm.html#orm-hibernate)

12.2.1. [资源管理](http://shouce.jb51.net/spring/orm.html#orm-resource-mngmnt)
12.2.2. [在Spring容器中创建 SessionFactory](http://shouce.jb51.net/spring/orm.html#orm-session-factory-setup)
12.2.3. [The HibernateTemplate](http://shouce.jb51.net/spring/orm.html#orm-hibernate-template)
12.2.4. [不使用回调的基于Spring的DAO实现](http://shouce.jb51.net/spring/orm.html#orm-hibernate-daos)
12.2.5. [基于Hibernate3的原生API实现DAO](http://shouce.jb51.net/spring/orm.html#orm-hibernate-straight)
12.2.6. [编程式的事务划分](http://shouce.jb51.net/spring/orm.html#orm-hibernate-tx-programmatic)
12.2.7. [声明式的事务划分](http://shouce.jb51.net/spring/orm.html#orm-hibernate-tx-declarative)
12.2.8. [事务管理策略](http://shouce.jb51.net/spring/orm.html#orm-hibernate-tx-strategies)
12.2.9. [容器资源 vs 本地资源](http://shouce.jb51.net/spring/orm.html#orm-hibernate-resources)
12.2.10. [在应用服务器中使用Hibernate的注意事项](http://shouce.jb51.net/spring/orm.html#orm-hibernate-invalid-jdbc-access-error)

12.3. [JDO](http://shouce.jb51.net/spring/orm.html#orm-jdo)

12.3.1. [建立PersistenceManagerFactory](http://shouce.jb51.net/spring/orm.html#orm-jdo-setup)
12.3.2. [JdoTemplate和JdoDaoSupport](http://shouce.jb51.net/spring/orm.html#orm-jdo-template)
12.3.3. [基于原生的JDO API实现DAO](http://shouce.jb51.net/spring/orm.html#orm-jdo-daos-straight)
12.3.4. [事务管理](http://shouce.jb51.net/spring/orm.html#orm-jdo-tx)
12.3.5. [JdoDialect](http://shouce.jb51.net/spring/orm.html#orm-jdo-dialect)

12.4. [Oracle TopLink](http://shouce.jb51.net/spring/orm.html#orm-toplink)

12.4.1. [SessionFactory 抽象层](http://shouce.jb51.net/spring/orm.html#orm-toplink-abstraction)
12.4.2. [TopLinkTemplate and TopLinkDaoSupport](http://shouce.jb51.net/spring/orm.html#orm-toplink-template)
12.4.3. [基于原生的TopLink API的DAO实现](http://shouce.jb51.net/spring/orm.html#orm-toplink-straight)
12.4.4. [事务管理](http://shouce.jb51.net/spring/orm.html#orm-toplink-tx)

12.5. [iBATIS SQL Maps](http://shouce.jb51.net/spring/orm.html#orm-ibatis)

12.5.1. [创建SqlMapClient](http://shouce.jb51.net/spring/orm.html#orm-ibatis-setup)
12.5.2. [使用 SqlMapClientTemplate 和 SqlMapClientDaoSupport](http://shouce.jb51.net/spring/orm.html#orm-ibatis-template)
12.5.3. [基于原生的iBATIS API的DAO实现](http://shouce.jb51.net/spring/orm.html#orm-ibatis-straight)

12.6. [JPA](http://shouce.jb51.net/spring/orm.html#orm-jpa)

12.6.1. [在Spring环境中建立JPA](http://shouce.jb51.net/spring/orm.html#orm-jpa-setup)

12.6.1.1. [LocalEntityManagerFactoryBean](http://shouce.jb51.net/spring/orm.html#orm-jpa-setup-lemfb)
12.6.1.2. [从JNDI中获取 EntityManagerFactory](http://shouce.jb51.net/spring/orm.html#orm-jpa-setup-jndi)
12.6.1.3. [LocalContainerEntityManagerFactoryBean](http://shouce.jb51.net/spring/orm.html#orm-jpa-setup-lcemfb)
12.6.1.4. [处理多持久化单元](http://shouce.jb51.net/spring/orm.html#orm-jpa-multiple-pu)

12.6.2. [JpaTemplate 和 JpaDaoSupport](http://shouce.jb51.net/spring/orm.html#orm-jpa-template)
12.6.3. [基于原生的JPA实现DAO](http://shouce.jb51.net/spring/orm.html#orm-jpa-straight)
12.6.4. [异常转化](http://shouce.jb51.net/spring/orm.html#orm-jpa-exceptions)

12.7. [事务管理](http://shouce.jb51.net/spring/orm.html#orm-jpa-tx)
12.8. [JpaDialect](http://shouce.jb51.net/spring/orm.html#orm-jpa-dialect)

III. [The Web](http://shouce.jb51.net/spring/spring-web.html)

13\. [Web MVC framework Web框架](http://shouce.jb51.net/spring/mvc.html)

13.1. [概述](http://shouce.jb51.net/spring/mvc.html#mvc-introduction)

13.1.1. [与其他MVC实现框架的集成](http://shouce.jb51.net/spring/mvc.html#mvc-introduction-pluggability)
13.1.2. [Spring Web MVC框架的特点](http://shouce.jb51.net/spring/mvc.html#mvc-features)

13.2. [DispatcherServlet](http://shouce.jb51.net/spring/mvc.html#mvc-servlet)
13.3. [控制器](http://shouce.jb51.net/spring/mvc.html#mvc-controller)

13.3.1. [AbstractController 和 WebContentGenerator](http://shouce.jb51.net/spring/mvc.html#mvc-controller-abstractcontroller)
13.3.2. [其它的简单控制器](http://shouce.jb51.net/spring/mvc.html#mvc-controller-othersimplecontrollers)
13.3.3. [MultiActionController](http://shouce.jb51.net/spring/mvc.html#mvc-controller-multiaction)
13.3.4. [命令控制器](http://shouce.jb51.net/spring/mvc.html#mvc-controller-command)

13.4. [处理器映射（handler mapping）](http://shouce.jb51.net/spring/mvc.html#mvc-handlermapping)

13.4.1. [BeanNameUrlHandlerMapping](http://shouce.jb51.net/spring/mvc.html#mvc-handlermapping-beanname)
13.4.2. [SimpleUrlHandlerMapping](http://shouce.jb51.net/spring/mvc.html#mvc-handlermapping-urlhandlermapping)
13.4.3. [拦截器（HandlerInterceptor）](http://shouce.jb51.net/spring/mvc.html#mvc-handlermapping-interceptor)

13.5. [视图与视图解析](http://shouce.jb51.net/spring/mvc.html#mvc-viewresolver)

13.5.1. [视图解析器（ViewResolver）](http://shouce.jb51.net/spring/mvc.html#mvc-viewresolver-resolver)
13.5.2. [视图解析链](http://shouce.jb51.net/spring/mvc.html#mvc-viewresolver-chaining)
13.5.3. [重定向（Rediret）到另一个视图](http://shouce.jb51.net/spring/mvc.html#mvc-redirecting)

13.5.3.1. [RedirectView](http://shouce.jb51.net/spring/mvc.html#mvc-redirecting-redirect-view)
13.5.3.2. [redirect:前缀](http://shouce.jb51.net/spring/mvc.html#mvc-redirecting-redirect-prefix)
13.5.3.3. [forward:前缀](http://shouce.jb51.net/spring/mvc.html#mvc-redirecting-forward-prefix)

13.6. [本地化解析器](http://shouce.jb51.net/spring/mvc.html#mvc-localeresolver)

13.6.1. [AcceptHeaderLocaleResolver](http://shouce.jb51.net/spring/mvc.html#mvc-localeresolver-acceptheader)
13.6.2. [CookieLocaleResolver](http://shouce.jb51.net/spring/mvc.html#mvc-localeresolver-cookie)
13.6.3. [SessionLocaleResolver](http://shouce.jb51.net/spring/mvc.html#mvc-localeresolver-session)
13.6.4. [LocaleChangeInterceptor](http://shouce.jb51.net/spring/mvc.html#mvc-localeresolver-interceptor)

13.7. [使用主题](http://shouce.jb51.net/spring/mvc.html#mvc-themeresolver)

13.7.1. [简介](http://shouce.jb51.net/spring/mvc.html#mvc-themeresolver-introduction)
13.7.2. [如何定义主题](http://shouce.jb51.net/spring/mvc.html#mvc-themeresolver-defining)
13.7.3. [主题解析器](http://shouce.jb51.net/spring/mvc.html#mvc-themeresolver-resolving)

13.8. [Spring对分段文件上传（multipart file upload）的支持](http://shouce.jb51.net/spring/mvc.html#mvc-multipart)

13.8.1. [介绍](http://shouce.jb51.net/spring/mvc.html#mvc-multipart-introduction)
13.8.2. [使用MultipartResolver](http://shouce.jb51.net/spring/mvc.html#mvc-multipart-resolver)
13.8.3. [在表单中处理分段文件上传](http://shouce.jb51.net/spring/mvc.html#mvc-multipart-forms)

13.9. [使用Spring的表单标签库](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib)

13.9.1. [配置](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-configuration)
13.9.2. [form标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-formtag)
13.9.3. [input标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-inputtag)
13.9.4. [checkbox标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-checkboxtag)
13.9.5. [checkboxes标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-checkboxestag)
13.9.6. [radiobutton标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-radiobuttontag)
13.9.7. [radiobuttons标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-radiobuttonstag)
13.9.8. [password标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-passwordtag)
13.9.9. [select标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-selecttag)
13.9.10. [option标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-optiontag)
13.9.11. [options标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-optionstag)
13.9.12. [textarea标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-textAreatag)
13.9.13. [hidden标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-hiddeninputtag)
13.9.14. [errors标签](http://shouce.jb51.net/spring/mvc.html#mvc-formtaglib-errorstag)

13.10. [处理异常](http://shouce.jb51.net/spring/mvc.html#mvc-exceptionhandlers)
13.11. [惯例优先原则（convention over configuration）](http://shouce.jb51.net/spring/mvc.html#mvc-coc)

13.11.1. [对控制器的支持：ControllerClassNameHandlerMapping](http://shouce.jb51.net/spring/mvc.html#mvc-coc-ccnhm)
13.11.2. [对模型的支持：ModelMap（ModelAndView）](http://shouce.jb51.net/spring/mvc.html#mvc-coc-modelmap)
13.11.3. [对视图的支持：RequestToViewNameTranslator](http://shouce.jb51.net/spring/mvc.html#mvc-coc-r2vnt)

13.12. [基于注解的控制器配置](http://shouce.jb51.net/spring/mvc.html#mvc-annotation)

13.12.1. [建立dispatcher实现注解支持](http://shouce.jb51.net/spring/mvc.html#mvc-ann-setup)
13.12.2. [使用@Controller定义一个控制器](http://shouce.jb51.net/spring/mvc.html#mvc-ann-controller)
13.12.3. [使用@RequestMapping映射请求](http://shouce.jb51.net/spring/mvc.html#mvc-ann-requestmapping)
13.12.4. [使用@RequestParam绑定请求参数到方法参数](http://shouce.jb51.net/spring/mvc.html#mvc-ann-requestparam)
13.12.5. [使用@ModelAttribute提供一个从模型到数据的链接](http://shouce.jb51.net/spring/mvc.html#mvc-ann-modelattrib)
13.12.6. [使用@SessionAttributes指定存储在会话中的属性](http://shouce.jb51.net/spring/mvc.html#mvc-ann-sessionattrib)
13.12.7. [自定义WebDataBinder初始化](http://shouce.jb51.net/spring/mvc.html#mvc-ann-webdatabinder)

13.12.7.1. [使用@InitBinder自定义数据绑定](http://shouce.jb51.net/spring/mvc.html#mvc-ann-initbinder)
13.12.7.2. [配置一个定制的WebBindingInitializer](http://shouce.jb51.net/spring/mvc.html#mvc-ann-webbindinginitializer)

13.13. [更多资源](http://shouce.jb51.net/spring/mvc.html#mvc-resources)

14\. [集成视图技术](http://shouce.jb51.net/spring/view.html)

14.1. [简介](http://shouce.jb51.net/spring/view.html#view-introduction)
14.2. [JSP和JSTL](http://shouce.jb51.net/spring/view.html#view-jsp)

14.2.1. [视图解析器](http://shouce.jb51.net/spring/view.html#view-jsp-resolver)
14.2.2. ['Plain-old' JSPs versus JSTL 'Plain-old' JSP与JSTL](http://shouce.jb51.net/spring/view.html#view-jsp-jstl)
14.2.3. [帮助简化开发的额外的标签](http://shouce.jb51.net/spring/view.html#view-jsp-tags)

14.3. [Tiles](http://shouce.jb51.net/spring/view.html#view-tiles)

14.3.1. [需要的资源](http://shouce.jb51.net/spring/view.html#view-tiles-dependencies)
14.3.2. [如何集成Tiles](http://shouce.jb51.net/spring/view.html#view-tiles-integrate)

14.3.2.1. [UrlBasedViewResolver类](http://shouce.jb51.net/spring/view.html#view-tiles-url)
14.3.2.2. [ResourceBundleViewResolver类](http://shouce.jb51.net/spring/view.html#view-tiles-resource)
14.3.2.3. [SimpleSpringPreparerFactory 和 SpringBeanPreparerFactory](http://shouce.jb51.net/spring/view.html#view-tiles-preparer)

14.4. [Velocity和FreeMarker](http://shouce.jb51.net/spring/view.html#view-velocity)

14.4.1. [需要的资源](http://shouce.jb51.net/spring/view.html#view-velocity-dependencies)
14.4.2. [Context 配置](http://shouce.jb51.net/spring/view.html#view-velocity-contextconfig)
14.4.3. [创建模板](http://shouce.jb51.net/spring/view.html#view-velocity-createtemplates)
14.4.4. [高级配置](http://shouce.jb51.net/spring/view.html#view-velocity-advancedconfig)

14.4.4.1. [velocity.properties](http://shouce.jb51.net/spring/view.html#view-velocity-example-velocityproperties)
14.4.4.2. [FreeMarker](http://shouce.jb51.net/spring/view.html#views-freemarker)

14.4.5. [绑定支持和表单处理](http://shouce.jb51.net/spring/view.html#view-velocity-forms)

14.4.5.1. [用于绑定的宏](http://shouce.jb51.net/spring/view.html#view-bind-macros)
14.4.5.2. [简单绑定](http://shouce.jb51.net/spring/view.html#view-simple-binding)
14.4.5.3. [表单输入生成宏](http://shouce.jb51.net/spring/view.html#views-form-macros)
14.4.5.4. [重载HTML转码行为并使你的标签符合XHTML](http://shouce.jb51.net/spring/view.html#d0e27354)

14.5. [XSLT](http://shouce.jb51.net/spring/view.html#view-xslt)

14.5.1. [写在段首](http://shouce.jb51.net/spring/view.html#view-xslt-firstwords)

14.5.1.1. [Bean 定义](http://shouce.jb51.net/spring/view.html#view-xslt-beandefs)
14.5.1.2. [标准MVC控制器代码](http://shouce.jb51.net/spring/view.html#view-xslt-controllercode)
14.5.1.3. [把模型数据转化为XML](http://shouce.jb51.net/spring/view.html#view-xslt-subclassing)
14.5.1.4. [定义视图属性](http://shouce.jb51.net/spring/view.html#view-xslt-viewdefinitions)
14.5.1.5. [文档转换](http://shouce.jb51.net/spring/view.html#view-xslt-transforming)

14.5.2. [小结](http://shouce.jb51.net/spring/view.html#view-xslt-summary)

14.6. [文档视图（PDF/Excel）](http://shouce.jb51.net/spring/view.html#view-document)

14.6.1. [简介](http://shouce.jb51.net/spring/view.html#view-document-intro)
14.6.2. [配置和安装](http://shouce.jb51.net/spring/view.html#view-document-config)

14.6.2.1. [文档视图定义](http://shouce.jb51.net/spring/view.html#view-document-configviews)
14.6.2.2. [Controller 代码](http://shouce.jb51.net/spring/view.html#view-document-configcontroller)
14.6.2.3. [Excel视图子类](http://shouce.jb51.net/spring/view.html#view-document-configsubclasses)
14.6.2.4. [PDF视图子类](http://shouce.jb51.net/spring/view.html#view-document-configsubclasspdf)

14.7. [JasperReports](http://shouce.jb51.net/spring/view.html#view-jasper-reports)

14.7.1. [依赖的资源](http://shouce.jb51.net/spring/view.html#view-jasper-reports-dependencies)
14.7.2. [配置](http://shouce.jb51.net/spring/view.html#view-jasper-reports-configuration)

14.7.2.1. [配置ViewResolver](http://shouce.jb51.net/spring/view.html#view-jasper-reports-configuration-resolver)
14.7.2.2. [配置View](http://shouce.jb51.net/spring/view.html#view-jasper-reports-configuration-views)
14.7.2.3. [关于报表文件](http://shouce.jb51.net/spring/view.html#view-jasper-reports-configuration-report-files)
14.7.2.4. [使用 JasperReportsMultiFormatView](http://shouce.jb51.net/spring/view.html#view-jasper-reports-configuration-multiformat-view)

14.7.3. [构造ModelAndView](http://shouce.jb51.net/spring/view.html#view-jasper-reports-model)
14.7.4. [使用子报表](http://shouce.jb51.net/spring/view.html#view-jasper-reports-subreports)

14.7.4.1. [配置子报表文件](http://shouce.jb51.net/spring/view.html#view-jasper-reports-subreports-config-reports)
14.7.4.2. [配置子报表数据源](http://shouce.jb51.net/spring/view.html#view-jasper-reports-subreports-config-datasources)

14.7.5. [配置Exporter的参数](http://shouce.jb51.net/spring/view.html#view-jasper-reports-exporter-parameters)

15\. [集成其它Web框架](http://shouce.jb51.net/spring/webintegration.html)

15.1. [简介](http://shouce.jb51.net/spring/webintegration.html#intro)
15.2. [通用配置](http://shouce.jb51.net/spring/webintegration.html#webintegration-common)
15.3. [JavaServer Faces](http://shouce.jb51.net/spring/webintegration.html#jsf)

15.3.1. [DelegatingVariableResolver](http://shouce.jb51.net/spring/webintegration.html#jsf-delegatingvariableresolver)
15.3.2. [FacesContextUtils](http://shouce.jb51.net/spring/webintegration.html#jsf-facescontextutils)

15.4. [Struts](http://shouce.jb51.net/spring/webintegration.html#struts)

15.4.1. [ContextLoaderPlugin](http://shouce.jb51.net/spring/webintegration.html#struts-contextloaderplugin)

15.4.1.1. [DelegatingRequestProcessor](http://shouce.jb51.net/spring/webintegration.html#struts-delegatingrequestprocessor)
15.4.1.2. [DelegatingActionProxy](http://shouce.jb51.net/spring/webintegration.html#struts-delegatingactionproxy)

15.4.2. [ActionSupport Classes](http://shouce.jb51.net/spring/webintegration.html#struts-actionsupport)

15.5. [Tapestry](http://shouce.jb51.net/spring/webintegration.html#view-tapestry)

15.5.1. [注入 Spring 托管的 beans](http://shouce.jb51.net/spring/webintegration.html#view-tapestry-di)

15.5.1.1. [将 Spring Beans 注入到 Tapestry 页面中](http://shouce.jb51.net/spring/webintegration.html#view-tapestry-pre40-style-di)
15.5.1.2. [组件定义文件](http://shouce.jb51.net/spring/webintegration.html#view-tapestry-componentdefs)
15.5.1.3. [添加抽象访问方法](http://shouce.jb51.net/spring/webintegration.html#view-tapestry-getters)
15.5.1.4. [将 Spring Beans 注入到 Tapestry 页面中 - Tapestry 4.0+ 风格](http://shouce.jb51.net/spring/webintegration.html#view-tapestry-40-style-di)

15.6. [WebWork](http://shouce.jb51.net/spring/webintegration.html#webwork)
15.7. [更多资源](http://shouce.jb51.net/spring/webintegration.html#webintegration-resources)

16\. [Portlet MVC框架](http://shouce.jb51.net/spring/portlet.html)

16.1. [介绍](http://shouce.jb51.net/spring/portlet.html#portlet-introduction)

16.1.1. [控制器 - MVC中的C](http://shouce.jb51.net/spring/portlet.html#portlet-introduction-controller)
16.1.2. [视图 - MVC中的V](http://shouce.jb51.net/spring/portlet.html#portlet-introduction-view)
16.1.3. [Web作用范围的Bean](http://shouce.jb51.net/spring/portlet.html#portlet-introduction-scope)

16.2. [DispatcherPortlet](http://shouce.jb51.net/spring/portlet.html#portlet-dispatcher)
16.3. [ViewRendererServlet](http://shouce.jb51.net/spring/portlet.html#portlet-viewservlet)
16.4. [控制器](http://shouce.jb51.net/spring/portlet.html#portlet-controller)

16.4.1. [AbstractController 和 PortletContentGenerator](http://shouce.jb51.net/spring/portlet.html#portlet-controller-abstractcontroller)
16.4.2. [其它简单的控制器](http://shouce.jb51.net/spring/portlet.html#portlet-controller-simple)
16.4.3. [Command控制器](http://shouce.jb51.net/spring/portlet.html#portlet-controller-command)
16.4.4. [PortletWrappingController](http://shouce.jb51.net/spring/portlet.html#portlet-controller-wrapping)

16.5. [处理器映射](http://shouce.jb51.net/spring/portlet.html#portlet-handlermapping)

16.5.1. [PortletModeHandlerMapping](http://shouce.jb51.net/spring/portlet.html#portlet-handlermapping-portletmode)
16.5.2. [ParameterHandlerMapping](http://shouce.jb51.net/spring/portlet.html#portlet-handlermapping-parameter)
16.5.3. [PortletModeParameterHandlerMapping](http://shouce.jb51.net/spring/portlet.html#portlet-handlermapping-portletmodeparameter)
16.5.4. [增加 HandlerInterceptors](http://shouce.jb51.net/spring/portlet.html#portlet-handlermapping-interceptor)
16.5.5. [HandlerInterceptorAdapter](http://shouce.jb51.net/spring/portlet.html#portlet-handlermapping-interceptoradapter)
16.5.6. [ParameterMappingInterceptor](http://shouce.jb51.net/spring/portlet.html#portlet-handlermapping-parameterinterceptor)

16.6. [视图和它们的解析](http://shouce.jb51.net/spring/portlet.html#portlet-viewresolver)
16.7. [Multipart文件上传支持](http://shouce.jb51.net/spring/portlet.html#portlet-multipart)

16.7.1. [使用 PortletMultipartResolver](http://shouce.jb51.net/spring/portlet.html#portlet-multipart-resolver)
16.7.2. [处理表单里的文件上传](http://shouce.jb51.net/spring/portlet.html#portlet-multipart-forms)

16.8. [异常处理](http://shouce.jb51.net/spring/portlet.html#portlet-exceptionresolver)
16.9. [Portlet应用的部署](http://shouce.jb51.net/spring/portlet.html#portlet-deployment)

IV. [整合](http://shouce.jb51.net/spring/spring-integration.html)

17\. [使用Spring进行远程访问与Web服务](http://shouce.jb51.net/spring/remoting.html)

17.1. [简介](http://shouce.jb51.net/spring/remoting.html#remoting-introduction)
17.2. [使用RMI暴露服务](http://shouce.jb51.net/spring/remoting.html#remoting-rmi)

17.2.1. [使用RmiServiceExporter暴露服务](http://shouce.jb51.net/spring/remoting.html#remoting-rmi-server)
17.2.2. [在客户端链接服务](http://shouce.jb51.net/spring/remoting.html#remoting-rmi-client)

17.3. [使用Hessian或者Burlap通过HTTP远程调用服务](http://shouce.jb51.net/spring/remoting.html#remoting-caucho-protocols)

17.3.1. [为Hessian和co.配置DispatcherServlet](http://shouce.jb51.net/spring/remoting.html#remoting-caucho-protocols-hessian)
17.3.2. [使用HessianServiceExporter暴露你的bean](http://shouce.jb51.net/spring/remoting.html#remoting-caucho-protocols-hessian-server)
17.3.3. [在客户端连接服务](http://shouce.jb51.net/spring/remoting.html#remoting-caucho-protocols-hessian-client)
17.3.4. [使用Burlap](http://shouce.jb51.net/spring/remoting.html#remoting-caucho-protocols-burlap)
17.3.5. [对通过Hessian或Burlap暴露的服务使用HTTP Basic认证](http://shouce.jb51.net/spring/remoting.html#remoting-caucho-protocols-security)

17.4. [使用HTTP调用器暴露服务](http://shouce.jb51.net/spring/remoting.html#remoting-httpinvoker)

17.4.1. [Exposing the service object](http://shouce.jb51.net/spring/remoting.html#remoting-httpinvoker-server)
17.4.2. [在客户端连接服务](http://shouce.jb51.net/spring/remoting.html#remoting-httpinvoker-client)

17.5. [Web Services](http://shouce.jb51.net/spring/remoting.html#remoting-web-services)

17.5.1. [使用JAX-RPC暴露基于servlet的web服务](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-jaxrpc-export)
17.5.2. [使用JAX-RPC访问web服务](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-jaxrpc-access)
17.5.3. [注册JAX-RPC Bean映射](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-jaxrpc-mapping-registration)
17.5.4. [注册自己的JAX-RPC 处理器](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-jaxrpc-handler-registration)
17.5.5. [使用JAX-WS暴露基于servlet的web服务](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-jaxws-export-servlet)
17.5.6. [使用JAX-WS暴露单独web服务](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-jaxws-export-standalone)
17.5.7. [使用Spring支持的JAX-WS RI来暴露服务](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-jaxws-export-ri)
17.5.8. [使用JAX-WS访问web服务](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-jaxws-access)
17.5.9. [使用XFire来暴露Web服务](http://shouce.jb51.net/spring/remoting.html#remoting-web-services-xfire)

17.6. [JMS](http://shouce.jb51.net/spring/remoting.html#remoting-jms)

17.6.1. [服务端配置](http://shouce.jb51.net/spring/remoting.html#remoting-jms-server)
17.6.2. [客户端配置](http://shouce.jb51.net/spring/remoting.html#remoting-jms-client)

17.7. [对远程接口不提供自动探测实现](http://shouce.jb51.net/spring/remoting.html#remoting-autodection-remote-interfaces)
17.8. [在选择这些技术时的一些考虑](http://shouce.jb51.net/spring/remoting.html#remoting-considerations)

18\. [Enterprise Java Beans (EJB) 集成](http://shouce.jb51.net/spring/ejb.html)

18.1. [简介](http://shouce.jb51.net/spring/ejb.html#ejb-introduction)
18.2. [访问EJB](http://shouce.jb51.net/spring/ejb.html#ejb-access)

18.2.1. [概念](http://shouce.jb51.net/spring/ejb.html#ejb-access-concepts)
18.2.2. [访问本地的无状态Session Bean(SLSB)](http://shouce.jb51.net/spring/ejb.html#ejb-access-local)
18.2.3. [访问远程SLSB](http://shouce.jb51.net/spring/ejb.html#ejb-access-remote)
18.2.4. [Accessing EJB 2.x SLSBs versus EJB 3 SLSBs](http://shouce.jb51.net/spring/ejb.html#ejb-access-ejb2-ejb3)

18.3. [使用Spring提供的辅助类实现EJB组件](http://shouce.jb51.net/spring/ejb.html#ejb-implementation)

18.3.1. [EJB 2.x base classes](http://shouce.jb51.net/spring/ejb.html#ejb-implementation-ejb2)
18.3.2. [EJB 3 注入拦截](http://shouce.jb51.net/spring/ejb.html#ejb-implementation-ejb3)

19\. [JMS (Java Message Service)](http://shouce.jb51.net/spring/jms.html)

19.1. [简介](http://shouce.jb51.net/spring/jms.html#jms-introduction)
19.2. [使用Spring JMS](http://shouce.jb51.net/spring/jms.html#jms-using)

19.2.1. [JmsTemplate](http://shouce.jb51.net/spring/jms.html#d0e31311)
19.2.2. [连接工厂](http://shouce.jb51.net/spring/jms.html#jms-connections)
19.2.3. [目的地管理](http://shouce.jb51.net/spring/jms.html#jms-destinations)
19.2.4. [消息侦听容器](http://shouce.jb51.net/spring/jms.html#jms-mdp)

19.2.4.1. [SimpleMessageListenerContainer](http://shouce.jb51.net/spring/jms.html#jms-mdp-simple)
19.2.4.2. [DefaultMessageListenerContainer](http://shouce.jb51.net/spring/jms.html#jms-mdp-default)
19.2.4.3. [ServerSessionMessageListenerContainer](http://shouce.jb51.net/spring/jms.html#jms-mdp-server-session)

19.2.5. [事务管理](http://shouce.jb51.net/spring/jms.html#jms-tx)

19.3. [发送消息](http://shouce.jb51.net/spring/jms.html#jms-sending)

19.3.1. [使用消息转换器](http://shouce.jb51.net/spring/jms.html#jms-msg-conversion)
19.3.2. [SessionCallback 和 ProducerCallback](http://shouce.jb51.net/spring/jms.html#jms-callbacks)

19.4. [接收消息](http://shouce.jb51.net/spring/jms.html#jms-receiving)

19.4.1. [同步接收](http://shouce.jb51.net/spring/jms.html#jms-receiving-sync)
19.4.2. [异步接收 - 消息驱动的POJO](http://shouce.jb51.net/spring/jms.html#jms-asynchronousMessageReception)
19.4.3. [SessionAwareMessageListener接口](http://shouce.jb51.net/spring/jms.html#jms-receiving-async-session-aware-message-listener)
19.4.4. [MessageListenerAdapter](http://shouce.jb51.net/spring/jms.html#jms-receiving-async-message-listener-adapter)
19.4.5. [事务中的消息处理](http://shouce.jb51.net/spring/jms.html#jms-tx-participation)

19.5. [JCA消息端点的支持](http://shouce.jb51.net/spring/jms.html#jms-jca-message-endpoint-manager)
19.6. [JMS命名空间支持](http://shouce.jb51.net/spring/jms.html#jms-namespace)

20\. [JMX](http://shouce.jb51.net/spring/jmx.html)

20.1. [介绍](http://shouce.jb51.net/spring/jmx.html#jmx-introduction)
20.2. [将Bean暴露为JMX](http://shouce.jb51.net/spring/jmx.html#jmx-exporting)

20.2.1. [创建MBeanServer](http://shouce.jb51.net/spring/jmx.html#jmx-exporting-mbeanserver)
20.2.2. [重用原有的MBeanServer](http://shouce.jb51.net/spring/jmx.html#jmx-mbean-server)
20.2.3. [延迟初始化的MBean](http://shouce.jb51.net/spring/jmx.html#jmx-exporting-lazy)
20.2.4. [MBean的自动注册](http://shouce.jb51.net/spring/jmx.html#jmx-exporting-auto)
20.2.5. [控制注册行为](http://shouce.jb51.net/spring/jmx.html#jmx-exporting-registration-behavior)

20.3. [控制Bean的管理接口](http://shouce.jb51.net/spring/jmx.html#jmx-interface)

20.3.1. [MBeanInfoAssembler接口](http://shouce.jb51.net/spring/jmx.html#jmx-interface-assembler)
20.3.2. [使用源码级元数据](http://shouce.jb51.net/spring/jmx.html#jmx-interface-metadata)
20.3.3. [使用JDK 5.0的注解](http://shouce.jb51.net/spring/jmx.html#jmx-interface-annotations)
20.3.4. [源代码级的元数据类型](http://shouce.jb51.net/spring/jmx.html#jmx-interface-metadata-types)
20.3.5. [AutodetectCapableMBeanInfoAssembler接口](http://shouce.jb51.net/spring/jmx.html#jmx-interface-autodetect)
20.3.6. [用Java接口定义管理接口](http://shouce.jb51.net/spring/jmx.html#jmx-interface-java)
20.3.7. [使用MethodNameBasedMBeanInfoAssembler](http://shouce.jb51.net/spring/jmx.html#jmx-interface-methodnames)

20.4. [控制Bean的ObjectName](http://shouce.jb51.net/spring/jmx.html#jmx-naming)

20.4.1. [从Properties读取Properties](http://shouce.jb51.net/spring/jmx.html#jmx-naming-properties)
20.4.2. [使用MetadataNamingStrategy](http://shouce.jb51.net/spring/jmx.html#jmx-naming-metadata)
20.4.3. [<context:mbean-export/>元素](http://shouce.jb51.net/spring/jmx.html#jmx-context-mbeanexport)

20.5. [JSR-160连接器](http://shouce.jb51.net/spring/jmx.html#jmx-jsr160)

20.5.1. [服务器端连接器](http://shouce.jb51.net/spring/jmx.html#jmx-jsr160-server)
20.5.2. [客户端连接器](http://shouce.jb51.net/spring/jmx.html#jmx-jsr160-client)
20.5.3. [基于Burlap/Hessian/SOAP的JMX](http://shouce.jb51.net/spring/jmx.html#jmx-jsr160-protocols)

20.6. [通过代理访问MBean](http://shouce.jb51.net/spring/jmx.html#jmx-proxy)
20.7. [通知](http://shouce.jb51.net/spring/jmx.html#jmx-notifications)

20.7.1. [为通知注册监听器](http://shouce.jb51.net/spring/jmx.html#jmx-notifications-listeners)
20.7.2. [发布通知](http://shouce.jb51.net/spring/jmx.html#jmx-notifications-publishing)

20.8. [更多资源](http://shouce.jb51.net/spring/jmx.html#jmx-resources)

21\. [JCA CCI](http://shouce.jb51.net/spring/cci.html)

21.1. [简介](http://shouce.jb51.net/spring/cci.html#cci-introduction)
21.2. [配置CCI](http://shouce.jb51.net/spring/cci.html#cci-config)

21.2.1. [连接器配置](http://shouce.jb51.net/spring/cci.html#cci-config-connector)
21.2.2. [在Spring中配置ConnectionFactory](http://shouce.jb51.net/spring/cci.html#cci-config-connectionfactory)
21.2.3. [配置CCI连接](http://shouce.jb51.net/spring/cci.html#cci-config-cci-connections)
21.2.4. [使用一个 CCI 单连接](http://shouce.jb51.net/spring/cci.html#cci-config-single-connection)

21.3. [使用Spring的 CCI访问支持](http://shouce.jb51.net/spring/cci.html#cci-using)

21.3.1. [记录转换](http://shouce.jb51.net/spring/cci.html#cci-record-creator)
21.3.2. [CciTemplate类](http://shouce.jb51.net/spring/cci.html#cci-using-template)
21.3.3. [DAO支持](http://shouce.jb51.net/spring/cci.html#cci-using-dao)
21.3.4. [自动输出记录生成](http://shouce.jb51.net/spring/cci.html#automatic-output-generation)
21.3.5. [总结](http://shouce.jb51.net/spring/cci.html#template-summary)
21.3.6. [直接使用一个CCI Connection接口和Interaction接口](http://shouce.jb51.net/spring/cci.html#cci-straight)
21.3.7. [CciTemplate 使用示例](http://shouce.jb51.net/spring/cci.html#cci-template-example)

21.4. [建模CCI访问为操作对象](http://shouce.jb51.net/spring/cci.html#cci-object)

21.4.1. [MappingRecordOperation](http://shouce.jb51.net/spring/cci.html#cci-object-mapping-record)
21.4.2. [MappingCommAreaOperation](http://shouce.jb51.net/spring/cci.html#cci-object-mapping-comm-area)
21.4.3. [自动生成输出记录](http://shouce.jb51.net/spring/cci.html#cci-automatic-record-gen)
21.4.4. [总结](http://shouce.jb51.net/spring/cci.html#cci-object-summary)
21.4.5. [MappingRecordOperation 使用示例](http://shouce.jb51.net/spring/cci.html#cci-objects-mappring-record-example)
21.4.6. [MappingCommAreaOperation 使用示例](http://shouce.jb51.net/spring/cci.html#cci-objects-mapping-comm-area-example)

21.5. [事务](http://shouce.jb51.net/spring/cci.html#cci-tx)

22\. [Spring邮件抽象层](http://shouce.jb51.net/spring/mail.html)

22.1. [简介](http://shouce.jb51.net/spring/mail.html#mail-introduction)
22.2. [使用Spring邮件抽象](http://shouce.jb51.net/spring/mail.html#mail-usage)

22.2.1. [MailSender 和 SimpleMailMessage 的基本用法](http://shouce.jb51.net/spring/mail.html#mail-usage-simple)
22.2.2. [使用 JavaMailSender 和 MimeMessagePreparator](http://shouce.jb51.net/spring/mail.html#mail-usage-mime)

22.3. [使用MimeMessageHelper](http://shouce.jb51.net/spring/mail.html#mail-javamail-mime)

22.3.1. [发送附件和嵌入式资源(inline resources)](http://shouce.jb51.net/spring/mail.html#mail-javamail-mime-attachments)

22.3.1.1. [附件](http://shouce.jb51.net/spring/mail.html#mail-javamail-mime-attachments-attachment)
22.3.1.2. [内嵌资源](http://shouce.jb51.net/spring/mail.html#mail-javamail-mime-attachments-inline)

22.3.2. [使用模板来创建邮件内容](http://shouce.jb51.net/spring/mail.html#mail-templates)

22.3.2.1. [一个基于Velocity的示例](http://shouce.jb51.net/spring/mail.html#mail-templates-example)

23\. [Spring中的定时调度(Scheduling)和线程池(Thread Pooling)](http://shouce.jb51.net/spring/scheduling.html)

23.1. [简介](http://shouce.jb51.net/spring/scheduling.html#scheduling-introduction)
23.2. [使用OpenSymphony Quartz 调度器](http://shouce.jb51.net/spring/scheduling.html#scheduling-quartz)

23.2.1. [使用JobDetailBean](http://shouce.jb51.net/spring/scheduling.html#scheduling-quartz-jobdetail)
23.2.2. [使用 MethodInvokingJobDetailFactoryBean](http://shouce.jb51.net/spring/scheduling.html#scheduling-quartz-method-invoking-job)
23.2.3. [使用triggers和SchedulerFactoryBean来包装任务](http://shouce.jb51.net/spring/scheduling.html#scheduling-quartz-cron)

23.3. [使用JDK Timer支持类](http://shouce.jb51.net/spring/scheduling.html#scheduling-jdk-timer)

23.3.1. [创建定制的timers](http://shouce.jb51.net/spring/scheduling.html#scheduling-jdk-timer-creating)
23.3.2. [使用 MethodInvokingTimerTaskFactoryBean类](http://shouce.jb51.net/spring/scheduling.html#scheduling-jdk-timer-method-invoking-task)
23.3.3. [最后：使用TimerFactoryBean来设置任务](http://shouce.jb51.net/spring/scheduling.html#scheduling-jdk-timer-factory-bean)

23.4. [SpringTaskExecutor抽象](http://shouce.jb51.net/spring/scheduling.html#scheduling-task-executor)

23.4.1. [TaskExecutor接口](http://shouce.jb51.net/spring/scheduling.html#scheduling-task-executor-interface)
23.4.2. [TaskExecutor类型](http://shouce.jb51.net/spring/scheduling.html#scheduling-task-executor-types)
23.4.3. [使用TaskExecutor](http://shouce.jb51.net/spring/scheduling.html#scheduling-task-executor-usage)

24\. [动态语言支持](http://shouce.jb51.net/spring/dynamic-language.html)

24.1. [介绍](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-introduction)
24.2. [第一个示例](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-a-first-example)
24.3. [定义动态语言支持的bean](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans)

24.3.1. [公共概念](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans-concepts)

24.3.1.1. [<lang:language/> 元素](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans-concepts-xml-language-element)
24.3.1.2. [Refreshable bean](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-refreshable-beans)
24.3.1.3. [内置动态语言源文件](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans-inline)
24.3.1.4. [理解dynamic-language-backed bean上下文中的构造器注入](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans-ctor-injection)

24.3.2. [JRuby beans](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans-jruby)
24.3.3. [Groovy beans](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans-groovy)

24.3.3.1. [通过回调定制Groovy对象](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans-groovy-customizer)

24.3.4. [BeanShell beans](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-beans-bsh)

24.4. [场景](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-scenarios)

24.4.1. [Spring MVC控制器的脚本化](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-scenarios-controllers)
24.4.2. [Validator的脚本化](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-scenarios-validators)

24.5. [Bits and bobs](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-final-notes)

24.5.1. [AOP - 通知脚本化bean](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-final-notes-aop)
24.5.2. [作用域](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-final-notes-scopes)

24.6. [更多的资源](http://shouce.jb51.net/spring/dynamic-language.html#dynamic-language-resources)

25\. [注解和源代码级的元数据支持](http://shouce.jb51.net/spring/metadata.html)

25.1. [简介](http://shouce.jb51.net/spring/metadata.html#metadata-introduction)
25.2. [Spring的元数据支持](http://shouce.jb51.net/spring/metadata.html#metadata-spring)
25.3. [注解](http://shouce.jb51.net/spring/metadata.html#metadata-annotations)

25.3.1. [@Required](http://shouce.jb51.net/spring/metadata.html#metadata-annotations-required)
25.3.2. [Spring中的其它@Annotations](http://shouce.jb51.net/spring/metadata.html#metadata-annotations-other)

25.4. [Jakarta Commons Attributes集成](http://shouce.jb51.net/spring/metadata.html#metadata-commons)
25.5. [元数据和Spring AOP自动代理](http://shouce.jb51.net/spring/metadata.html#metadata-uses)

25.5.1. [基本原理](http://shouce.jb51.net/spring/metadata.html#metadata-fundamentals)
25.5.2. [声明式事务管理](http://shouce.jb51.net/spring/metadata.html#metadata-tx)

V. [示例程序](http://shouce.jb51.net/spring/spring-samples.html)

26\. [演示案例](http://shouce.jb51.net/spring/showcases.html)

26.1. [介绍](http://shouce.jb51.net/spring/showcases.html#showcases-introduction)
26.2. [使用动态语言实现的Spring MVC控制器](http://shouce.jb51.net/spring/showcases.html#showcases-dynamvc)

26.2.1. [构建与部署](http://shouce.jb51.net/spring/showcases.html#showcases-dynamvc-build)

26.3. [使用SimpleJdbcTemplate和@Repository实现DAO](http://shouce.jb51.net/spring/showcases.html#showcases-java5-dao)

26.3.1. [域对象](http://shouce.jb51.net/spring/showcases.html#showcases-java5-dao-the-domain)
26.3.2. [Data Access Object](http://shouce.jb51.net/spring/showcases.html#showcases-java5-dao-the-daos)
26.3.3. [构建](http://shouce.jb51.net/spring/showcases.html#showcases-java5-dao-build)

A. [XML Schema-based configuration](http://shouce.jb51.net/spring/xsd-config.html)

A.1. [Introduction](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-introduction)
A.2. [XML Schema-based configuration](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body)

A.2.1. [Referencing the schemas](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-referencing)
A.2.2. [The util schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-util)

A.2.2.1. [<util:constant/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-util-constant)
A.2.2.2. [<util:property-path/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-util-property-path)
A.2.2.3. [<util:properties/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-util-properties)
A.2.2.4. [<util:list/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-util-list)
A.2.2.5. [<util:map/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-util-map)
A.2.2.6. [<util:set/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-util-set)

A.2.3. [The jee schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jee)

A.2.3.1. [<jee:jndi-lookup/> (simple)](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jee-jndi-lookup)
A.2.3.2. [<jee:jndi-lookup/> (with single JNDI environment setting)](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jee-jndi-lookup-environment-single)
A.2.3.3. [<jee:jndi-lookup/> (with multiple JNDI environment settings)](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jee-jndi-lookup-evironment-multiple)
A.2.3.4. [<jee:jndi-lookup/> (complex)](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jee-jndi-lookup-complex)
A.2.3.5. [<jee:local-slsb/> (simple)](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jee-local-slsb)
A.2.3.6. [<jee:local-slsb/> (complex)](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jee-local-slsb-complex)
A.2.3.7. [<jee:remote-slsb/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jee-remote-slsb)

A.2.4. [The lang schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-lang)
A.2.5. [The jms schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-jms)
A.2.6. [The tx (transaction) schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-tx)
A.2.7. [The aop schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-aop)
A.2.8. [The context schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-context)

A.2.8.1. [<property-placeholder/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-context-pphc)
A.2.8.2. [<annotation-config/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-context-ac)
A.2.8.3. [<component-scan/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-context-component-scan)
A.2.8.4. [<load-time-weaver/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-context-ltw)
A.2.8.5. [<spring-configured/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-context-sc)
A.2.8.6. [<mbean-export/>](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-context-mbe)

A.2.9. [The tool schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-tool)
A.2.10. [The beans schema](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-body-schemas-beans)

A.3. [Setting up your IDE](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-setup)

A.3.1. [Setting up Eclipse](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-setup-eclipse)
A.3.2. [Setting up IntelliJ IDEA](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-setup-idea)
A.3.3. [Integration issues](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-integration)

A.3.3.1. [XML parsing errors in the Resin v.3 application server](http://shouce.jb51.net/spring/xsd-config.html#xsd-config-integration-resin)

B. [Extensible XML authoring](http://shouce.jb51.net/spring/extensible-xml.html)

B.1. [Introduction](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-introduction)
B.2. [Authoring the schema](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-schema)
B.3. [Coding a NamespaceHandler](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-namespacehandler)
B.4. [Coding a BeanDefinitionParser](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-parser)
B.5. [Registering the handler and the schema](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-registration)

B.5.1. ['META-INF/spring.handlers'](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-registration-spring-handlers)
B.5.2. ['META-INF/spring.schemas'](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-registration-spring-schemas)

B.6. [Using a custom extension in your Spring XML configuration](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-using)
B.7. [Meatier examples](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-meat)

B.7.1. [Nesting custom tags within custom tags](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-custom-nested)
B.7.2. [Custom attributes on 'normal' elements](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-custom-just-attributes)

B.8. [Further Resources](http://shouce.jb51.net/spring/extensible-xml.html#extensible-xml-resources)

C. [spring-beans-2.0.dtd](http://shouce.jb51.net/spring/springbeansdtd.html)
D. [spring.tld](http://shouce.jb51.net/spring/spring.tld.html)

D.1. [Introduction](http://shouce.jb51.net/spring/spring.tld.html#spring.tld-intro)
D.2. [The bind tag](http://shouce.jb51.net/spring/spring.tld.html#spring.tld.bind)
D.3. [The escapeBody tag](http://shouce.jb51.net/spring/spring.tld.html#spring.tld.escapeBody)
D.4. [The hasBindErrors tag](http://shouce.jb51.net/spring/spring.tld.html#spring.tld.hasBindErrors)
D.5. [The htmlEscape tag](http://shouce.jb51.net/spring/spring.tld.html#spring.tld.htmlEscape)
D.6. [The message tag](http://shouce.jb51.net/spring/spring.tld.html#spring.tld.message)
D.7. [The nestedPath tag](http://shouce.jb51.net/spring/spring.tld.html#spring.tld.nestedPath)
D.8. [The theme tag](http://shouce.jb51.net/spring/spring.tld.html#spring.tld.theme)
D.9. [The transform tag](http://shouce.jb51.net/spring/spring.tld.html#spring.tld.transform)

E. [spring-form.tld](http://shouce.jb51.net/spring/spring-form.tld.html)

E.1. [Introduction](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld-intro)
E.2. [The checkbox tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.checkbox)
E.3. [The checkboxes tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.checkboxes)
E.4. [The errors tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.errors)
E.5. [The form tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.form)
E.6. [The hidden tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.hidden)
E.7. [The input tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.input)
E.8. [The label tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.label)
E.9. [The option tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.option)
E.10. [The options tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.options)
E.11. [The password tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.password)
E.12. [The radiobutton tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.radiobutton)
E.13. [The radiobuttons tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.radiobuttons)
E.14. [The select tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.select)
E.15. [The textarea tag](http://shouce.jb51.net/spring/spring-form.tld.html#spring-form.tld.textarea)

F. [Spring 2.5开发手册中文化项目](http://shouce.jb51.net/spring/translator.html)

F.1. [声明](http://shouce.jb51.net/spring/translator.html#d0e44906)
F.2. [致谢](http://shouce.jb51.net/spring/translator.html#d0e44917)
F.3. [参与人员](http://shouce.jb51.net/spring/translator.html#d0e44922)
F.4. [项目历程](http://shouce.jb51.net/spring/translator.html#d0e45081)

 <http://wangmeng.baidu.com/> 
[![[./_resources/Spring_Framework_开发参考手册.resources/0f000FMhefr62Ke65dGZ_f.gif]]](http://www.baidu.com/cpro.php?0f0000KHngfosNFSGG1ntYli6W7Kb6iecpZX9GjLYcIszl9lXB-i_HV17YanLmpANeRDtp100o8Z3IHiQauj8y9aC_riudDZA_H_rFC5m80AwjWiEZknC_B1nIM8.DY_jfS26hAGlcQvTyaNmhnVSlE-9k1QjPak8tX1kLJ0.IgF_5y9YIZ0lQzq1pAqdmvR8phcdni48ugfETLKzpy4MQsKYUHYknjmdrj0z0Zwd5gRkn1csnWck0ZI_5Hc0mv4YUWdJmWRkgvPsT6K9uAP_mgP15H00TMnqn0KWIAYqIAN3I7qbuyu9IykYg1Dvn7tvnj00Uh7YIHYL0A-YpyfqPsKGIA-8uhqGujYs0AIspyfqn0Kzuyuspyfqn0KWTZFEpyfqrjT1PYD1P10dnWnYrjuaPj6knWmvPWczf19jfHDLnjm0mgwGujYCUMN_Uab0mgwYXHYCUMN_Uab0mMNbuvNYgvN3TA-b5HD0my-s5RNQTdIzNjcsHNKu0ZNGTjY3wb4wRLGcI-wQn0KWpjYs0Zw9TWYknjcY0AwYTjYk0ZP-UAk-T-qGujYk0A-1gv7sTjYs0A7sT7qGujYs0APdTLfq0A-1gLIGThN_ugP15H00Iv7sgLw4TARqn0KsUjYs0AdW5H7WrHP9nHnz0Adv5HD0UMus5H08nj0snj0snj00u1bqn0KhpgF1I7qzuyIGUv3qnfK1uyPEUhwxThNMpyq85HTYrfK1TL0qnfK1TL0z5HD0IZws5HD0uA-1IZ0qn0K9mWYs0A7bXjYk0ZKGujYs0ZIspyfqn0K9uZw4TARqn0K1Iv-b5H00TLw4TARqn0KWThnqPWDs0A)

* * *

|     |     |     |
| --- | --- | --- |
|     |     | [Next](http://shouce.jb51.net/spring/preface.html) |
|     | [Sponsored by SpringSource](http://www.springsource.com/) | 前言  |

    Created at: 2014-07-11T11:32:03+08:00
    Updated at: 2014-07-11T11:32:03+08:00

