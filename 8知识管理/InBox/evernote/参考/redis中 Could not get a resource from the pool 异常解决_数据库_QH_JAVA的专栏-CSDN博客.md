
![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.svg]]![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.1.svg]]![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.2.svg]]

# redis中 Could not get a resource from the pool 异常解决

原创 [QH\_JAVA](https://me.csdn.net/QH_JAVA) 最后发布于2017-01-22 18:35:47 阅读数 103229  

在项目中使用redis做缓存，当运行一段时间后就会出现如下错误：Could not get a resource from the pool，然后在看具体的异常信息就是JedisPool中获取不到jedis对象，也就是说连接池中没有可用的jedis。

自己的第一反应就是把最大链接数（setMaxTotal）调大一些，刚开始设置了100、后来200、在后来2000都不行

然后上网一搜发现大家的回答也都是修改最大连接数，如下demo就是网上一篇博客的解释：

1、产生原因：客户端去redis服务器拿连接（代码描述的是租用对象borrowObject）的时候，池中无可用连接，即池中所有连接被占用，且在等待时候设定的超时时间后还没拿到时，报出此异常。
2、解决办法：调整JedisPoolConfig中maxActive为适合自己系统的阀值。

    1<bean id="dataJedisPoolConfig" class="redis.clients.jedis.JedisPoolConfig">2        [color=red]<property name="maxActive" value="5000"/>[/color]3        <property name="maxIdle" value="5000"/>4        <property name="maxWait" value="10000"/>5        <property name="testOnBorrow" value="true"/>6</bean>

但这个自己也设置了，配置如下：

    1#最大活动对象数     2redis.pool.maxTotal=1000    3#最大能够保持idel状态的对象数      4redis.pool.maxIdle=100  5#最小能够保持idel状态的对象数   6redis.pool.minIdle=50    7#当池内没有返回对象时，最大等待时间    8redis.pool.maxWaitMillis=10000    9#当调用borrow Object方法时，是否进行有效性检查    10redis.pool.testOnBorrow=true    11#当调用return Object方法时，是否进行有效性检查    12redis.pool.testOnReturn=true  13#“空闲链接”检测线程，检测的周期，毫秒数。如果为负值，表示不运行“检测线程”。默认为-1.  14redis.pool.timeBetweenEvictionRunsMillis=30000  15#向调用者输出“链接”对象时，是否检测它的空闲超时；  16redis.pool.testWhileIdle=true  17# 对于“空闲链接”检测线程而言，每次检测的链接资源的个数。默认为3.  18redis.pool.numTestsPerEvictionRun=50  19#表示一个对象至少停留在idle状态的最短时间，然后才能被idle object evitor扫描并驱逐；这一项只有在timeBetweenEvictionRunsMillis大于0时才有意义20MinEvictableIdleTimeMillis=6000021#redis服务器的IP    22redis.ip=xxxxxx  23#redis服务器的Port    24redis1.port=6379   

但是这样设置后，当运行一段时候后还是会报同样的错误，说句不爱听的话最大链接数“1000”这个值真的不小，但还是错误，所以肯定不是这个值的原因。

后来在网上找到了一篇文章，文章中的jedis工具类中有三个方法，代码如下：

    1public class JedisUtils {2	private static Log logger = LogFactory.getLog(JedisUtils.class);3 4	/**5	 * 自动注入Redis连接实例对象线程池6	 */7	@Autowired8	private JedisPool jedisPool;9 10	/**11	 * 获取Jedis对象12	 * 13	 * @return14	 */15	public synchronized Jedis getJedis() {16		Jedis jedis = null;17		if (jedisPool != null) {18			try {19				if (jedis == null) {20					jedis = jedisPool.getResource();21				}22			} catch (Exception e) {23				logger.error(e.getMessage(), e);24			}25		}26		return jedis;27	}28 29	/**30	 * 回收Jedis对象资源31	 * 32	 * @param jedis33	 */34	public synchronized void returnResource(Jedis jedis) {35		if (jedis != null) {36			jedisPool.returnResource(jedis);37		}38	}39 40	/**41	 * Jedis对象出异常的时候，回收Jedis对象资源42	 * 43	 * @param jedis44	 */45	public synchronized void returnBrokenResource(Jedis jedis) {46		if (jedis != null) {47			jedisPool.returnBrokenResource(jedis);48		}49 50	}51}

有两个回收方法发现没，一个是正常结束时调用释放jedis资源而另一个是在出现异常时调用释放jedis资源。

业务类、方法代码如下：

    1  Jedis jedis = jedisUtils.getJedis();  2        if(jedis == null){  3            throw new NullPointerException("Jedis is Null");  4        }  5        try{  6            long queueCurrValue = jedis.llen(messageQueueName);  7            if(queueCurrValue >= queueMaxSize){  8                return addFlag;  9            }  10            String serizlizetValue = JSON.toJSONString(message);  11            if(StringUtils.isNotBlank(serizlizetValue)){  12                long queueLength = jedis.lpush(messageQueueName, serizlizetValue);  13                 if(queueLength - queueCurrValue > 0){  14                    addFlag = true;  15                }  16            }  17        }catch(Exception e){  18            jedisUtils.returnBrokenResource(jedis);  19            logger.error(e.getMessage(), e);  20        }finally{  21            jedisUtils.returnResource(jedis);  22        }  

看到没在finally{} 代码块和 catch（）{} 异常中都调用了相关方法，来释放jedis资源，这样就不会出现之前的那种异常了，当然最大链接数也不用设置那么大，下面看看修改后的配置文件

    1#最大链接数2MaxTotal=1003#空闲时最大链接数4MaxIdle=205#空闲最小6MinIdle=87#链接最大等待时间 （毫秒）8MaxWaitMillis=10000

就这值，再也没出现获取不到资源的的异常，问题解决了，所以问题不是最大链接数小了，而是没有释放资源，所以不管你设置多大的值都会出现异常而且消耗了大量的资源。

单我在项目中使用的时候有如下问题：

    1        // 释放资源2	public synchronized void returnResource(Jedis jedis) {3		if (jedis != null) {4			pool.returnResource(jedis);5		}6	}7 8	// 出现异常释放资源9	public synchronized void returnBrokenResource(Jedis jedis) {10		if (jedis != null) {11			pool.returnBrokenResource(jedis);12		}13	}

两个方法returnResource(jedis)、 和returnBrokenResource(jedis) 都被画了横线即过时废弃了，而还不知替换方法所以有知道的请指教，先谢谢了！

相关文章推荐：

    http://www.codeweblog.com/redis%E6%9C%8D%E5%8A%A1%E5%99%A8%E6%90%AD%E5%BB%BA-%E9%85%8D%E7%BD%AE-%E5%8F%8Ajedis%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%9A%84%E4%BD%BF%E7%94%A8%E6%96%B9%E6%B3%95/

    http://www.codeweblog.com/jedis%E8%BF%9E%E6%8E%A5%E6%B1%A0%E9%85%8D%E7%BD%AE/

    http://www.codeweblog.com/jedis-returnresource%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9/

    http://fengguang0051.iteye.com/blog/2237171

不过其中的两篇文章也会比自己转载做笔记的……

*   [[# | ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.4.svg]]点赞 4]]
*   [[# | ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.5.svg]]收藏]]
*   [[# | ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.6.svg]]分享]]
*     

 [![[3_qh_java.jpeg]] ![[8.4.png]]](https://blog.csdn.net/QH_JAVA) 

[QH\_JAVA](https://blog.csdn.net/QH_JAVA)
发布了272 篇原创文章 · 获赞 333 · 访问量 208万+

[他的留言板](https://bbs.csdn.net/topics/395531002) 

[![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/1.png]]

 [[# | ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/anonymous-User-img.png]]]] 

*   [![[3_xueran_programmer.png]]](https://me.csdn.net/Xueran_programmer)
    
    [April\_star](https://me.csdn.net/Xueran_programmer)2年前jedis.close();
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.8.svg]]1
    

*   [![[3_sinat_38723491.gif]]](https://me.csdn.net/giszhangke)
    
    [giszhangke](https://me.csdn.net/giszhangke)2年前jedis.close();//释放资源
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.9.svg]]1
    

*   [![[3_titer1.jpeg]]](https://me.csdn.net/titer1)
    
    [titer1](https://me.csdn.net/titer1)10个月前3ks
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.10.svg]]
    

*   [![[3_sinat_38723491.gif]]](https://me.csdn.net/sinat_38723491)
    
    [稼禾](https://me.csdn.net/sinat_38723491)1年前根据java基础，finally是无论如何都执行的，请问在catch中返回连接的意义何在？
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.11.svg]]
    

*   [![[3_w690333243.png]]](https://me.csdn.net/w690333243)
    
    [王人冉](https://me.csdn.net/w690333243)1年前博主，有个问题请教下。每次使用完都需要关闭吗？JedisUtils 是单利模式， 如果2个地方同时使用了，一个地方进行关闭，一个地方还在使用，这样不就造成问题了吗？
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.12.svg]]
    

*   [![[3_sinat_38723491.gif]]](https://me.csdn.net/q545314690)
    
    [q545314690](https://me.csdn.net/q545314690)1年前两个方法returnResource(jedis)、 和returnBrokenResource(jedis) 都被画了横线即过时废弃了，用close方法替换， finally { if(jedis != null){ jedis.close(); } }
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.13.svg]]
    

*   [![[3_wsliym.jpeg]]](https://me.csdn.net/wsliym)
    
    [蓝色-石头](https://me.csdn.net/wsliym)2年前/\*\* \* @deprecated starting from Jedis 3.0 this method will not be exposed. Resource cleanup should be \* done using @see {@link redis.clients.jedis.Jedis#close()} \*/ 这是官方源码的注释，看一眼就知道了
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.14.svg]]
    

*   [![[3_qqxyy99.png]]](https://me.csdn.net/qqxyy99)
    
    [杜.](https://me.csdn.net/qqxyy99)2年前redis使用还不是太熟悉 感谢分享
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.15.svg]]
    

*   [![[3_leiren431.png]]](https://me.csdn.net/leiren431)
    
    [leiren431](https://me.csdn.net/leiren431)2年前最好在初始化jedispool的时候，换一个构造方法，像这样jedisPool = new JedisPool(config, IP, 6379,10000,"密码");
    ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.16.svg]]
    

登录 查看 9 条热评![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/embedded.17.svg]]

#### [_Redis_一个_异常_的_解决_办法，_异常_描述：_Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/liyonghui123/article/details/84683018)

 [ Redis一个异常的解决办法，异常描述：Could not get a resource from the pool  redis.clients.jedis.exceptions.Jedi...](https://blog.csdn.net/liyonghui123/article/details/84683018) 博文 [来自： liyonghui123的专栏](https://blog.csdn.net/liyonghui123)

#### [_Redis_：_Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/u010286334/article/details/70855078)

[项目运行开始几分钟还正常运行，之后就会一直显示 Could not get a resource from the pool好了很多资料也没有解决办法，最后猜测是不是所有的连接使用一个全局jedis，...](https://blog.csdn.net/u010286334/article/details/70855078) 博文 [来自： 我是谁](https://blog.csdn.net/u010286334)

#### [SpringBoot 客户端报 _Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/qq_42648507/article/details/82381106)

[Spring框架（SpringBoot）中客户端报Could not get a resource from the pool（无法从池中获取资源）与配置无关前几天才开始做微信小程序的开发，而且还是二...](https://blog.csdn.net/qq_42648507/article/details/82381106) 博文 [来自： qq\_42648507的博客](https://blog.csdn.net/qq_42648507)

#### [_redis_使用_中_经常出现 _Could_ not get _a_ _resource_ from the _pool_ _异常_，_解决_办法总结](https://blog.csdn.net/ejiao1233/article/details/84342539)

[背景：最近使用jedis（redis）开发一项功能，查阅日志发现，服务运行一段时间之后，就会出现redis.clients.jedis.exceptions.JedisException:Couldn...](https://blog.csdn.net/ejiao1233/article/details/84342539) 博文 [来自： the blog of alunSemiconductor](https://blog.csdn.net/ejiao1233)

[![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/1.png]]

#### [_redis_ JedisConnectionException: _Could_ not get _a_ _resource_ from the _pool_ 的可能的原因](https://blog.csdn.net/qq_37606901/article/details/89682796)

[之前搭建好了redis,但是在在进行测试的时候出现了错误，原来是我的马虎造成的。不废话，直接上：报错提示：redis JedisConnectionException: Could not get a...](https://blog.csdn.net/qq_37606901/article/details/89682796) 博文 [来自： 不怕万人阻挡，只怕自己投降](https://blog.csdn.net/qq_37606901)

#### [_redis_.clients.jedis.exceptions.JedisConnectionException: _Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/qq_41055045/article/details/101219242)

[错误如下redis.clients.jedis.exceptions.JedisConnectionException: Could not get a resource from the pool ...](https://blog.csdn.net/qq_41055045/article/details/101219242) 博文 [来自： 神韵499](https://blog.csdn.net/qq_41055045)

#### [_Redis_ _Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/Andy86869/article/details/87949819)

[之前发生过这个情况，怎么解决的忘记了，今天在本地连接远程阿里云服务器的时候，Jedis 客户端又出现这个情况了排查了Redis 服务端已启动redis-cli 进入也正常。redis 相关配置也正常t...](https://blog.csdn.net/Andy86869/article/details/87949819) 博文 [来自： Andy86869的博客](https://blog.csdn.net/Andy86869)

#### [_Could_ not get _a_ _resource_ from the _pool_ 错误之_Redis_密码没设置和 ERR Client sent _A_UTH, but no p_a_ssword is set](https://blog.csdn.net/weixin_42636552/article/details/94554777)

[Redis正常启动，但是启动Tomcat之后会报Redis错误----JedisConnectionException: Could not get a resource from the pool所...](https://blog.csdn.net/weixin_42636552/article/details/94554777) 博文 [来自： 默默的笔记](https://blog.csdn.net/weixin_42636552)

#### [另一种reids的_Could_ not get _a_ _resource_ from the _pool_原因](https://blog.csdn.net/iteye_5062/article/details/82609736)

[转载请标明出处：http://blackwing.iteye.com/blog/2158799由于sentinel redis集群是搭建在组内的服务器，而某个应用需要从其他组的storm集群访问sen...](https://blog.csdn.net/iteye_5062/article/details/82609736) 博文 [来自： BlackWing](https://blog.csdn.net/iteye_5062)

#### [_redis__中_ _Could_ not get _a_ _resource_ from the _pool_ _异常__解决_](https://blog.csdn.net/dragonpeng2008/article/details/82424243)
#### [..._Could_ not get _a_ _resource_ from the _pool_ _异常_,_解决_...\_CSDN博客](https://blog.csdn.net/ejiao1233/article/details/84342539)

![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/1.png]]

#### [_解决__redis__中_ _Could_ not get _a_ _resource_ from the _pool_ _异常_](https://blog.csdn.net/qq_34103387/article/details/89494022)

[Couldnotgetaresourcefromthepool中文翻译：无法从池中获取资源导致：redis的缓存崩溃出现原因：1.最大链接数量超标，2.资源未回收解决1方式：调大你的缓存配置参数最小能...](https://blog.csdn.net/qq_34103387/article/details/89494022) 博文 [来自： qq\_34103387的博客](https://blog.csdn.net/qq_34103387)

#### [_redis__中_ _Could_ not get _a_ _resource_ from the _pool_ _异常__解决_](https://blog.csdn.net/weixin_41574643/article/details/79928536)
#### [...描述:_Could_ not get _a_ _resource_ from the _pool_\_数据...\_CSDN博客](https://blog.csdn.net/freebird_lb/article/details/7460328)

#### [本地运行_redis_缓存的项目报错：_Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/kongbai953/article/details/82391466)

[错误信息：org.springframework.data.redis.RedisConnectionFailureException: Cannot get Jedis connection; ne...](https://blog.csdn.net/kongbai953/article/details/82391466) 博文 [来自： 枕上白书的博客](https://blog.csdn.net/kongbai953)

[![[3_sinat_38723491.gif]]](https://blog.csdn.net/liyonghui123)关注
##### [liyonghui123](https://blog.csdn.net/liyonghui123)

287篇文章

排名:千里之外

[![[3_sinat_38723491.gif]]](https://blog.csdn.net/u010286334)关注
##### [u010286334](https://blog.csdn.net/u010286334)

127篇文章

排名:千里之外

[![[3_qq_42648507.gif]]](https://blog.csdn.net/qq_42648507)关注
##### [唐大人丶](https://blog.csdn.net/qq_42648507)

2篇文章

排名:千里之外

[![[3_ejiao1233.png]]](https://blog.csdn.net/ejiao1233)关注
##### [alunSemiconductor](https://blog.csdn.net/ejiao1233)

36篇文章

排名:千里之外

#### [_redis__中_ _Could_ not get _a_ _resource_ from the _pool_ _异常_...\_CSDN博客](https://blog.csdn.net/qq_32440951/article/details/81160721)
#### [_解决__redis__中_ _Could_ not get _a_ _resource_ from the _pool_...\_CSDN博客](https://blog.csdn.net/qq_34103387/article/details/89494022)

#### [_redis_提示_Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/weixin_34255055/article/details/91940241)

[2019独角兽企业重金招聘Python工程师标准>>> ......](https://blog.csdn.net/weixin_34255055/article/details/91940241) 博文 [来自： weixin\_34255055的博客](https://blog.csdn.net/weixin_34255055)

#### [_Redis_报错 _Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/XIAOLONG31314/article/details/86223731)

[1.检查redis 是否是启动的 2.换一个redis 试试](https://blog.csdn.net/XIAOLONG31314/article/details/86223731) 博文 [来自： L的博客](https://blog.csdn.net/XIAOLONG31314)

#### [_redis__中_ _Could_ not get _a_ _resource_ from the _pool_ _异常_...\_CSDN博客](https://blog.csdn.net/weixin_41574643/article/details/79928494)
#### [...描述:_Could_ not get _a_ _resource_ from the _pool_ - xq...\_CSDN博客](https://blog.csdn.net/xqhrs232/article/details/82911262)

#### [_redis_ _Could_ not get _a_ _resource_ from the _pool_ 的问题](https://blog.csdn.net/queryById/article/details/86304930)

[在帮助运维搭建预生产的过程中，搭建完项目调试接口时报了redis的Could not get a resource from the pool的错误，特此记录。出现的原因是需要修改redis的远程配置...](https://blog.csdn.net/queryById/article/details/86304930) 博文 [来自： queryById的博客](https://blog.csdn.net/queryById)

[![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/1.png]]

#### [...描述:_Could_ not get _a_ _resource_ from the _pool_ - 绿...\_CSDN博客](https://blog.csdn.net/jobjava/article/details/12843311)
#### [...描述:_Could_ not get _a_ _resource_ from the _pool_ - 互...\_CSDN博客](https://blog.csdn.net/freebird_lb/article/details/7460328?utm_source=blogxgwz7)

#### [Jedis连接_Redis_报错： _Could_ not get _a_ _resource_ from the _pool_](https://blog.csdn.net/qq_39884410/article/details/101520426)

[Jedis连接Redis报错： Could not get a resource from the pool最近在网上copy了一份Redis工具类以及配置相关配置， junit一下报错Could n...](https://blog.csdn.net/qq_39884410/article/details/101520426) 博文 [来自： 小东的博客](https://blog.csdn.net/qq_39884410)

#### [大学四年自学走来，这些私藏的实用工具/学习网站我贡献出来了](https://blog.csdn.net/m0_37907797/article/details/102781027)

[大学四年，看课本是不可能一直看课本的了，对于学习，特别是自学，善于搜索网上的一些资源来辅助，还是非常有必要的，下面我就把这几年私藏的各种资源，网站贡献出来给你们。主要有：电子书搜索、实用工具、在线视频...](https://blog.csdn.net/m0_37907797/article/details/102781027) 博文 [来自： 帅地](https://blog.csdn.net/m0_37907797)

#### [在_中_国程序员是青春饭吗？](https://blog.csdn.net/harvic880925/article/details/102850436)

[今年，我也32了 ，为了不给大家误导，咨询了猎头、圈内好友，以及年过35岁的几位老程序员……舍了老脸去揭人家伤疤……希望能给大家以帮助，记得帮我点赞哦。目录：你以为的人生 一次又一次的伤害 猎头界的真...](https://blog.csdn.net/harvic880925/article/details/102850436) 博文 [来自： 启舰](https://blog.csdn.net/harvic880925)

#### [超全Python图像处理讲解（多图预警）](https://blog.csdn.net/ZackSock/article/details/103794134)

[文章目录Pillow模块讲解一、Image模块1.1 、打开图片和显示图片1.2、创建一个简单的图像1.3、图像混合（1）透明度混合（2）遮罩混合1.4、图像缩放（1）按像素缩放（2）按尺寸缩放1.5...](https://blog.csdn.net/ZackSock/article/details/103794134) 博文 [来自： ZackSock的博客](https://blog.csdn.net/ZackSock)

#### [为什么猝死的都是程序员，基本上不见产品经理猝死呢？](https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/103841693)

[相信大家时不时听到程序员猝死的消息，但是基本上听不到产品经理猝死的消息，这是为什么呢？我们先百度搜一下：程序员猝死，出现将近700多万条搜索结果：搜索一下：产品经理猝死，只有400万条的搜索结果，从搜...](https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/103841693) 博文 [来自： 曹银飞的专栏](https://blog.csdn.net/dfskhgalshgkajghljgh)

[![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/unknown_filename.png]]](http://mssp.baidu.com/)

[[# | ![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/unknown_filename.1.png]]]]

![[8知识管理/InBox/evernote/参考/_resources/redis中_Could_not_get_a_resource_from_the_pool_异常解决_数据库_QH_JAVA的专栏-CSDN博客.resources/1.png]]

#### [毕业5年，我问遍了身边的大佬，总结了他们的学习方法](https://blog.csdn.net/qq_35190492/article/details/103847147)

[我问了身边10个大佬，总结了他们的学习方法，原来成功都是有迹可循的。](https://blog.csdn.net/qq_35190492/article/details/103847147) 博文 [来自： 敖丙](https://blog.csdn.net/qq_35190492)

#### [推荐10个堪称神器的学习网站](https://blog.csdn.net/qing_gee/article/details/103869737)

[每天都会收到很多读者的私信，问我：“二哥，有什么推荐的学习网站吗？最近很浮躁，手头的一些网站都看烦了，想看看二哥这里有什么新鲜货。”今天一早做了个恶梦，梦到被老板辞退了。虽然说在我们公司，只有我辞退老...](https://blog.csdn.net/qing_gee/article/details/103869737) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [强烈推荐10本程序员必读的书](https://blog.csdn.net/qing_gee/article/details/104085756)

[很遗憾，这个春节注定是刻骨铭心的，新型冠状病毒让每个人的神经都是紧绷的。那些处在武汉的白衣天使们，尤其值得我们的尊敬。而我们这些窝在家里的程序员，能不外出就不外出，就是对社会做出的最大的贡献。有些读者...](https://blog.csdn.net/qing_gee/article/details/104085756) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [没有项目经验怎么办？](https://blog.csdn.net/zhongyangzhong/article/details/104120813)

[职场和学校最大的不同就是：你在学校，老师给一本书，然后你考试。如果没有通过，就要补考。你在职场，领导给你一个问题，然后你来解决。如果解决不了，就要滚蛋走人。为此，你需要每半年更新一次简历......](https://blog.csdn.net/zhongyangzhong/article/details/104120813) 博文 [来自： 微信公众号：猴子聊人物](https://blog.csdn.net/zhongyangzhong)

#### [为什么说程序员做外包没前途？](https://blog.csdn.net/kebi007/article/details/104164570)

[之前做过不到3个月的外包，2020的第一天就被释放了，2019年还剩1天，我从外包公司离职了。我就谈谈我个人的看法吧。首先我们定义一下什么是有前途 稳定的工作环境 不错的收入 能够在项目中不断...](https://blog.csdn.net/kebi007/article/details/104164570) 博文 [来自： dotNet全栈开发](https://blog.csdn.net/kebi007)

#### [B 站上有哪些很好的学习资源?](https://blog.csdn.net/JiuZhang_ninechapter/article/details/104197117)

[哇说起B站，在小九眼里就是宝藏般的存在，放年假宅在家时一天刷6、7个小时不在话下，更别提今年的跨年晚会，我简直是跪着看完的！！最早大家聚在在B站是为了追番，再后来我在上面刷欧美新歌和漂亮小姐姐的舞蹈视...](https://blog.csdn.net/JiuZhang_ninechapter/article/details/104197117) 博文 [来自： 九章算法的博客](https://blog.csdn.net/JiuZhang_ninechapter)

#### [拼多多面试问了数据库基础知识，今天分享出来](https://blog.csdn.net/qq_35190492/article/details/104203466)

[一个SQL在数据库是怎么执行的，你是否了解过了呢？](https://blog.csdn.net/qq_35190492/article/details/104203466) 博文 [来自： 敖丙](https://blog.csdn.net/qq_35190492)

#### [新来个技术总监，禁止我们使用Lombok！](https://blog.csdn.net/hollis_chuang/article/details/104259307)

[我有个学弟，在一家小型互联网公司做Java后端开发，最近他们公司新来了一个技术总监，这位技术总监对技术细节很看重，一来公司之后就推出了很多"政策"，比如定义了很多开发规范、日志规范、甚至是要求大家统一...](https://blog.csdn.net/hollis_chuang/article/details/104259307) 博文 [来自： HollisChuang's Blog](https://blog.csdn.net/hollis_chuang)

#### [字节跳动的技术架构](https://blog.csdn.net/Ture010Love/article/details/104272717)

[字节跳动创立于2012年3月，到目前仅4年时间。从十几个工程师开始研发，到上百人，再到200余人。产品线由内涵段子，到今日头条，今日特卖，今日电影等产品线。一、产品背景今日头条是为用户提供个性化资讯客...](https://blog.csdn.net/Ture010Love/article/details/104272717) 博文 [来自： 作一个独立连续的思考者](https://blog.csdn.net/Ture010Love)

#### [大学四年，因为知道这些开发工具，我成为别人眼_中_的大神](https://blog.csdn.net/qq_35190492/article/details/104313013)

[亲测全部都很好用，自己开发都离不开的软件，如果你是学生可以看看，提前熟悉起来。...](https://blog.csdn.net/qq_35190492/article/details/104313013) 博文 [来自： 敖丙](https://blog.csdn.net/qq_35190492)

#### [在三线城市工作爽吗？](https://blog.csdn.net/qing_gee/article/details/104323806)

[我是一名程序员，从正值青春年华的 24 岁回到三线城市洛阳工作，至今已经 6 年有余。一不小心又暴露了自己的实际年龄，但老读者都知道，我驻颜有术，上次去看房子，业务员肯定地说：“小哥肯定比我小，我今年...](https://blog.csdn.net/qing_gee/article/details/104323806) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [这些插件太强了，Chrome 必装！尤其程序员！](https://blog.csdn.net/qing_gee/article/details/104340125)

[推荐 10 款我自己珍藏的 Chrome 浏览器插件](https://blog.csdn.net/qing_gee/article/details/104340125) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [@程序员：GitHub这个项目快薅羊毛](https://blog.csdn.net/kebi007/article/details/104399183)

[今天下午在朋友圈看到很多人都在发github的羊毛，一时没明白是怎么回事。后来上百度搜索了一下，原来真有这回事，毕竟资源主义的羊毛不少啊，1000刀刷爆了朋友圈！不知道你们的朋友圈有没有看到类似的消息...](https://blog.csdn.net/kebi007/article/details/104399183) 博文 [来自： dotNet全栈开发](https://blog.csdn.net/kebi007)

#### [做了5年运维，靠着这份监控知识体系，我从3K变成了40K](https://blog.csdn.net/yuanziok/article/details/104424369)

[从来没讲过运维，因为我觉得运维这种东西不需要太多的知识面，然后我一个做了运维朋友告诉我大错特错，他就是从3K的运维一步步到40K的，甚至笑着说：我现在感觉自己什么都能做。既然讲，就讲最重要的吧。监控是...](https://blog.csdn.net/yuanziok/article/details/104424369) 博文 [来自： Leo的博客](https://blog.csdn.net/yuanziok)

#### [又一程序员删库跑路了](https://blog.csdn.net/loongggdroid/article/details/104509009)

[loonggg读完需要2分钟速读仅需 1 分钟今天刷爆朋友圈和微博的一个 IT 新闻，估计有很多朋友应该已经看到了。程序员删库跑路的事情又发生了，不是调侃，而是真实的事情。微盟官网发布公......](https://blog.csdn.net/loongggdroid/article/details/104509009) 博文 [来自： 非著名程序员](https://blog.csdn.net/loongggdroid)

#### [我以为我学懂了数据结构，直到看了这个导图才发现，我错了](https://blog.csdn.net/qq_38646470/article/details/104547401)

[数据结构与算法思维导图](https://blog.csdn.net/qq_38646470/article/details/104547401) 博文 [来自： 龙跃十二](https://blog.csdn.net/qq_38646470)

#### [String s = new String(" _a_ ") 到底产生几个对象？](https://blog.csdn.net/qq_44543508/article/details/104560346)

[老生常谈的一个梗，到2020了还在争论，你们一天天的，哎哎哎，我不是针对你一个，我是说在座的各位都是人才！上图红色的这3个箭头，对于通过new产生一个字符串（”宜春”）时，会先去常量池中查找是否已经有...](https://blog.csdn.net/qq_44543508/article/details/104560346) 博文 [来自： 宜春](https://blog.csdn.net/qq_44543508)

#### [技术大佬：我去，你写的 switch 语句也太老土了吧](https://blog.csdn.net/qing_gee/article/details/104586826)

[昨天早上通过远程的方式 review 了两名新来同事的代码，大部分代码都写得很漂亮，严谨的同时注释也很到位，这令我非常满意。但当我看到他们当中有一个人写的 switch 语句时，还是忍不住破口大骂：“...](https://blog.csdn.net/qing_gee/article/details/104586826) 博文 [来自： 沉默王二](https://blog.csdn.net/qing_gee)

#### [学生宿舍管理系统](https://blog.csdn.net/zhangchen124/article/details/104587038)

[视频：https://edu.csdn.net/course/detail/27107正普数字化校园宿舍管理系统是为学校宿管科老师方便管理学生住宿情况设计的信息管理系统，通过宿舍管理系统可实时掌握学校...](https://blog.csdn.net/zhangchen124/article/details/104587038) 博文 [来自： 张晨光老师的播客](https://blog.csdn.net/zhangchen124)

#### [和黑客斗争的 6 天！](https://blog.csdn.net/ityouknow/article/details/104666810)

[互联网公司工作，很难避免不和黑客们打交道，我呆过的两家互联网公司，几乎每月每天每分钟都有黑客在公司网站上扫描。有的是寻找 Sql 注入的缺口，有的是寻找线上服务器可能存在的漏洞，大部分都......](https://blog.csdn.net/ityouknow/article/details/104666810) 博文 [来自： 纯洁的微笑](https://blog.csdn.net/ityouknow)

#### [J_a_v_a_基础知识面试题（2020最新版）](https://blog.csdn.net/ThinkWon/article/details/104390612)

[文章目录Java概述何为编程什么是Javajdk1.5之后的三大版本JVM、JRE和JDK的关系什么是跨平台性？原理是什么Java语言有哪些特点什么是字节码？采用字节码的最大好处是什么什么是Java程...](https://blog.csdn.net/ThinkWon/article/details/104390612) 博文 [来自： ThinkWon的博客](https://blog.csdn.net/ThinkWon)

[Java](https://java.csdn.net/) [C语言](https://c1.csdn.net/) [Python](https://python.csdn.net/) [C++](https://cplus.csdn.net/) [C#](https://csharp.csdn.net/) [Visual Basic .NET](https://vbn.csdn.net/) [JavaScript](https://js.csdn.net/) [PHP](https://php.csdn.net/) [SQL](https://sql.csdn.net/) [Go语言](https://go.csdn.net/) [R语言](https://r.csdn.net/) [Assembly language](https://assembly.csdn.net/) [Swift](https://swift.csdn.net/) [Ruby](https://ruby.csdn.net/) [MATLAB](https://matlab.csdn.net/) [PL/SQL](https://plsql.csdn.net/) [Perl](https://perl.csdn.net/) [Visual Basic](https://vb.csdn.net/) [Objective-C](https://obj.csdn.net/) [Delphi/Object Pascal](https://delphi.csdn.net/) [Unity3D](https://www.csdn.net/unity/)

©️2019 CSDN 皮肤主题: 程序猿惹谁了 设计师: 上身试试

    Created at: 2020-04-21T19:18:10+08:00
    Updated at: 2020-04-21T19:18:10+08:00

