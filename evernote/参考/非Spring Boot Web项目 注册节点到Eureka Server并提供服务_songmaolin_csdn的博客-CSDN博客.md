
# 非Spring Boot Web项目 注册节点到Eureka Server并提供服务

![[./_resources/非Spring_Boot_Web项目_注册节点到Eureka_Server并提供服务_songmaolin_csdn的博客-CSDN博客.resources/original.png]]
[songmaolin\_csdn](https://blog.csdn.net/songmaolin_csdn) 2017-09-07 13:55:19 ![[./_resources/非Spring_Boot_Web项目_注册节点到Eureka_Server并提供服务_songmaolin_csdn的博客-CSDN博客.resources/articleReadEyes.png]] 11159  

		
分类专栏： [spring boot](https://blog.csdn.net/songmaolin_csdn/category_7082526.html)

最近公司项目架构改变，以前的springmvc架构模式，改成了spring cloud ，要把springmvc架构弄成spring boot实现由于项目紧急，目前把其中一个springmvc的项目注册到eureka上，后续在改成sping boot,那么关键点来了，如何才能把spingmvc的项目注册到eureka上呢，其实springboot项目注册到eureka上，用到了spring-cloud-starter-eureka

，也是对Netflix eureka的封装，那么我们就在我们的springmvc中用到这个eurekaclientok了，我们spring cloud 用到的eureka 是1.4.12 ，所以在springmvc项目中引用该版本的jar

pom文件（由于与spirngmvc的项目jar冲突 ，我们把其中2个jar拆除掉）

<dependency>
            <groupId>com.netflix.eureka</groupId>
            <artifactId>eureka-client</artifactId>
            <version>1.4.12</version>
            <exclusions>
                <exclusion>
                    <groupId>javax.servlet</groupId>
                    <artifactId>servlet-api</artifactId>
                </exclusion>
                <exclusion>
                    <groupId>org.apache.httpcomponents</groupId>
                       <artifactId>httpclient</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

java 代码

package lisener;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Date;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.netflix.appinfo.ApplicationInfoManager;
import com.netflix.appinfo.InstanceInfo;
import com.netflix.appinfo.InstanceInfo.InstanceStatus;
import com.netflix.appinfo.MyDataCenterInstanceConfig;
import com.netflix.config.DynamicPropertyFactory;
import com.netflix.discovery.DefaultEurekaClientConfig;
import com.netflix.discovery.DiscoveryManager;
/\*\*
 \*
 \*/
/\*\*
 \* @author dell
 \*
 \*/
public class SampleEurekaService implements ServletContextListener{
    private static final DynamicPropertyFactory configInstance = com.netflix.config.DynamicPropertyFactory
            .getInstance();
            private static final Logger logger = LoggerFactory
            .getLogger(SampleEurekaService.class);
            public void registerWithEureka() {
                // Register with Eureka
                DiscoveryManager.getInstance().initComponent(
                        new MyInstanceConfig(),
                        new DefaultEurekaClientConfig());
                ApplicationInfoManager.getInstance().setInstanceStatus(
                        InstanceStatus.UP);
                String vipAddress = configInstance.getStringProperty(
                        "eureka.vipAddress", "hmc-web.mydomain.net").get();
                InstanceInfo nextServerInfo = null;
                while (nextServerInfo == null) {
                    try {
                        nextServerInfo = DiscoveryManager.getInstance()
                        .getDiscoveryClient()
                        .getNextServerFromEureka(vipAddress, false);
                    } catch (Throwable e) {
                        System.out
                        .println("Waiting for service to register with eureka..");
                        try {
                            Thread.sleep(10000);
                        } catch (InterruptedException e1) {
                            // TODO Auto-generated catch block
                            e1.printStackTrace();
                        }
                    }
                }
                System.out.println("Service started and ready to process requests..");
//                try {
//                    ServerSocket serverSocket = new ServerSocket(configInstance
//                            .getIntProperty("eureka.port", 8010).get());
//                    final Socket s = serverSocket.accept();
//                    System.out
//                    .println("Client got connected..Processing request from the client");
//                    processRequest(s);
//
//
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//                this.unRegisterWithEureka();
//                System.out.println("Shutting down server.Demo over.");
            }
            public void unRegisterWithEureka() {
                // Un register from eureka.
                DiscoveryManager.getInstance().shutdownComponent();
            }
            private void processRequest(final Socket s) {
                try {
                    BufferedReader rd = new BufferedReader(new InputStreamReader(
                            s.getInputStream()));
                    String line = rd.readLine();
                    if (line != null) {
                        System.out.println("Received the request from the client.");
                    }
                    PrintStream out = new PrintStream(s.getOutputStream());
                    System.out.println("Sending the response to the client...");
                    out.println("Reponse at " + new Date());
                } catch (Throwable e) {
                    System.err.println("Error processing requests");
                } finally {
                    if (s != null) {
                        try {
                            s.close();
                        } catch (IOException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                }
            }
            public static void main(String args\[\]) {
                SampleEurekaService sampleEurekaService = new SampleEurekaService();
                sampleEurekaService.registerWithEureka();
            }
            /\* (non-Javadoc)
             \* @see javax.servlet.ServletContextListener#contextInitialized(javax.servlet.ServletContextEvent)
             \*/
            @Override
            public void contextInitialized(ServletContextEvent sce) {
                // TODO Auto-generated method stub
                registerWithEureka();
            }
            /\* (non-Javadoc)
             \* @see javax.servlet.ServletContextListener#contextDestroyed(javax.servlet.ServletContextEvent)
             \*/
            @Override
            public void contextDestroyed(ServletContextEvent sce) {
                // TODO Auto-generated method stub
                unRegisterWithEureka();
            }
}

/\*\*
 \*
 \*/
package lisener;
import java.net.InetAddress;
import java.net.UnknownHostException;
import com.netflix.appinfo.MyDataCenterInstanceConfig;
/\*\*
 \* @author dell  让注册到服务的名称是机器的ip ，非主机名
 \*
 \*/
public class MyInstanceConfig extends MyDataCenterInstanceConfig{
    @Override
    public String getHostName(boolean refresh) {
        try {
            return InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            return super.getHostName(refresh);
        }
    }
}

配置文件（只能叫config，eurekaclient只找这个文件名称）

###Eureka Client configuration for Sample Eureka Service
#Properties based configuration for eureka client. The properties specified here is mostly what the users
#need to change. All of these can be specified as a java system property with -D option (eg)-Deureka.region=us-east-1
#For additional tuning options refer <url to go here>
#部署应用程序的区域
\# - 对于AWS指定一个AWS区域
#  - 对于其他数据中心，指定一个指示该区域的任意字符串。
\# 这里主要指定美国东部D
eureka.region=default
#服务指定应用名，这里指的是eureka服务本身（相当于boot中的app.name）
eureka.name=hmc-web
#客户识别此服务的虚拟主机名，这里指的是eureka服务本身（相当于boot中的serviceId）
eureka.vipAddress=hmc-web.mydomain.net
#服务将被识别并将提供请求的端口（web服务部署的tomcat端口）
eureka.port=8080
#设置为false，因为该配置适用于eureka服务器本身的eureka客户端。
#在eureka服务器中运行的eureka客户端需要连接到其他区域中的服务器。
#对于其他应用程序，不应设置（默认为true），以实现更好的基于区域的负载平衡。
eureka.preferSameZone=true
#如果要使用基于DNS的查找来确定其他eureka服务器（请参见下面的示例），请更改此选项
eureka.shouldUseDns=false
eureka.us-east-1.availabilityZones=default
#由于shouldUseDns为false，因此我们使用以下属性来明确指定到eureka服务器的路由（eureka Server地址）
eureka.serviceUrl.default=http\\://localhost\\:1111/eureka/

web.xml 加上

<listener>
        <description>eureka监听器</description>
        <listener-class>lisener.SampleEurekaService</listener-class>
    </listener>

测试

localhost:1111(这个是spring cloud 的eureka注册项目)，在页面中可以看到我们的hmc-web（配置文件中指定）了。

    Created at: 2021-02-03T09:10:13+08:00
    Updated at: 2021-02-03T09:10:13+08:00

