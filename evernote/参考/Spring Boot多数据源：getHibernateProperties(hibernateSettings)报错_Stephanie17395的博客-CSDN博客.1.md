
# Spring Boot多数据源：getHibernateProperties(hibernateSettings)报错

![[./_resources/Spring_Boot多数据源：getHibernateProperties(hibernateSettings)报错_Stephanie17395的博客-CSDN博客.1.resources/original.png]]
[Claudia\_Vane3](https://blog.csdn.net/Stephanie17395) 2019-08-03 16:47:32 ![[./_resources/Spring_Boot多数据源：getHibernateProperties(hibernateSettings)报错_Stephanie17395的博客-CSDN博客.1.resources/articleReadEyes.png]] 2087  

		
分类专栏： [Spring Boot学习笔记](https://blog.csdn.net/stephanie17395/category_9164407.html) [后端](https://blog.csdn.net/stephanie17395/category_8281212.html) [问题解决](https://blog.csdn.net/stephanie17395/category_9188750.html) 文章标签： [Spring Boot多数据源报错](https://so.csdn.net/so/search/s.do?q=Spring%20Boot%E5%A4%9A%E6%95%B0%E6%8D%AE%E6%BA%90%E6%8A%A5%E9%94%99&t=blog&o=vip&s=&l=&f=&viparticle=) [.getHibernateProperties报错](https://so.csdn.net/so/search/s.do?q=.getHibernateProperties%E6%8A%A5%E9%94%99&t=blog&o=vip&s=&l=&f=&viparticle=) [.getHibernateProperties(hibernateSe](https://so.csdn.net/so/search/s.do?q=.getHibernateProperties(hibernateSe&t=blog&o=vip&s=&l=&f=&viparticle=)

![[./_resources/Spring_Boot多数据源：getHibernateProperties(hibernateSettings)报错_Stephanie17395的博客-CSDN博客.1.resources/embedded.svg]]

我使用的是Spring Boot 2.16 而在这个版本中getHibernateProperties已经被弃用了

*   ###### 解决方案：
    
    先注意这两块代码的位置：
    ![[./_resources/Spring_Boot多数据源：getHibernateProperties(hibernateSettings)报错_Stephanie17395的博客-CSDN博客.1.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.2.png]]
    
*   ###### 先把原来的getVendorProperties() 方法注释掉，在类的开头增加：
    
        @Autowired
        private HibernateProperties hibernateProperties;
        
    
*   ###### 在调用getVendorProperties()的entityManagerFactoryUser方法内部增加：
    
        Map<String, Object> properties = hibernateProperties.determineHibernateProperties(
               jpaProperties.getProperties(), new HibernateSettings());
        
    
*   ###### 将原来调用的getVendorProperties() 换成 properties
    
    ![[./_resources/Spring_Boot多数据源：getHibernateProperties(hibernateSettings)报错_Stephanie17395的博客-CSDN博客.1.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.1.png]]
    以上是Spring Boot2.1.X能够兼容的写法

    Created at: 2021-01-20T14:52:13+08:00
    Updated at: 2021-01-20T14:52:13+08:00

