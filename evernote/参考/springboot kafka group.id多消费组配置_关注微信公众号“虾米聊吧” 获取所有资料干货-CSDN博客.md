
# springboot kafka group.id多消费组配置

![[./_resources/springboot_kafka_group.id多消费组配置_关注微信公众号“虾米聊吧”_获取所有资料干货-CSDN博客.resources/original.png]]
[Garry1115](https://me.csdn.net/zwx19921215) 2018-10-24 11:37:56 ![[./_resources/springboot_kafka_group.id多消费组配置_关注微信公众号“虾米聊吧”_获取所有资料干货-CSDN博客.resources/articleReadEyes.png]] 18515  

		
分类专栏： [spring cloud](https://blog.csdn.net/zwx19921215/category_7558301.html) 文章标签： [springboot kafka group.id](https://so.csdn.net/so/search/s.do?q=springboot%20kafka%20group.id&t=blog&o=vip&s=&l=&f=&viparticle=) [多消费组](https://so.csdn.net/so/search/s.do?q=%E5%A4%9A%E6%B6%88%E8%B4%B9%E7%BB%84&t=blog&o=vip&s=&l=&f=&viparticle=)

很早之前就使用了springboot + kafka组合配置，但是之前使用的spring-kafka（1.1.7）版本较低，所以只能通过 spring.kafka.consumer.group-id=default\_consumer\_group 或者 propsMap.put(ConsumerConfig.GROUP\_ID\_CONFIG, "default\_consumer\_group");的形式配置一个默认消组，当然理论上这也是没有问题的，但是如果你定义的topic数量过多且并发消费比较大，只有一个消费组的配置方式就会暴露出很多问题，其中主要的一个问题便是每个topic分区的offset偏移量问题（在大并发下会出现offset异常问题），因为他们都保存在同一个消费组中。

直到后来发布了spring-kafka 1.3.x的版本后，增加了groupId的属性，非常方便的帮助我们解决了实现每个topic自定义一个消费组的问题，我们再也不用共用一个消费组了。

接下来通过代码演示看是否如我们的期望一样：

pom依赖

    1<parent>2		<groupId>org.springframework.boot</groupId>3		<artifactId>spring-boot-starter-parent</artifactId>4		<version>1.5.10.RELEASE</version>5		<relativePath/> <!-- lookup parent from repository -->6	</parent>7 8	<properties>9		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>10		<project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>11		<java.version>1.8</java.version>12	</properties>13 14	<dependencies>15		<dependency>16			<groupId>org.springframework.boot</groupId>17			<artifactId>spring-boot-starter-web</artifactId>18		</dependency>19		<!-- https://mvnrepository.com/artifact/org.springframework.kafka/spring-kafka -->20		<dependency>21			<groupId>org.springframework.kafka</groupId>22			<artifactId>spring-kafka</artifactId>23			<version>1.3.5.RELEASE</version>24		</dependency>25 26		<dependency>27			<groupId>org.springframework.boot</groupId>28			<artifactId>spring-boot-starter-test</artifactId>29			<scope>test</scope>30		</dependency>31 32		<!--引入elasticsearch-->33		<dependency>34			<groupId>org.springframework.boot</groupId>35			<artifactId>spring-boot-starter-data-elasticsearch</artifactId>36		</dependency>37	</dependencies>38 39	<build>40		<plugins>41			<plugin>42				<groupId>org.springframework.boot</groupId>43				<artifactId>spring-boot-maven-plugin</artifactId>44			</plugin>45		</plugins>46	</build>

application.properties

    1server.port=100872spring.application.name=example3#topic4spring.kafka.bootstrap-servers=10.0.2.22:90925kafka.test.topic=TEST_TOPIC6 7 8#es9spring.data.elasticsearch.cluster-name=elasticsearch10spring.data.elasticsearch.cluster-nodes=10.0.2.23:930011#spring.data.elasticsearch.cluster-nodes=10.0.2.22:9300

生产者：

    1/**2  * @author xiaofeng3  * @version V1.04  * @title: TestKafkaSender.java5  * @package: com.example.demo.kafka.sender6  * @description: kafka生产者7  * @date 2018/4/2 0002 下午 3:318  */9@Component10public class TestKafkaSender {11    @Autowired12    private KafkaTemplate kafkaTemplate;13 14    @Value("${kafka.test.topic}")15    String testTopic;16 17    public void sendTest(String msg){18        kafkaTemplate.send(testTopic, msg);19    }20}

消费者1：

    1/**2 * @author xiaofeng3 * @version V1.04 * @title: TestKafkaConsumer2.java5 * @package: com.example.demo.kafka.consumer6 * @description: kafka消费者7 * @date 2018/4/2 0002 下午 3:318 */9@Component10public class TestKafkaConsumer {11 12    Logger logger = LoggerFactory.getLogger(getClass());13 14    /**15     * topics: 配置消费topic，以数组的形式可以配置多个16     * groupId: 配置消费组为”xiaofeng1“17     *18     * @param message19     */20    @KafkaListener(topics = {"${kafka.test.topic}"},groupId = "xiaofeng1")21    public void consumer(String message) {22        logger.info("groupId = xiaofeng1, message = " + message);23    }24 25}

消费者2：

    1/**2 * @author xiaofeng3 * @version V1.04 * @title: TestKafkaConsumer2.java5 * @package: com.example.demo.kafka.consumer6 * @description: kafka消费者7 * @date 2018/4/2 0002 下午 3:318 */9@Component10public class TestKafkaConsumer2 {11 12    Logger logger = LoggerFactory.getLogger(getClass());13 14    /**15     * topics: 配置消费topic，以数组的形式可以配置多个16     * groupId: 配置消费组为”xiaofeng2“17     *18     * @param message19     */20    @KafkaListener(topics = {"${kafka.test.topic}"}, groupId = "xiaofeng2")21    public void consumer(String message) {22        logger.info("groupId = xiaofeng2, message = " + message);23    }24 25}

测试类：

    1 @Autowired2    TestKafkaSender sender;3 4    @Test5    public void send() {6        for (int i = 0; i < Integer.MAX_VALUE; i++) {7            logger.info("send message = " + i);8            sender.sendTest(i + "");9            try {10                Thread.sleep(1000);11            } catch (InterruptedException e) {12                e.printStackTrace();13            }14        }15    }

运行效果：

![[./_resources/springboot_kafka_group.id多消费组配置_关注微信公众号“虾米聊吧”_获取所有资料干货-CSDN博客.resources/70.png]]

    Created at: 2020-09-25T15:31:47+08:00
    Updated at: 2020-09-25T15:31:47+08:00

