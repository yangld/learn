
使用spring data jpa 的删除操作，需要加注解**@Modifying     @Transactional** 否则报错如下： No EntityManager with actual transaction available for current thread - cannot reliably process 'remove' call

场景如下：

在service中，先执行 delete 操作，再执行 save操作

![[978388-20180503102729301-249635258.png]]

报错如下：

 No EntityManager with actual transaction available for current thread - cannot reliably process 'remove' call

在service层加上事务注解，依旧会报错，而且在执行的sql中可以看到仅执行insert语句，没有执行delete语句

说明delete操作并没有执行，所以在插入的时候，可能出现主键重复，唯一约束重复，报错的情况出现。

解决方法：

![[978388-20180503102936243-1371694846.png]]

**@Modifying**作用：

（1）可以通过自定义的 JPQL 完成 UPDATE 和 DELETE 操作。 注意： JPQL 不支持使用 INSERT； 
（2）在 @Query 注解中编写 JPQL 语句， 但必须使用 @Modifying 进行修饰. 以通知 SpringData， 这是一个 UPDATE 或 DELETE 操作 
（3）UPDATE 或 DELETE 操作需要使用事务，此时需要定义 Service 层，在 Service 层的方法上添加事务操作； 
（4）默认情况下， SpringData 的每个方法上有事务， 但都是一个只读事务。 他们不能完成修改操作。

    Created at: 2020-07-13T14:16:20+08:00
    Updated at: 2020-07-13T14:16:20+08:00

