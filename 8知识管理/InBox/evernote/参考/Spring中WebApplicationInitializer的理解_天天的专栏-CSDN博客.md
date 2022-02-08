
# Spring中WebApplicationInitializer的理解

![[8知识管理/InBox/evernote/参考/_resources/Spring中WebApplicationInitializer的理解_天天的专栏-CSDN博客.resources/reprint.png]]
[天天](https://blog.csdn.net/tiantiandjava) 2018-08-10 16:45:19 ![[8知识管理/InBox/evernote/参考/_resources/Spring中WebApplicationInitializer的理解_天天的专栏-CSDN博客.resources/articleReadEyes.png]] 6393  

		
分类专栏： [spring](https://blog.csdn.net/tiantiandjava/category_1390266.html)

刚刚看到别人写的关于Spring的WebApplicationInitializer的理解。觉得非常好，收藏了还是觉的不放心。

再转载一下，方便以后查找原文： <https://blog.csdn.net/zq17865815296/article/details/79464403>

现在JavaConfig配置方式在逐步取代xml配置方式。而WebApplicationInitializer可以看做是Web.xml的替代，它是一个接口。通过实现WebApplicationInitializer，在其中可以添加servlet，listener等，在加载Web项目的时候会加载这个接口实现类，从而起到web.xml相同的作用。下面就看一下这个接口的详细内容。

首先打开这个接口，如下：

    1public interface WebApplicationInitializer {2    void onStartup(ServletContext var1) throws ServletException;3}

     只有一个方法，看不出什么头绪。但是，在这个包下有另外一个类，SpringServletContainerInitializer。它的实现如下：

    1package org.springframework.web;2 3import java.lang.reflect.Modifier;4import java.util.Iterator;5import java.util.LinkedList;6import java.util.List;7import java.util.Set;8import javax.servlet.ServletContainerInitializer;9import javax.servlet.ServletContext;10import javax.servlet.ServletException;11import javax.servlet.annotation.HandlesTypes;12import org.springframework.core.annotation.AnnotationAwareOrderComparator;13 14@HandlesTypes({WebApplicationInitializer.class})15public class SpringServletContainerInitializer implements ServletContainerInitializer {16    public SpringServletContainerInitializer() {17    }18 19    public void onStartup(Set<Class<?>> webAppInitializerClasses, ServletContext servletContext) throws ServletException {20        List<WebApplicationInitializer> initializers = new LinkedList();21        Iterator var4;22        if(webAppInitializerClasses != null) {23            var4 = webAppInitializerClasses.iterator();24 25            while(var4.hasNext()) {26                Class<?> waiClass = (Class)var4.next();27                if(!waiClass.isInterface() && !Modifier.isAbstract(waiClass.getModifiers()) && WebApplicationInitializer.class.isAssignableFrom(waiClass)) {28                    try {29                        initializers.add((WebApplicationInitializer)waiClass.newInstance());30                    } catch (Throwable var7) {31                        throw new ServletException("Failed to instantiate WebApplicationInitializer class", var7);32                    }33                }34            }35        }36 37        if(initializers.isEmpty()) {38            servletContext.log("No Spring WebApplicationInitializer types detected on classpath");39        } else {40            servletContext.log(initializers.size() + " Spring WebApplicationInitializers detected on classpath");41            AnnotationAwareOrderComparator.sort(initializers);42            var4 = initializers.iterator();43 44            while(var4.hasNext()) {45                WebApplicationInitializer initializer = (WebApplicationInitializer)var4.next();46                initializer.onStartup(servletContext);47            }48 49        }50    }51}

这个类就比较有意思了，先不管其他的，读一下这段代码，可以得到这样的意思。

             先判断webAppInitializerClasses这个Set是否为空。如果不为空的话，找到这个set中不是接口，不是抽象类，并且是

WebApplicationInitializer接口实现类的类，将它们保存到list中。当这个list为空的时候，抛出异常。不为空的话就按照一定的顺序排序，并将它们按照一定的顺序实例化。调用其onStartup方法执行。到这里，就可以解释WebApplicationInitializer实现类的工作过程了。但是，在web项目运行的时候，SpringServletContainerInitializer这个类又是怎样被调用的呢。

           它只有一个接口，ServletContainerInitializer，通过它就可以解释SpringServletContainerInitializer是如何被调用的。它的内容如下，

    1package javax.servlet;2 3import java.util.Set;4 5public interface ServletContainerInitializer {6    void onStartup(Set<Class<?>> var1, ServletContext var2) throws ServletException;7}

首先，这个接口是javax.servlet下的。官方的解释是这样的：为了支持可以不使用web.xml。提供了ServletContainerInitializer，它可以通过SPI机制，当启动web容器的时候，会自动到添加的相应jar包下找到META-INF/services下以ServletContainerInitializer的全路径名称命名的文件，它的内容为ServletContainerInitializer实现类的全路径，将它们实例化。既然这样的话，那么SpringServletContainerInitializer作为ServletContainerInitializer的实现类，它的jar包下也应该有相应的文件。打开查看如下：

        ![[20180306223233482.png]]           ![[20180306223353595.png]]         

         哈，现在就可以解释清楚了。首先，SpringServletContainerInitializer作为ServletContainerInitializer的实现类，通过SPI机制，在web容器加载的时候会自动的被调用。（这个类上还有一个注解@HandlesTypes，它的作用是将感兴趣的一些类注入到ServletContainerInitializerde）， 而这个类的方法又会扫描找到WebApplicationInitializer的实现类，调用它的onStartup方法，从而起到启动web.xml相同的作用。

         然后，我们自己通过一个实例来实现相同的功能，通过一样的方式来访问一个servlet。

         1、定义接口WebParameter，它就相当于WebApplicationInitializer。内容如下：

    1public interface WebParameter {2 3    void loadOnstarp(ServletContext servletContext);4}

可以在这里面添加servlet，listener等。

       2、定义Servlet。

    1public class MyServlet extends HttpServlet {2    @Override3    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {4        resp.getWriter().write("TestSetvlet");5    }6}

      3、定义MyWebParameter作为WebParameter的实现类，将Servlet添加到上下文，并设置好映射。

    1public class MyWebParameter implements WebParameter {2    public void loadOnstarp(ServletContext servletContext) {3        ServletRegistration.Dynamic testSetvelt=servletContext.addServlet("test","com.test.servlet.MyServlet");4        testSetvelt.setLoadOnStartup(1);5        testSetvelt.addMapping("/test");6    }7}

      4、定义好WebConfig作为ServletContainerInitializer的实现类，它的作用是扫描找到WebParameter的实现类，并调用其方法。 

    1@HandlesTypes({WebParameter.class})2public class WebConfig implements ServletContainerInitializer {3    public void onStartup(Set<Class<?>> set, ServletContext servletContext) throws ServletException {4        Iterator var4;5        if (set!=null){6            var4=set.iterator();7            while(var4.hasNext()){8                Class<?> clazz= (Class<?>) var4.next();9                if (!clazz.isInterface()&& !Modifier.isAbstract(clazz.getModifiers())&&WebParameter.class.isAssignableFrom(clazz)){10                    try {11                        ((WebParameter) clazz.newInstance()).loadOnstarp(servletContext);12                    }catch (Exception e){13                        e.printStackTrace();14                    }15                }16            }17        }18    }19}

5、根据SPI机制，定义一个META-INF/services文件夹，并在其下定义相关文件名称，并将WebConfig的类全名称填入其中。

              ![[20180306230524557.png]]

              至此，相关内容就完成了，因为我用的maven，通过install将其作为jar包上传到本地仓库。从另外一个web项目调用这个包进行访问。

         6、最终结果：

                 ![[20180306231232361.png]]    ![[20180306231350747.png]]

            相关代码请转至我的github[点击打开链接](https://github.com/GregZQ/SpringLearn/tree/master/javaconfig)

    Created at: 2020-12-22T10:24:24+08:00
    Updated at: 2020-12-22T10:24:24+08:00

