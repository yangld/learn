
# @TransactionalEventListener的使用和实现原理

![[8知识管理/InBox/evernote/参考/_resources/@TransactionalEventListener的使用和实现原理_Evan's_Blog_٩(๑❛ᴗ❛๑)۶-CSDN博客.1.resources/original.png]]
置顶 [Evan Wang](https://evanwang.blog.csdn.net/) 2020-04-25 14:40:05 ![[8知识管理/InBox/evernote/参考/_resources/@TransactionalEventListener的使用和实现原理_Evan's_Blog_٩(๑❛ᴗ❛๑)۶-CSDN博客.1.resources/articleReadEyes.png]] 1094  ![[8知识管理/InBox/evernote/参考/_resources/@TransactionalEventListener的使用和实现原理_Evan's_Blog_٩(๑❛ᴗ❛๑)۶-CSDN博客.1.resources/planImg.png]] 原力计划

		
分类专栏： [Spring](https://blog.csdn.net/qq_41378597/category_8397821.html) 文章标签： [spring](https://www.csdn.net/tags/MtTaEg0sMDg2NTAtYmxvZwO0O0OO0O0O.html) [java](https://www.csdn.net/tags/NtTaIg5sMzYyLWJsb2cO0O0O.html)

![[8知识管理/InBox/evernote/参考/_resources/@TransactionalEventListener的使用和实现原理_Evan's_Blog_٩(๑❛ᴗ❛๑)۶-CSDN博客.1.resources/embedded.svg]]

## 一、问题描述

平时我们在完成某些数据的入库后，发布了一个事件，此时使用的是`@EventListener`，然后在这个事件中，又去对刚才入库的数据进行查询，从而完成后续的操作。例如（数据入库=>对入库数据进行查询审核），这时候会发现，查询不到刚才入库的数据，这是因为事务还没提交完成，在同一个事务当中，查询不到才存入的数据，那么就引出了下面的解决方式。

**为了解决上述问题，Spring为我们提供了两种方式：**
(1) `@TransactionalEventListener`注解。
(2) 事务同步管理器`TransactionSynchronizationManager`。
以便我们可以在事务提交后再触发某一事件来进行其他操作。

## 二、使用场景

在项目当中，我们有时候需要在执行数据库操作之后，发送消息或事件来异步调用其他组件执行相应的操作，例如：
1.数据完成导入之后，发布审核事件，对入库的数据进行审核。
2.用户在完成注册后发送激活码。
3.配置修改后，发送更新配置的事件。

## 三、@TransactionalEventListener详解

我们可以从命名上直接看出，它就是个`EventListener`，
在Spring4.2+，有一种叫做`@TransactionEventListener`的方式，能够实现在控制事务的同时，完成对对事件的处理。

我们知道，Spring的事件监听机制（发布订阅模型）实际上并不是异步的（默认情况下），而是同步的来将代码进行解耦。而`@TransactionEventListener`仍是通过这种方式，但是加入了回调的方式来解决，这样就能够在事务进行**Commited**，**Rollback**…等时候才去进行**Event**的处理，来达到事务同步的目的。

    // @since 4.2 注解的方式提供的相对较晚，其实API的方式在第一个版本就已经提供了。
    // 值得注意的是，在这个注解上面有一个注解：`@EventListener`，所以表明其实这个注解也是个事件监听器。 
    @Target({ElementType.METHOD, ElementType.ANNOTATION_TYPE})
    @Retention(RetentionPolicy.RUNTIME)
    @Documented
    @EventListener //有类似于注解继承的效果
    public @interface TransactionalEventListener {
    	// 这个注解取值有：BEFORE_COMMIT、AFTER_COMMIT、AFTER_ROLLBACK、AFTER_COMPLETION
    	// 各个值都代表什么意思表达什么功能，非常清晰，下面解释了对应的枚举类~
    	// 需要注意的是：AFTER_COMMIT + AFTER_COMPLETION是可以同时生效的
    	// AFTER_ROLLBACK + AFTER_COMPLETION是可以同时生效的
    	TransactionPhase phase() default TransactionPhase.AFTER_COMMIT;
    
    	// 表明若没有事务的时候，对应的event是否需要执行，默认值为false表示，没事务就不执行了。
    	boolean fallbackExecution() default false;
    
    	// 这里巧妙的用到了@AliasFor的能力，放到了@EventListener身上
    	// 注意：一般建议都需要指定此值，否则默认可以处理所有类型的事件，范围太广了。
    	@AliasFor(annotation = EventListener.class, attribute = "classes")
    	Class<?>[] value() default {};
    	@AliasFor(annotation = EventListener.class, attribute = "classes")
    	Class<?>[] classes() default {};
    	
    	String condition() default "";
    }
    

    public enum TransactionPhase {
       // 指定目标方法在事务commit之前执行
       BEFORE_COMMIT,
    
       // 指定目标方法在事务commit之后执行
        AFTER_COMMIT,
    
        // 指定目标方法在事务rollback之后执行
        AFTER_ROLLBACK,
    
       // 指定目标方法在事务完成时执行，这里的完成是指无论事务是成功提交还是事务回滚了
       AFTER_COMPLETION
      }
    

## 四、代码示例

**这里主要是为了讲解如何使用@TransactionalEventListener，所以就不列出所有代码了。**

    @Data
    public class User {
    
     private long id;
     private String name;
     private Integer age;
    
    }
    

业务实现：

    @Service
    @Slf4j
    public class UserServiceImpl extends implements UserService {
    
    	@Autowired
        UserMapper userMapper;
        	
    	@Autowired
        ApplicationEventPublisher eventPublisher;
    	
    	public void userRegister(User user){
    		userMapper.insertUser(user);
    		eventPublisher.publishEvent(new UserRegisterEvent(new Date()));
    	}
    }
    

自定义事件：

    @Getter
    @Setter
    public class UserRegisterEvent extends ApplicationEvent {
    
        private Date registerDate;
    
        public UserRegisterEvent(Date registerDate) {
            super(registerDate);
            this.registerDate = registerDate;
        }
    }
    

事件监听器：

    @Slf4j
    @Component
    public class UserListener {
    
        @Autowired
        UserService userService;
    
        @Async
        @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT, classes = UserRegisterEvent.class)
        public void onUserRegisterEvent(UserRegisterEvent event) {
            userService.sendActivationCode(event.getRegisterDate());
        }
    }
    
    

## 五、实现原理

关于事务的实现原理，这里其实是比较简单的,Spring对事务监控的处理逻辑在TransactionSynchronization中，如下是该接口的声明：

    public interface TransactionSynchronization extends Flushable {
    
    // 在当前事务挂起时执行
    default void suspend() {
    }
    
    // 在当前事务重新加载时执行
    default void resume() {
    }
    
    // 在当前数据刷新到数据库时执行
    default void flush() {
    }
    
    // 在当前事务commit之前执行
    default void beforeCommit(boolean readOnly) {
    }
    
    // 在当前事务completion之前执行
    default void beforeCompletion() {
    }
    
    // 在当前事务commit之后实质性
    default void afterCommit() {
    }
    
    // 在当前事务completion之后执行
    default void afterCompletion(int status) {
    }
    }
    

很明显，这里的TransactionSynchronization接口只是抽象了一些行为，用于事务事件发生时触发，这些行为在Spring事务中提供了内在支持，即在相应的事务事件时，其会获取当前所有注册的TransactionSynchronization对象，然后调用其相应的方法。那么这里TransactionSynchronization对象的注册点对于我们了解事务事件触发有至关重要的作用了。这里我们首先回到事务标签的解析处，在前面讲解事务标签解析时，我们讲到Spring会注册一个TransactionalEventListenerFactory类型的bean到Spring容器中，这里关于标签的解析读者可以阅读本人前面的文章Spring事务用法示例与实现原理。这里注册的TransactionalEventListenerFactory实现了EventListenerFactory接口，这个接口的主要作用是先判断目标方法是否是某个监听器的类型，然后为目标方法生成一个监听器，其会在某个bean初始化之后由Spring调用其方法用于生成监听器。如下是该类的实现：

    public class TransactionalEventListenerFactory implements EventListenerFactory, Ordered {
    
    // 指定当前监听器的顺序
    private int order = 50;
    
    public void setOrder(int order) {
        this.order = order;
    }
    
    @Override
    public int getOrder() {
        return this.order;
    }
    
    
    // 指定目标方法是否是所支持的监听器的类型，这里的判断逻辑就是如果目标方法上包含有
    // TransactionalEventListener注解，则说明其是一个事务事件监听器
    @Override
    public boolean supportsMethod(Method method) {
        return (AnnotationUtils.findAnnotation(method, TransactionalEventListener.class) != null);
    }
    
    // 为目标方法生成一个事务事件监听器，这里ApplicationListenerMethodTransactionalAdapter实现了
    // ApplicationEvent接口
    @Override
    public ApplicationListener<?> createApplicationListener(String beanName, Class<?> type, Method method) {
        return new ApplicationListenerMethodTransactionalAdapter(beanName, type, method);
    }
    
    }
    

这里关于事务事件监听的逻辑其实已经比较清楚了。ApplicationListenerMethodTransactionalAdapter本质上是实现了ApplicationListener接口的，也就是说，其是Spring的一个事件监听器，这也就是为什么进行事务处理时需要使用ApplicationEventPublisher.publish()方法发布一下当前事务的事件。

ApplicationListenerMethodTransactionalAdapter在监听到发布的事件之后会生成一个TransactionSynchronization对象，并且将该对象注册到当前事务逻辑中，如下是监听事务事件的处理逻辑：

    @Override
     public void onApplicationEvent(ApplicationEvent event) {
    // 如果当前TransactionManager已经配置开启事务事件监听，
    // 此时才会注册TransactionSynchronization对象
    if (TransactionSynchronizationManager.isSynchronizationActive()) {
        // 通过当前事务事件发布的参数，创建一个TransactionSynchronization对象
        TransactionSynchronization transactionSynchronization = 
            createTransactionSynchronization(event);
        // 注册TransactionSynchronization对象到TransactionManager中
        TransactionSynchronizationManager
            .registerSynchronization(transactionSynchronization);
    } else if (this.annotation.fallbackExecution()) {
        // 如果当前TransactionManager没有开启事务事件处理，但是当前事务监听方法中配置了
        // fallbackExecution属性为true，说明其需要对当前事务事件进行监听，无论其是否有事务
        if (this.annotation.phase() == TransactionPhase.AFTER_ROLLBACK 
            && logger.isWarnEnabled()) {
            logger.warn("Processing " 
                        + event + " as a fallback execution on AFTER_ROLLBACK phase");
        }
        processEvent(event);
    } else {
        // 走到这里说明当前是不需要事务事件处理的，因而直接略过
        if (logger.isDebugEnabled()) {
            logger.debug("No transaction is active - skipping " + event);
        }
    }
    }
    

这里需要说明的是，上述annotation属性就是在事务监听方法上解析的TransactionalEventListener注解中配置的属性。可以看到，对于事务事件的处理，这里创建了一个TransactionSynchronization对象，其实主要的处理逻辑就是在返回的这个对象中，而createTransactionSynchronization()方法内部只是创建了一个TransactionSynchronizationEventAdapter对象就返回了。这里我们直接看该对象的源码：

    private static class TransactionSynchronizationEventAdapter 
        extends TransactionSynchronizationAdapter {
    
        private final ApplicationListenerMethodAdapter listener;
        private final ApplicationEvent event;
        private final TransactionPhase phase;
    
    public TransactionSynchronizationEventAdapter(ApplicationListenerMethodAdapter 
        listener, ApplicationEvent event, TransactionPhase phase) {
        this.listener = listener;
        this.event = event;
        this.phase = phase;
    }
    
    @Override
    public int getOrder() {
        return this.listener.getOrder();
    }
    
    // 在目标方法配置的phase属性为BEFORE_COMMIT时，处理before commit事件
    public void beforeCommit(boolean readOnly) {
        if (this.phase == TransactionPhase.BEFORE_COMMIT) {
            processEvent();
        }
    }
    
    // 这里对于after completion事件的处理，虽然分为了三个if分支，但是实际上都是执行的processEvent()
    // 方法，因为after completion事件是事务事件中一定会执行的，因而这里对于commit，
    // rollback和completion事件都在当前方法中处理也是没问题的
    public void afterCompletion(int status) {
        if (this.phase == TransactionPhase.AFTER_COMMIT && status == STATUS_COMMITTED) {
            processEvent();
        } else if (this.phase == TransactionPhase.AFTER_ROLLBACK 
                   && status == STATUS_ROLLED_BACK) {
            processEvent();
        } else if (this.phase == TransactionPhase.AFTER_COMPLETION) {
            processEvent();
        }
    }
    
    // 执行事务事件
    protected void processEvent() {
        this.listener.processEvent(this.event);
    }
    }
    

可以看到，对于事务事件的处理，最终都是委托给了ApplicationListenerMethodAdapter.processEvent()方法进行的。如下是该方法的源码：

     public void processEvent(ApplicationEvent event) {
    // 处理事务事件的相关参数，这里主要是判断TransactionalEventListener注解中是否配置了value
    // 或classes属性，如果配置了，则将方法参数转换为该指定类型传给监听的方法；如果没有配置，则判断
    // 目标方法是ApplicationEvent类型还是PayloadApplicationEvent类型，是则转换为该类型传入
    Object[] args = resolveArguments(event);
    // 这里主要是获取TransactionalEventListener注解中的condition属性，然后通过
    // Spring expression language将其与目标类和方法进行匹配
    if (shouldHandle(event, args)) {
        // 通过处理得到的参数借助于反射调用事务监听方法
        Object result = doInvoke(args);
        if (result != null) {
            // 对方法的返回值进行处理
            handleResult(result);
        } else {
            logger.trace("No result object given - no result to handle");
        }
    }
     }
    
     // 处理事务监听方法的参数
    protected Object[] resolveArguments(ApplicationEvent event) {
    // 获取发布事务事件时传入的参数类型
    ResolvableType declaredEventType = getResolvableType(event);
    if (declaredEventType == null) {
        return null;
    }
    
    // 如果事务监听方法的参数个数为0，则直接返回
    if (this.method.getParameterCount() == 0) {
        return new Object[0];
    }
    
    // 如果事务监听方法的参数不为ApplicationEvent或PayloadApplicationEvent，则直接将发布事务
    // 事件时传入的参数当做事务监听方法的参数传入。从这里可以看出，如果事务监听方法的参数不是
    // ApplicationEvent或PayloadApplicationEvent类型，那么其参数必须只能有一个，并且这个
    // 参数必须与发布事务事件时传入的参数一致
    Class<?> eventClass = declaredEventType.getRawClass();
    if ((eventClass == null || !ApplicationEvent.class.isAssignableFrom(eventClass)) &&
        event instanceof PayloadApplicationEvent) {
        return new Object[] {((PayloadApplicationEvent) event).getPayload()};
    } else {
        // 如果参数类型为ApplicationEvent或PayloadApplicationEvent，则直接将其传入事务事件方法
        return new Object[] {event};
    }
     }
    
     // 判断事务事件方法方法是否需要进行事务事件处理
    private boolean shouldHandle(ApplicationEvent event, @Nullable Object[] args) {
    if (args == null) {
        return false;
    }
    String condition = getCondition();
    if (StringUtils.hasText(condition)) {
        Assert.notNull(this.evaluator, "EventExpressionEvaluator must no be null");
        EvaluationContext evaluationContext = this.evaluator.createEvaluationContext(
            event, this.targetClass, this.method, args, this.applicationContext);
        return this.evaluator.condition(condition, this.methodKey, evaluationContext);
    }
    return true;
     }
    
     // 对事务事件方法的返回值进行处理，这里的处理方式主要是将其作为一个事件继续发布出去，这样就可以在
    // 一个统一的位置对事务事件的返回值进行处理
    protected void handleResult(Object result) {
    // 如果返回值是数组类型，则对数组元素一个一个进行发布
    if (result.getClass().isArray()) {
        Object[] events = ObjectUtils.toObjectArray(result);
        for (Object event : events) {
            publishEvent(event);
        }
    } else if (result instanceof Collection<?>) {
        // 如果返回值是集合类型，则对集合进行遍历，并且发布集合中的每个元素
        Collection<?> events = (Collection<?>) result;
        for (Object event : events) {
            publishEvent(event);
        }
    } else {
        // 如果返回值是一个对象，则直接将其进行发布
        publishEvent(result);
    }
    }
    

## 六、总结

对于事务事件的处理，总结而言，就是为每个事务事件监听方法创建了一个TransactionSynchronizationEventAdapter对象，通过该对象在发布事务事件的时候，会在当前线程中注册该对象，这样就可以保证每个线程每个监听器中只会对应一个TransactionSynchronizationEventAdapter对象。在Spring进行事务事件的时候会调用该对象对应的监听方法，从而达到对事务事件进行监听的目的。

    Created at: 2021-01-13T13:57:36+08:00
    Updated at: 2021-01-13T13:57:36+08:00

