
# SpringBoot如何处理自定义异常(都是套路！！！)

![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/original.png]]
[我要大芒果](https://blog.csdn.net/java_miss_you) 2020-02-23 20:27:50 ![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/articleReadEyes.png]] 4304  ![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/planImg.png]] 原力计划

		
分类专栏： [SpringBoot](https://blog.csdn.net/java_miss_you/category_9710400.html) [\# SpringBoot整合Web](https://blog.csdn.net/java_miss_you/category_9720628.html) 文章标签： [spring](https://www.csdn.net/tags/MtTaEg0sMDg2NTAtYmxvZwO0O0OO0O0O.html) [java](https://www.csdn.net/tags/NtTaIg5sMzYyLWJsb2cO0O0O.html) [spring boot](https://so.csdn.net/so/search/s.do?q=spring%20boot&t=blog&o=vip&s=&l=&f=&viparticle=) [exception](https://www.csdn.net/tags/MtTaEg0sMzQwMDMtYmxvZwO0O0OO0O0O.html)

![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/embedded.svg]]

### 文章目录

*   [一、前言](https://blog.csdn.net/java_miss_you/article/details/104451151?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control#_1)
*   [二、静态异常页面](https://blog.csdn.net/java_miss_you/article/details/104451151?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control#_9)
*   [三、动态异常页面](https://blog.csdn.net/java_miss_you/article/details/104451151?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control#_17)
*   [四、源码解读](https://blog.csdn.net/java_miss_you/article/details/104451151?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control#_65)
*   [五、自定义异常数据](https://blog.csdn.net/java_miss_you/article/details/104451151?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control#_86)
*   [六、自定义异常视图](https://blog.csdn.net/java_miss_you/article/details/104451151?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control#_143)
*   [七、总结](https://blog.csdn.net/java_miss_you/article/details/104451151?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control#_200)
*   [八、源码地址](https://blog.csdn.net/java_miss_you/article/details/104451151?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-1.control#_202)

### 一、前言

在 SpringBoot 项目中，对于异常的统一处理，可以采用 Spring 中`@ControllerAdvice`注解标注的类来统一进行处理，也可以自定义异常处理的解决方案。在 SpringBoot 中，对异常的处理存在一些默认的策略，下面我们就分别来看一下。

默认情况下，SpringBoot项目异常页面如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.4.png]]
其实通过这个默认的提示页面，能够看出来，之所以能够看到这个默认的异常提示页面，是因为开发者没有提供明确映射路径`/error`，如果开发者提供了这个路径，则此页面则不会显示，不过在 SpringBoot 项目中提供`/error`路径实属下下策，为什么这么说？因为 SpringBoot 本身在处理异常时，即当所有条件都不满足时，才会去寻找`/error`路径，为何要这么复杂，这不是降低效率吗？

现在，先来看看在 SpringBoot 中如何自定义异常页面，就页面属性而言，可以分为两类，一类是**静态异常页面**，另一类是**动态异常页面**。

### 二、静态异常页面

常见的异常可以分为两个派系，分别是 400 系列和 500 系列。自定义异常页面也可以分为两类，一类是以 HTTP 响应码来命名的，例如：402.html、404.html、500.html 等等，另一类则是直接定义一个 4xx.html，状态响应码在 400-499 范围内都显示 4xx.html 异常页面，5xx.html 包含 500-599 范围内的状态响应码都显示 5xx.html 异常页面。

默认情况下，是在`classpath:/static/error/`下定义异常页面，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.1.png]]
【**划重点啦**】

如果项目中抛出状态码为 500 的错误，则自动展示 500.html 异常页面，若抛出的状态码为 404，则自动展示 404.html 异常页面。如果项目中存在 500.html 页面，同时也存在 5xx.html 页面，若此时发生 500 错误，则优先展示 500.html 页面。这里有个**优先级原则：精确 > 模糊**。

### 三、动态异常页面

其实动态异常页面定义与静态异常页面的方式相同，可以采用的模板技术包含：jsp、freemarker、thymeleaf。动态异常页面命名可以是404、500等等精确的状态码命名方式，一般情况下，由于动态异常页面可以直接展示异常详细的信息，所以没有必要挨个枚举了，这里就直接定义为4xx.html、5xx.html。（这里采用的是thymeleaf）

动态异常页面定义如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.10.png]]
【5xx.html】

    <!DOCTYPE html>
    <html lang="en" xmlns:th="http://www.thymeleaf.org">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
    </head>
    <body>
    <h1>templates-5xx</h1>
    <tr>
        <td>path</td>
        <td th:text="${path}"></td>
    </tr>
    <tr>
        <td>timestamp</td>
        <td th:text="${timestamp}"></td>
    </tr>
    <tr>
        <td>message</td>
        <td th:text="${message}"></td>
    </tr>
    <tr>
        <td>error</td>
        <td th:text="${error}"></td>
    </tr>
    <tr>
        <td>status</td>
        <td th:text="${status}"></td>
    </tr>
    </body>
    </html>
    

默认情况下，会展示5条异常相关信息，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.9.png]]
【**划重点啦**】

如果动态页面和静态页面都定义了异常处理页面，例如：`classpath:/templates/error/404.html`和`classpath:/static/error/404.html`两者同时存在，如果抛出异常，默认使用动态异常页面。这里也有一个**优先级原则：动态 > 静态**。

【**小结一下**】

从前面可以看出，共有**两个优先级原则**，分别是：**精确 > 模糊、动态 > 静态**，但是**这两者的优先级原则是：前者 > 后者**，我想这并不难理解。

### 四、源码解读

了解了前面的两类异常页面，下面，我将对上面两组原则通过源码的方式进行解释。

【**第一步**】找到`ErrorMvcAutoConfiguration`这个类，我们需要找到这个类中的`conventionErrorViewResolver`方法，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.8.png]]
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.11.png]]
可以看到`conventionErrorViewResolver`方法的返回值是`DefaultErrorViewResolver`，即**默认异常视图解释器**，下面我们就进入`DefaultErrorViewResolver`这个类中一探究竟。

【**第二步**】找到`DefaultErrorViewResolver`类中的`resolveErrorView`方法，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.7.png]]
首先我们来看看这个方法中的三个参数，`request`表示请求的数据，`status`表示状态码，`model`表示异常数据，接下看我们一步一步往下看，该方法中第一行通过调用了`resolve`方法来定义了视图，进入`resolve`方法中：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.png]]
从第一行可以看到`error/`路径，这个便是SpringBoot中默认异常页面的路径，所有异常页面可以放在该目录下便会自动寻找，`viewName`就是状态码，下面几行的意思是，寻找动态模板提供者，如果有则返回，反之则进入`resolveResource`方法中，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.5.png]]
前面`resolve`方法中是寻找动态异常页面，而`resolveResource`方法则相反，则是寻找静态异常页面，从这个`for`循环可以看到，有个东西很眼熟，就是`getStaticLocations`方法了，这个我在以前的博客中讲过，[SpringBoot中静态资源访问方案](https://blog.csdn.net/java_miss_you/article/details/104362771)，这里还是说一下，里面定义了4个静态页面访问默认路径，分别是：`classpath:/META-INF/resources/`、`classpath:/resources/`、`classpath:/static/`、`classpath:/public/`，所以静态异常页面放在这4个目录下的`error/`目录下即可，下面就是在这几个目录下去寻找静态异常页面，若找到返回，反之则返回`null`，然后再回到`resolveErrorView`方法中，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.7.png]]
可以看到`if`中条件的第一个已满足，我们来看看第二个条件，`SERIES_VIEWS`其实是该类前面定义的 4xx 和 5xx 的一个枚举类型的`Map`，而`status.series()`返回的值就是具体的状态码，在400-499之间属于4xx，在500-599之间则属于5xx。如果两个条件都满足，会再次调用`resolve`方法。

【**小结一下**】

通过对源码的解读，是不是就明白了为什么异常页面要放在`error/`目录下呢？明白了异常页面命名的方式呢？理解了两个优先级原则呢？

### 五、自定义异常数据

一般情况下，在 SpringBoot 中，异常信息就是下面展示的 5 条，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.9.png]]
这 5 条异常数据定义在`org.springframework.boot.web.servlet.error.DefaultErrorAttributes`中的`getErrorAttributes`方法中，如下：

        @Override
    	public Map<String, Object> getErrorAttributes(WebRequest webRequest, boolean includeStackTrace) {
    		Map<String, Object> errorAttributes = new LinkedHashMap<>();
    		errorAttributes.put("timestamp", new Date());
    		addStatus(errorAttributes, webRequest);
    		addErrorDetails(errorAttributes, webRequest, includeStackTrace);
    		addPath(errorAttributes, webRequest);
    		return errorAttributes;
    	}
    

因为该方法里面还存在方法，现在我来整理成**简化版本**的，如下：

        @Override
    	public Map<String, Object> getErrorAttributes(WebRequest webRequest, boolean includeStackTrace) {
    		Map<String, Object> errorAttributes = new LinkedHashMap<>();
    		errorAttributes.put("timestamp", new Date());
    		errorAttributes.put("status", status);
    		errorAttributes.put("error",HttpStatus.valueOf(status).getReasonPhrase());
    		errorAttributes.put("message", StringUtils.isEmpty(message) ? "No message available" : message);
    		errorAttributes.put("path", path);
    		return errorAttributes;
    	}
    

其实，`DefaultErrorAttributes`类本来定义在`ErrorMvcAutoConfiguration`异常自动配置类中的`errorAttributes`方法中定义，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.3.png]]
如果开发者未自己提供 `ErrorAttributes` 实例，则 SpringBoot 会默认提供一个`ErrorAttributes` 实例，即`DefaultErrorAttributes`。

基于该原则，开发者自定义`ErrorAttributes` 实例有两种方式，如下：

1.  直接实现 `ErrorAttributes` 接口。
2.  继承 `DefaultErrorAttributes`（**推荐**），因为 DefaultErrorAttributes 中对异常数据的处理已经完成，开发者可以直接使用。

具体定义如下：

    @Component
    public class MyErrorAttribute extends DefaultErrorAttributes {
    
        @Override
        public Map<String, Object> getErrorAttributes(WebRequest webRequest, boolean includeStackTrace) {
            Map<String, Object> map = super.getErrorAttributes(webRequest, includeStackTrace);
            map.put("myerror","这是我自定义的异常！");
            return map;
        }
    }
    

自定义`ErrorAttributes`后，记得使用`@Component`注解成一个`Bean`，这样SpringBoot就不会使用默认的`DefaultErrorAttributes`了，大家可以使用debug试一下。

【运行结果】
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.2.png]]

### 六、自定义异常视图

异常视图页面默认的就是前面提到的静态异常页面和动态异常页面，当然这个也是可以自定义的。首先，默认异常页面加载逻辑在`org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController`类中的`errorHtml`方法中，这个方法用来返回异常页面+数据，除此之外，还有个`error`方法，该方法用于返回异常数据（如果是Ajax请求，该方法则会被触发）。

        @RequestMapping(produces = MediaType.TEXT_HTML_VALUE)
    	public ModelAndView errorHtml(HttpServletRequest request, HttpServletResponse response) {
    		HttpStatus status = getStatus(request);
    		Map<String, Object> model = Collections
    				.unmodifiableMap(getErrorAttributes(request, isIncludeStackTrace(request, MediaType.TEXT_HTML)));
    		response.setStatus(status.value());
    		ModelAndView modelAndView = resolveErrorView(request, response, status, model);
    		return (modelAndView != null) ? modelAndView : new ModelAndView("error", model);
    	}
    

在该方法中，首先会通过`getErrorAttributes`方法获取异常数据（实际上会调用到 `ErrorAttributes` 类中的 `getErrorAttributes` 方法），然后会调用`resolveErrorView`方法去创建一个`ModelAndView`，如果创建失败，那么就会看到默认的错误提示页面了。

一般情况下，`resolveErrorView`方法会到`DefaultErrorViewResolver`类中的`resolveErrorView`方法中：

        @Override
    	public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus status, Map<String, Object> model) {
    		ModelAndView modelAndView = resolve(String.valueOf(status.value()), model);
    		if (modelAndView == null && SERIES_VIEWS.containsKey(status.series())) {
    			modelAndView = resolve(SERIES_VIEWS.get(status.series()), model);
    		}
    		return modelAndView;
    	}
    

在这里，首先会以状态码作为视图名去精确的查找动态异常页面和静态异常页面，如果没有找到，就会以 4xx 或 5xx 再分别去查找动态异常页面和静态异常页面。

其实，要自定义异常视图解析，也比较容易，由于`ErrorMvcAutoConfiguration`类中默认提供了默认的视图解析实例`DefaultErrorViewResolver`，如果开发者未提供相关实例，则使用默认实例，若提供了相关实例，则默认实例就会失效。因此，自定义异常视图，只需要提供一个`ErrorViewResolver`即可，如下：

    @Component
    public class MyErrorViewResolver extends DefaultErrorViewResolver {
        /**
         * Create a new {@link DefaultErrorViewResolver} instance.
         *
         * @param applicationContext the source application context
         * @param resourceProperties resource properties
         */
        public MyErrorViewResolver(ApplicationContext applicationContext, ResourceProperties resourceProperties) {
            super(applicationContext, resourceProperties);
        }
    
        @Override
        public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus status, Map<String, Object> model) {
            ModelAndView view = new ModelAndView();
            view.setViewName("mangoError");
            view.addAllObjects(model);
            return view;
        }
    }
    

`mangoError`就是自定义异常视图名，这里也可以自定义异常数据（直接在`resolveErrorView`方法中定义一个model，然后将参数中的model拷贝过去即可，可以在新的model中添加或删除异常数据，**值得注意的是参数中的model类型是`UnmodifiableMap`，即不可直接修改的Map**），而不需要自定义`MyErrorAttributes`。自定义完成后，提供一个名为`mangoError`的视图，如下：
![[./_resources/SpringBoot如何处理自定义异常(都是套路！！！)_Mango的博客-CSDN博客.resources/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_.6.png]]
如此一来，自定义异常视图就算成功了。

### 七、总结

其实还可以自定义异常控制器`BasicErrorController`，但是我觉得太大动干戈了，没必要，前面几种方式已经可以满足开发者大部分需求了。

### 八、源码地址

[SpringBoot中关于自定义异常处理的源码地址](https://github.com/java22/exception)

    Created at: 2020-12-23T11:36:59+08:00
    Updated at: 2020-12-23T11:36:59+08:00

