
温馨提示：将鼠标放在语句上可以显示对应的英文。   或者   [[# | 切换至中英文显示]]

**使用弹簧控制器，端点在主体响应中返回文件。** **我想确保不要使用“尝试使用资源”来获取资源泄漏，但是这样在邮递员中我会得到一个错误：**

> **“错误”：“内部服务器错误”，“消息”：“流关闭”，**

**Spring控制器中的代码片段：**

`InputStreamResource result;
ResponseEntity<Resource> response;
try(FileInputStream ios = new FileInputStream(file)){
    result = new InputStreamResource(ios);
    response = ResponseEntity.ok()
        .headers(/*some headers here*/)
        .contentLength(file.length())
        .contentType(/*some media type here*/)
        .body(result);
    logger.info("successfully created");
    return response;
} catch (IOException e) {
        //some code here..
}` 

**有趣的是，在日志中我收到了成功消息，但是在邮递员或浏览器中（这是一个GET请求），我得到了一个错误。**

**如果不使用“ try-with-resource”，它会起作用，但是我担心那样会导致资源泄漏。**

[java](https://stackoom.com/tag/java) [stream](https://stackoom.com/tag/stream) [spring-restcontroller](https://stackoom.com/tag/spring-restcontroller) [try-with-resources](https://stackoom.com/tag/try-with-resources)

## 1 个回复

[按投票数排序](https://stackoom.com/question?bigid=3vh88&tab=votes) [按时间排序](https://stackoom.com/question?bigid=3vh88&tab=oldest)

### **\===============>>#1 票数：1 已采纳**

**由于**尝试使用资源**会在`return`之前调用`close()` ，因此会发生“流关闭”错误。**
**一种简单的方法是将`InputStreamResource`的实例直接放在`.body()` ，并且大多数Web实例也都这样做。** **但是，我不确定是否会正确关闭资源以防止应用程序发生资源泄漏。**

`response = ResponseEntity.ok()
    .contentLength(file.length())
    .body(new InputStreamResource(new FileInputStream(file)));
return response;` 

**另一种方法，如果要流式传输响应，则可以使用`StreamingResponseBody` 。**

> ****接口StreamingResponseBody** （引自Spring网站）**
> 
> **这是一个功能接口，因此可以用作lambda表达式或方法引用的分配目标。**

**样例代码：**

`StreamingResponseBody responseBody = outputStream -> {
    Files.copy(file.toPath(), outputStream);
};

response.ok()
    .contentLength(file.length())
    .body(responseBody);
return response;` 

##  ask by Nikolas translate from [so](https://stackoom.com/go/3vh88)

## **未解决问题？本站智能推荐：**

**2**回复

### [在Java中安全关闭流](https://stackoom.com/question/1h5PO/%E5%9C%A8Java%E4%B8%AD%E5%AE%89%E5%85%A8%E5%85%B3%E9%97%AD%E6%B5%81)

我想使用Java的try-with-resources安全，完全关闭多个流。 我不知道我要多么冗长。 我想确保我的资源得到充分利用。 我的代码是这样的： 我想知道这是否矫kill过正，是否可以做到这一点：

**2**回复

### [FileInputStream并关闭](https://stackoom.com/question/29Z3Q/FileInputStream%E5%B9%B6%E5%85%B3%E9%97%AD)

在我的代码中，无论在哪里需要FileInputStream作为参数，我都在这样做： 由于我没有将FileInputStream分配给任何参考变量，因此我没有使用close()方法关闭它。 这会导致内存泄漏吗？ 上述方法中FileInputStream释放的资源不是吗？

**2**回复

### [流关闭而不是重新打开 - Java](https://stackoom.com/question/2cpc8/%E6%B5%81%E5%85%B3%E9%97%AD%E8%80%8C%E4%B8%8D%E6%98%AF%E9%87%8D%E6%96%B0%E6%89%93%E5%BC%80-Java)

我有一个简单的“家庭作业”，但我发现输入流的关闭有点问题。 简单地说，我必须用Java创建一个联系人'列表'应用程序，只是以正确的方式使用多态。 所以我有一个类Contact和一个子类Private（联系人）。 在这两个类中都有一个修改方法来更改变量的值。 这是不会产生问题的Con

**1**回复

### [关闭流链和尝试资源](https://stackoom.com/question/1QoID/%E5%85%B3%E9%97%AD%E6%B5%81%E9%93%BE%E5%92%8C%E5%B0%9D%E8%AF%95%E8%B5%84%E6%BA%90)

我对stackoverflow的第一个问题，我退出了;） 使用流链时，通常最好只关闭链中的最后一个流，因为close（）操作应该在链的所有流中传播。 将try-with-source语句和流链接结合在一起时，什么被认为是好的做法？ a）在try语句中创建所有流： 或b）

**1**回复

### [如果可以安全地从try-with-resource返回InputStream 重复](https://stackoom.com/question/24Zmu/%E5%A6%82%E6%9E%9C%E5%8F%AF%E4%BB%A5%E5%AE%89%E5%85%A8%E5%9C%B0%E4%BB%8Etry-with-resource%E8%BF%94%E5%9B%9EInputStream-%E9%87%8D%E5%A4%8D)

这个问题已经在这里有了答案： Java中的try-with-resources和return语句 2答案 一旦调用者使用完try-with-resource语句，就可以安全地从try-with-source语句返回输入流来处理该流的关闭？

**1**回复

### [我可以将try-with-resources与已创建的InputStream一起使用吗？](https://stackoom.com/question/3c1wx/%E6%88%91%E5%8F%AF%E4%BB%A5%E5%B0%86try-with-resources%E4%B8%8E%E5%B7%B2%E5%88%9B%E5%BB%BA%E7%9A%84InputStream%E4%B8%80%E8%B5%B7%E4%BD%BF%E7%94%A8%E5%90%97)

像这样： 它似乎工作。 安全吗？

**2**回复

### [为什么用String初始化的InputStream在try-with-resources之外保持打开状态？](https://stackoom.com/question/1xHqV/%E4%B8%BA%E4%BB%80%E4%B9%88%E7%94%A8String%E5%88%9D%E5%A7%8B%E5%8C%96%E7%9A%84InputStream%E5%9C%A8try-with-resources%E4%B9%8B%E5%A4%96%E4%BF%9D%E6%8C%81%E6%89%93%E5%BC%80%E7%8A%B6%E6%80%81)

我注意到，由于流被自动关闭，因此抛出了IOException异常： 而当InputStream用String初始化时，它不会： BufferedReader和BufferedInputStream都使用一个放在方括号外的对象初始化。 它与InputStream在内部处理Stri

**1**回复

### [为输入流和错误流尝试资源](https://stackoom.com/question/2sE3n/%E4%B8%BA%E8%BE%93%E5%85%A5%E6%B5%81%E5%92%8C%E9%94%99%E8%AF%AF%E6%B5%81%E5%B0%9D%E8%AF%95%E8%B5%84%E6%BA%90)

当涉及getInputStream和getErrorStream时，如何使用try资源进行全面介绍

**2**回复

### [如何在Java中关闭隐式Stream？](https://stackoom.com/question/3eysR/%E5%A6%82%E4%BD%95%E5%9C%A8Java%E4%B8%AD%E5%85%B3%E9%97%AD%E9%9A%90%E5%BC%8FStream)

Files.walk是我应该关闭的流之一，但是，如何在下面的代码中关闭流？ 下面的代码是否有效，或者我是否需要重写它以便我可以访问流来关闭它？

    Created at: 2020-11-13T11:18:31+08:00
    Updated at: 2020-11-13T11:18:31+08:00

