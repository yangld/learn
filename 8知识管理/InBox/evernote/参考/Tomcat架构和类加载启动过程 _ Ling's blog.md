
# Tomcat架构和类加载启动过程

[__2018-06-09](http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/)

### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#Tomcat%E7%B1%BB%E5%8A%A0%E8%BD%BD%E6%9C%BA%E5%88%B6%E7%9A%84%E6%AF%94%E8%BE%83>Tomcat类加载机制的比较

> **Tomcat的类加载机制是违反了双亲委托原则的，对于一些未加载的非基础类(Object,String等)，各个web应用自己的类加载器(WebAppClassLoader)会优先加载，加载不到时再交给commonClassLoader走双亲委托。**
> 
> **对于JVM来说：**
> 
> **因此，按照这个过程可以想到，如果同样在CLASSPATH指定的目录中和自己工作目录中存放相同的class，会优先加载CLASSPATH目录中的文件。**

![[类加载思维导图.jpg]]

#### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#%E5%87%A0%E4%B8%AA%E5%B0%8F%E9%97%AE%E9%A2%98%EF%BC%9A>几个小问题：

1.  1.
    
    既然 Tomcat 不遵循双亲委派机制，那么如果我自己定义一个恶意的HashMap，会不会有风险呢？
    
    答： 显然不会有风险， tomcat不遵循双亲委派机制，只是自定义的classLoader顺序不同，但顶层还是相同的，还是要去顶层请求classloader。
    
    1.  一个web容器可能需要部署两个应用程序，不同的应用程序可能会依赖同一个第三方类库的不同版本，不能要求同一个类库在同一个服务器只有一份，因此要保证每个应用程序的类库都是独立的，保证相互隔离。
    2.  部署在同一个web容器中相同的类库相同的版本可以共享。否则，如果服务器有10个应用程序，那么要有10份相同的类库加载进虚拟机，这是扯淡的。
    3.  web容器也有自己依赖的类库，不能于应用程序的类库混淆。基于安全考虑，应该让容器的类库和程序的类库隔离开来。
    4.  web容器要支持jsp的修改，我们知道，jsp 文件最终也是要编译成class文件才能在虚拟机中运行，但程序运行后修改jsp已经是司空见惯的事情，否则要你何用？ 所以，web容器需要支持 jsp 修改后不用重启。
2.  5.
    
    Tomcat 如果使用默认的类加载机制行不行？
    
    答：是不行的。为什么？我们看，第一个问题，如果使用默认的类加载器机制，那么是无法加载两个相同类库的不同版本的，默认的累加器是不管你是什么版本的，只在乎你的全限定类名，并且只有一份。第二个问题，默认的类加载器是能够实现的，因为他的职责就是保证唯一性。第三个问题和第一个问题一样。我们再看第四个问题，我们想我们要怎么实现jsp文件的热修改（楼主起的名字），jsp 文件其实也就是class文件，那么如果修改了，但类名还是一样，类加载器会直接取方法区中已经存在的，修改后的jsp是不会重新加载的。那么怎么办呢？我们可以直接卸载掉这jsp文件的类加载器，所以你应该想到了，每个jsp文件对应一个唯一的类加载器，当一个jsp文件修改了，就直接卸载这个jsp类加载器。重新创建类加载器，重新加载jsp文件。
    
    *   commonLoader：Tomcat最基本的类加载器，加载路径中的class可以被Tomcat容器本身以及各个Webapp访问；
    *   catalinaLoader：Tomcat容器私有的类加载器，加载路径中的class对于Webapp不可见；
    *   sharedLoader：各个Webapp共享的类加载器，加载路径中的class对于所有Webapp可见，但是对于Tomcat容器不可见；
    *   WebappClassLoader：各个Webapp私有的类加载器，加载路径中的class只对当前Webapp可见；

### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#%E7%B1%BB%E5%8A%A0%E8%BD%BD>类加载

> 在JVM中并不是一次性把所有的文件都加载到，而是一步一步的，按照需要来加载。
> 
> 比如JVM启动时，会通过不同的类加载器加载不同的类。当用户在自己的代码中，需要某些额外的类时，再通过加载机制加载到JVM中，并且存放一段时间，便于频繁使用。
> 
> 因此使用哪种类加载器、在什么位置加载类都是JVM中重要的知识。

#### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#JVM%E7%B1%BB%E5%8A%A0%E8%BD%BD>JVM类加载

JVM类加载采用 父类委托机制，如下图所示：

![[java类加载器.png]]

JVM中包括集中类加载器：

　　1 BootStrapClassLoader 引导类加载器

　　2 ExtClassLoader 扩展类加载器

　　3 AppClassLoader 应用类加载器

　　4 CustomClassLoader 用户自定义类加载器

　　他们的区别上面也都有说明。需要注意的是，不同的类加载器加载的类是不同的，因此如果用户加载器1加载的某个类，其他用户并不能够使用。

**当JVM运行过程中，用户需要加载某些类时，会按照下面的步骤（父类委托机制）**：

　　1 用户自己的类加载器，把加载请求传给父加载器，父加载器再传给其父加载器，一直到加载器树的顶层。

　　2 最顶层的类加载器首先针对其特定的位置加载，如果加载不到就转交给子类。

　　3 如果一直到底层的类加载都没有加载到，那么就会抛出异常ClassNotFoundException。

　　**因此，按照这个过程可以想到，如果同样在CLASSPATH指定的目录中和自己工作目录中存放相同的class，会优先加载CLASSPATH目录中的文件。**

#### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#Tomcat%E7%B1%BB%E5%8A%A0%E8%BD%BD>Tomcat类加载

在tomcat中类的加载稍有不同，如下图：

![tomcat%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%99%A8%E8%AF%A6%E7%BB%86%E8%AF%B4%E6%98%8E.jpg](http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/Users/muzhi%201/git/MyPostImage/blog/tomcat%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%99%A8%E8%AF%A6%E7%BB%86%E8%AF%B4%E6%98%8E.jpg)

当tomcat启动时，会创建几种类加载器：

**1 Bootstrap 引导类加载器**

加载JVM启动所需的类，以及标准扩展类（位于jre/lib/ext下）

**2 System 系统类加载器**

加载tomcat启动的类，比如bootstrap.jar，通常在catalina.bat或者catalina.sh中指定。位于CATALINA\_HOME/bin下。

![[System 系统类加载器 .jpg]]

**3 Common 通用类加载器**

加载tomcat使用以及应用通用的一些类，位于CATALINA\_HOME/lib下，比如servlet-api.jar

![[Common 通用类加载器 .jpg]]

　**4 webapp 应用类加载器**

　　每个应用在部署后，都会创建一个唯一的类加载器。该类加载器会加载位于 WEB-INF/lib下的jar文件中的class 和 WEB-INF/classes下的class文件。

　　**当应用需要到某个类时，则会按照下面的顺序进行类加载**：

　　1 使用bootstrap引导类加载器加载

　　2 使用system系统类加载器加载

　　3 使用应用类加载器在WEB-INF/classes中加载

　　4 使用应用类加载器在WEB-INF/lib中加载

　　5 使用common类加载器在CATALINA\_HOME/lib中加载

### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#%E9%97%AE%E9%A2%98%E6%89%A9%E5%B1%95>问题扩展

　　通过对上面tomcat类加载机制的理解，就不难明白 为什么java文件放在Eclipse中的src文件夹下会优先jar包中的class?

　　这是因为Eclipse中的src文件夹中的文件java以及webContent中的JSP都会在tomcat启动时，被编译成class文件放在 WEB-INF/class 中。

　　而Eclipse外部引用的jar包，则相当于放在 WEB-INF/lib 中。

　　因此肯定是 **java文件或者JSP文件编译出的class优先加载**。

　　通过这样，我们就可以简单的把java文件放置在src文件夹中，通过对该java文件的修改以及调试，便于学习拥有源码java文件、却没有打包成xxx-source的jar包。

　　另外呢，开发者也会因为粗心而犯下面的错误。

　　在 CATALINA\_HOME/lib 以及 WEB-INF/lib 中放置了 不同版本的jar包，此时就会导致某些情况下报加载不到类的错误。

　　还有如果多个应用使用同一jar包文件，当放置了多份，就可能导致 多个应用间 出现类加载不到的错误。

## <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#1-java%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%99%A8>1\. java类加载器

近来了解tomcat的类加载机制，所以先回顾一下java虚拟机类加载器，如果从java虚拟机的角度来看的话，其实类加载器只分为两种：一种是启动类加载器(即Bootstrap ClassLoader)，通过使用JNI来实现，我们无法获取到到它的实例；另一种则是java语言实现`java.lang.ClassLoader`的子类。一般从我们的角度来看，会根据类加载路径会把类加载器分为3种：Bootstrap ClassLoader,ExtClassLoader,AppClassLoader.后两者是`sun.misc.Launcher`类的内部类，而前者在JDK源码中是没有与之对应的类的，倒是在`sun.misc.Launcher`中可以看到一些它的加载路径信息。如果找不到sun的源码，可以下载[OpenJDK](http://download.java.net/openjdk/jdk7/promoted/b147/openjdk-7-fcs-src-b147-27_jun_2011.zip)的来看一下。

Bootstrap ClassLoader： 引导类加载器，从%JAVA\_RUNTIME\_JRE%/lib目录加载，但并不是将该目录所有的类库都加载，它会加载一些符合文件名称的，例如：rt.jar,resources.jar等。在`sun.misc.Launcher`源码中也可以看得它的加载路径：

|     |     |
| --- | --- |
| 1   | private static String bootClassPath = System.getProperty("sun.boot.class.path"); |

或者配置-Xbootclasspath参数指定加载的路径，通过获取环境变量`sun.boot.class.path`看一下到底具体加载了那些类：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\lib\\resources.jar<br>D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\lib\\rt.jar<br>D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\lib\\sunrsasign.jar<br>D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\lib\\jsse.jar<br>D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\lib\\jce.jar<br>D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\lib\\charsets.jar<br>D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\lib\\jfr.jar<br>D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\classes |

Extension ClassLoader：扩展类加载器，实现类为`sun.misc.Launcher$ExtClassLoader`，加载%JAVA\_RUNTIME\_JRE%/lib/ext/目录下的jar包，也可以在`sun.misc.Launcher`源码中也可以看得它的加载路径：

|     |     |
| --- | --- |
| 1   | String s = System.getProperty("java.ext.dirs"); |

通过获取`java.ext.dirs`环境变量打印一下：

|     |     |
| --- | --- |
| 1   | D:\\Program Files\\Java\\jdk1.7.0\_67\\jre\\lib\\ext |

Appication ClassLoader：应用程序类加载器，或者叫系统类加载器，实现类为`sun.misc.Launcher$AppClassLoader`。从`sun.misc.Launcher`的构造函数中可以看到，当`AppClassLoader`被初始化以后，它会被设置为当前线程的上下文类加载器以及保存到`Launcher`类的loader属性中，而通过`ClassLoader.getSystemClassLoader()`获取的也正是该类加载器(Launcher.loader)。应用类加载器从用户类路径中加载类库，可以在源码中看到：

|     |     |
| --- | --- |
| 1   | final String s = System.getProperty("java.class.path"); |

### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#1-1-%E7%B1%BB%E5%85%B3%E7%B3%BB>1.1 类关系

![[D20FB41BFE794E0196739C105761133C.png]]

由图看到Bootstrap ClassLoader并不在继承链上，因为它是java虚拟机内置的类加载器，对外不可见。可以看到顶层`ClassLoader`有一个parent属性，用来表示着类加载器之间的层次关系（双亲委派模型）；注意，`ExtClassLoader`类在初始化时显式指定了parent为null，所以它的父类加载器默认为`Bootstrap ClassLoader`。在tomcat中都是通过扩展`URLClassLoader`来实现自己的类加载器。

### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#1-2-%E5%8F%8C%E4%BA%B2%E5%A7%94%E6%89%98%E6%A8%A1%E5%9E%8B>1.2 双亲委托模型

这3种类加载器之间存在着父子关系(区别于java里的继承)，子加载器保存着父加载器的引用。当一个类加载器需要加载一个目标类时，会先委托父加载器去加载，然后父加载器会在自己的加载路径中搜索目标类，父加载器在自己的加载范围中找不到时，才会交还给子加载器加载目标类。

采用双亲委托模式可以避免类加载混乱，而且还将类分层次了，例如java中lang包下的类在jvm启动时就被启动类加载器加载了，而用户一些代码类则由应用程序类加载器(AppClassLoader)加载，基于双亲委托模式，就算用户定义了与lang包中一样的类，最终还是由应用程序类加载器委托给启动类加载器去加载，这个时候启动类加载器发现已经加载过了lang包下的类了，所以两者都不会再重新加载。当然，如果使用者通过自定义的类加载器可以强行打破这种双亲委托模型，但也不会成功的，java安全管理器抛出将会抛出`java.lang.SecurityException`异常。

![[A75B230FED5F4FA7BBC9BF82FBB4F52F.png]]

1.  1.
    
    启动类加载器是扩展类加载器的父类加载器：扩展类加载器在`sun.misc.Launcher`构造函数中被初始化，它的父类加载器被设置了为null，那为什么还说启动类加载器是它的父加载器？看一下`ClassLoader.loadClass()`方法：
    
    |     |     |
    | --- | --- |
    | 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31 | protected Class<?> loadClass(String name, boolean resolve)<br> throws ClassNotFoundException<br> {<br> synchronized (getClassLoadingLock(name)) {<br> // 首先，查找该类是否已经被加载过了<br> Class c = findLoadedClass(name);<br> if (c == null) {  //未被加载过<br> long t0 = System.nanoTime();<br> try {<br> if (parent != null) {  // 父类加载器不为null，则调用父类加载器尝试加载<br> c = parent.loadClass(name, false);<br> } else {   // 父类加载器为null，则调用本地方法，交由启动类加载器加载，所以说ExtClassLoader的父类加载器为Bootstrap ClassLoader<br> c = findBootstrapClassOrNull(name);<br> }<br> } catch (ClassNotFoundException e) {<br> }<br> if (c == null) { //仍然加载不到，只能由本加载器通过findClass去加载<br> long t1 = System.nanoTime();<br> c = findClass(name);<br> // this is the defining class loader; record the stats<br> sun.misc.PerfCounter.getParentDelegationTime().addTime(t1 - t0);<br> sun.misc.PerfCounter.getFindClassTime().addElapsedTimeFrom(t1);<br> sun.misc.PerfCounter.getFindClasses().increment();<br> }<br> }<br> if (resolve) {<br> resolveClass(c);<br> }<br> return c;<br> }<br> } |
    
    从代码中看到，如果parent==null，将会由启动类加载器尝试加载，所以扩展类加载器的父类加载器是启动类加载器。
    
2.  2.
    
    扩展类加载器是应用程序类加载器的父类加载器：这个比较好理解，依然是在`sun.misc.Launcher`构造函数初始化应用程序类加载器时，指定了ExtClassLoader为AppClassLoader的父类加载器:
    
    |     |     |
    | --- | --- |
    | 1   | loader = AppClassLoader.getAppClassLoader(extcl);//loader是ClassLoader的属性,extcl是扩展类加载器实例 |
    
3.  3.
    
    应用程序类加载器是自定义类加载器的父类加载器：这里指的是使用默认构造函数进行自定义类加载器(否则 你可以指定parent来构造一个父加载器为ExtClassLoader的自定义类加载器)，无论是通过扩展ClassLoader还是URLClassLoader最终都会获取系统类加载器(AppClassLoader)作为父类加载器：
    
    |     |     |
    | --- | --- |
    | 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17 | protected ClassLoader() {<br> //调用getSystemClassLoader方法获取系统类加载器作为父类加载器<br> this(checkCreateClassLoader(), getSystemClassLoader()); <br> }<br>public static ClassLoader getSystemClassLoader() {<br> initSystemClassLoader(); //初始化系统类加载器<br> .....<br> return scl;<br> }<br>private static synchronized void initSystemClassLoader() {<br> ......<br> sun.misc.Launcher l = sun.misc.Launcher.getLauncher();<br> ......<br> scl = l.getClassLoader();  //这里拿到的就是在Launcher构造函数中构造的AppClassLoader实例<br> ......<br> }<br> } |
    
    ## <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#2-tomcat7%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%99%A8>2\. tomcat7类加载器
    
    tomcat作为一个java web容器，也有自己的类加载机制，通过自定义的类加载机制以实现共享类库的抽取，不同web应用之间的资源隔离还有热加载等功能。除了一些java自身的一些类加载器处，它实现的主要类加载器有：Common ClassLoader,Catalina ClassLoader,Shared ClassLoader以及WebApp ClassLoader.通过下面类关系图以及逻辑关系图，同时对比上文内容梳理这些类加载器之间的关系。
    
    ### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#2-1-%E7%B1%BB%E5%85%B3%E7%B3%BB%E5%9B%BE>2.1 类关系图
    
    ![[0E42DAE4DE4341118C33D79AD5B0AB7F.png]]
    
    从图中看到了Common,Catalina,Shared类加载器是URLClassLoader类的一个实例，只是它们的类加载路径不一样，在tomcat/conf/catalina.properties配置文件中配置(common.loader,server.loader,shared.loader).WebAppClassLoader继承自WebAppClassLoaderBase,基本所有逻辑都在WebAppClassLoaderBase为中实现了，可以看出tomcat的所有类加载器都是以URLClassLoader为基础进行扩展。
    
    ### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#2-2-%E9%80%BB%E8%BE%91%E5%85%B3%E7%B3%BB%E5%9B%BE>2.2 逻辑关系图
    
    ![[4245B0B09C1F4DF9A544A17D07C2D817.png]]
    
    上面说到Common,Catalina,Shared类加载器是URLClassLoader类的一个实例，在默认的配置中，它们其实都是同一个对象，即commonLoader，结合初始化时的代码(只保留关键代码)：
    
    |     |     |
    | --- | --- |
    | 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13 | private void initClassLoaders() {<br> commonLoader = createClassLoader("common", null);  // commonLoader的加载路径为common.loader<br> if( commonLoader == null ) {<br> commonLoader=this.getClass().getClassLoader();<br> }<br> catalinaLoader = createClassLoader("server", commonLoader); // 加载路径为server.loader，默认为空，父类加载器为commonLoader<br> sharedLoader = createClassLoader("shared", commonLoader); // 加载路径为shared.loader，默认为空，父类加载器为commonLoader<br> }<br>private ClassLoader createClassLoader(String name, ClassLoader parent) throws Exception {<br> String value = CatalinaProperties.getProperty(name + ".loader");<br> if ((value == null) \| (value.equals("")))<br> return parent;      // catalinaLoader与sharedLoader的加载路径均为空，所以直接返回commonLoader对象，默认3者为同一个对象<br> } |
    
    在上面的代码初始化时很明确是指出了，catalina与shared类加载器的父类加载器为common类加载器，而初始化commonClassLoader时父类加载器设置为null，最终会调到`createClassLoader`静态方法：
    
    |     |     |
    | --- | --- |
    | 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16 | public static ClassLoader createClassLoader(List<Repository> repositories,<br> final ClassLoader parent)<br> throws Exception {<br> .....<br> return AccessController.doPrivileged(<br> new PrivilegedAction<URLClassLoader>() {<br> @Override<br> public URLClassLoader run() {<br> if (parent == null)<br> return new URLClassLoader(array);  //该构造方法默认获取系统类加载器为父类加载器，即AppClassLoader<br> else<br> return new URLClassLoader(array, parent);<br> }<br> });<br> <br> } |
    
    在`createClassLoader`中指定参数`parent==null`时，最终会以系统类加载器(AppClassLoader)作为父类加载器，这解释了为什么commonClassLoader的父类加载器是AppClassLoader.
    
    一个web应用对应着一个`StandardContext`实例，每个web应用都拥有独立web应用类加载器(WebClassLoader)，这个类加载器在`StandardContext.startInternal()`中被构造了出来：
    
    |     |     |
    | --- | --- |
    | 1<br>2<br>3<br>4<br>5 | if (getLoader() == null) {<br> WebappLoader webappLoader = new WebappLoader(getParentClassLoader());<br> webappLoader.setDelegate(getDelegate());<br> setLoader(webappLoader);<br> } |
    
    这里`getParentClassLoader()`会获取父容器`StandarHost.parentClassLoader`对象属性，而这个对象属性是在`Catalina$SetParentClassLoaderRule.begin()`初始化，初始化的值其实就是`Catalina.parentClassLoader`对象属性，再来跟踪一下`Catalina.parentClassLoader`，在`Bootstrap.init()`时通过反射调用了`Catalina.setParentClassLoader()`，将`Bootstrap.sharedLoader`属性设置为`Catalina.parentClassLoader`，所以WebClassLoader的父类加载器是Shared ClassLoader.
    
    ### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#2-3-%E7%B1%BB%E5%8A%A0%E8%BD%BD%E9%80%BB%E8%BE%91>2.3 类加载逻辑
    
    tomcat的类加载机制是违反了双亲委托原则的，对于一些未加载的非基础类(Object,String等)，各个web应用自己的类加载器(WebAppClassLoader)会优先加载，加载不到时再交给commonClassLoader走双亲委托。具体的加载逻辑位于W`ebAppClassLoaderBase.loadClass()`方法中，代码篇幅长，这里以文字描述加载一个类过程：
    
4.  4.
    
    先在本地缓存中查找是否已经加载过该类(对于一些已经加载了的类，会被缓存在`resourceEntries`这个数据结构中)，如果已经加载即返回，否则 继续下一步。
    
5.  5.让系统类加载器(AppClassLoader)尝试加载该类，主要是为了防止一些基础类会被web中的类覆盖，如果加载到即返回，返回继续。
6.  6.前两步均没加载到目标类，那么web应用的类加载器将自行加载，如果加载到则返回，否则继续下一步。
7.  7.
    
    最后还是加载不到的话，则委托父类加载器(Common ClassLoader)去加载。
    
    第3第4两个步骤的顺序已经违反了双亲委托机制，除了tomcat之外，JDBC,JNDI,`Thread.currentThread().setContextClassLoader();`等很多地方都一样是违反了双亲委托。
    

## <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#Tomcat%E6%9E%B6%E6%9E%84>Tomcat架构

### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#1-Tomcat%E6%95%B4%E4%BD%93%E6%9E%B6%E6%9E%84%E5%9B%BE>1.Tomcat整体架构图

![[tomcat架构图.gif]]

*   **Server** : Server是Tomcat最顶层的容器，代表着整个服务器，即一个Tomcat只有一个Server，Server中包含至少一个Service组件，Server控制整个Tomcat的生命周期。
    
*   **Service** : Serivce是Server中的一个逻辑功能层，Service组件包含了Connector组件和Container组件，即Service相当于Connector和Container组件的包装器，将一个或者多个Connector和一个Container建立关联关系，对外提供具体的服务。在默认的配置文件中，定义了一个叫Catalina 的服务。
    
*   **Connector** : Connector组件主要是用于处理连接相关的事情，并提供Socket与request、response的转换；如Tomcat是http服务器，提供http服务，而我们知道Http应用协议最终需要TCP层协议进行包的传递，而对应Tomcat中则是通过Socket进行通信。一个Connector会监听一个独立的端口来处理来自客户端的请求。connector会注册到一个service中，Connector接受到请求后，会将请求交给Container，Container处理完了之后将结果返回给Connector
    
*   **Container** ：Container 就是Servlet 容器。Container是容器的父接口，所有子容器都必须实现这个接口，Container容器的设计用的是典型的责任链的设计模式，它有四个子 容器组件构成，分别是：Engine、Host、Context、Wrapper，这四个组件不是平行的，而是父子关系，Engine包含 Host,Host 包含 Context，Context 包含 Wrapper。
    

![[container架构图.png]]

*   **Engine** : Engine代表一个完整的 Servlet 引擎，用于管理多个站点，一个Service最多只能有一个Engine，而一个Engine可以包含一个或者多个Host，即一个Tomcat实例可以配置多个虚拟主机。它接收来自Connector的请求，并决定传给哪个Host来处理，Host处理完请求后，将结果返回给Engine，Engine再将结果返回给Connector
    
*   **Host**: 每个Host代表一个站点，也可以称为一个虚拟主机，这个虚拟主机的作用就是运行多个Context，并且标识这个Context以便能够区分它们，每个虚拟主机对应的一个域名，不同Host容器接受处理对应不同域名的请求。
    
*   **Context** : Context是Servlet规范的实现，它提供了Servlet的基本环境，一个Context代表一个运行在Host上的Web应用。 Context可以包含多个Wrapper。
*   **Wrapper** : Wrapper 代表一个 Servlet，它负责管理一个 Servlet，包括的 Servlet 的装载、初始化、执行以及资源回收。Wrapper 是最底层的容器，它没有子容器了。

### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#2-%E7%BB%84%E4%BB%B6%E5%8C%85%E5%90%AB%E5%85%B3%E7%B3%BB>2\. 组件包含关系

![[tomcat组件架构图.jpg]]

### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#3-Tomcat%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B>3.Tomcat启动过程

#### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#3-1-tomcat%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F>3.1 tomcat生命周期

![[tomcat生命周期.jpeg]]

*   Lifecycle：定义了容器生命周期、容器状态转换及容器状态迁移事件的监听器注册和移除等主要接口；
*   LifecycleBase：作为Lifecycle接口的抽象实现类，运用抽象模板模式将所有容器的生命周期及状态转换衔接起来，此外还提供了生成LifecycleEvent事件的接口；
*   LifecycleSupport：提供有关LifecycleEvent事件的监听器注册、移除，并且使用经典的监听器模式，实现事件生成后触达监听器的实现；
*   MBeanRegistration：Java JMX框架提供的注册MBean的接口，引入此接口是为了便于使用JMX提供的管理功能；
*   LifecycleMBeanBase：Tomcat提供的对MBeanRegistration的抽象实现类，运用抽象模板模式将所有容器统一注册到JMX；

#### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#3-2-catalina-home%E5%92%8Ccatalina-base>3.2 **catalina.home和catalina.base**

Bootstrap启动的时候使用了两个系统变量catalina.home和catalina.base
catalina.home是Tomcat产品的安装目录，而catalina.base是tomcat的工作目录，是tomcat启动过程中需要读取的各种配置及日志的根目录。默认情况下catalina.base是和catalina.home是相同的。但是想运行Tomcat 的多个实例，但是不想安装多个Tomcat 软件副本。那么我们可以配置多个工作目录，每个运行实例独占一个工作目录，但是共享同一个安装目录。

#### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#3-3-%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%99%A8%E5%AE%9E%E7%8E%B0%E9%83%A8%E5%88%86>3.3 类加载器实现部分

首先简单介绍下Java虚拟机规范中提到的主要类加载器； Bootstrap Loader、Extended Loader、AppClass Loader

![%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%99%A8.png](http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/Users/muzhi%201/git/MyPostImage/blog/%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%99%A8.png)

根据java虚拟机的双亲委派模式的原则，类加载器在加载一个类时，首先交给父类加载器加载，层层往上直到Bootstrap Loader。也就是一个类最先由Bootstrap Loader加载，如果没有加载到，则交给下一层的类加载器加载，如果没有加载到，则依次层层往下，直到最下层的类加载器。这也就是说，凡是能通过父一级类加载器加载到的类，对于子类也是可见的。因此可以利用双亲委派模式的特性，使用类加载器对不同路径下的jar包或者类进行环境隔离。

![[tomcat类加载.jpeg]]

*   **ClassLoader：**Java提供的类加载器抽象类，用户自定义的类加载器需要继承实现
*   **commonLoader**：Tomcat最基本的类加载器，加载路径中的class可以被Tomcat容器本身以及各个Webapp访问；
*   **catalinaLoader：**Tomcat容器私有的类加载器，加载路径中的class对于Webapp不可见；
*   **sharedLoader**：各个Webapp共享的类加载器，加载路径中的class对于所有Webapp可见，但是对于Tomcat容器不可见；
*   **WebappClassLoader**：各个Webapp私有的类加载器，加载路径中的class只对当前Webapp可见；

> coyote是tomcat的Connector框架的名字。coyote本质上是为tomcat的容器提供了对底层socket连接数据的封装，以Request类的形式，让容器能够访问到底层的数据。

#### <http://lingo0.github.io/2018/06/09/Tomcat%E6%9E%B6%E6%9E%84%E5%92%8C%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%90%AF%E5%8A%A8%E8%BF%87%E7%A8%8B/#3-4-%E5%AE%B9%E5%99%A8%E7%9A%84%E5%88%9D%E5%A7%8B%E5%8C%96>3.4 容器的初始化

![[tomcat容器初始化.jpeg]]

1.  1.调用方调用容器父类LifecycleBase的init方法，LifecycleBase的init方法主要完成一些所有容器公共抽象出来的动作；
2.  2.LifecycleBase的init方法调用具体容器的initInternal方法实现，此initInternal方法用于对容器本身真正的初始化；
3.  3.具体容器的initInternal方法调用父类LifecycleMBeanBase的initInternal方法实现，此initInternal方法用于将容器托管到JMX，便于运维管理；
4.  4.LifecycleMBeanBase的initInternal方法调用自身的register方法，将容器作为MBean注册到MBeanServer；
5.  5.容器如果有子容器，会调用子容器的init方法；
6.  6.容器初始化完毕，LifecycleBase会将容器的状态更改为初始化完毕，即LifecycleState.INITIALIZED。

> 注意这个地方初始化操作只进行到StandardEngine, StandaHost并不是这个时候进行初始化的，而是在StandardEngine的startInternal

![[容器启动.jpeg]]

1.  1.调用方调用容器父类LifecycleBase的start方法，LifecycleBase的start方法主要完成一些所有容器公共抽象出来的动作；
2.  2.LifecycleBase的start方法先将容器状态改为LifecycleState.STARTING\_PREP，然后调用具体容器的startInternal方法实现，此startInternal方法用于对容器本身真正的初始化；
3.  3.具体容器的startInternal方法会将容器状态改为LifecycleState.STARTING，容器如果有子容器，会调用子容器的start方法启动子容器；
4.  4.容器启动完毕，LifecycleBase会将容器的状态更改为启动完毕，即LifecycleState.STARTED。

![[Tomcat-25E5-2590-25AF-25E5-258A-25A8-25E8-25BF-25E.png]]

[[# | 赏

__谢谢你请我吃糖果__

![[180420_0dg7116cadcl9g416clgb9al70ac2_426x432.png]] 支付宝]]

__

*   [[# | Tomcat]]

[[# | __]]

[[# | __]] [[# | __]] [[# | __]] [[# | __]] [[# | __]] [[# | __]] [[# | __]] [[# | __]]

    Created at: 2020-12-18T10:27:10+08:00
    Updated at: 2020-12-18T10:27:10+08:00

