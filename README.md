# Shiro多项目权限集中管理平台

[TOC]

## 项目起源：
公司随着业务的增长，各业务进行水平扩展面临拆分；随着业务的拆分各种管理系统扑面而来，为了方便权限统一管理，不得不自己开发或使用分布式权限管理（Spring Security）。Spring Security依赖Spring和初级开发人员学习难度大，中小型公司不推荐使用；Apache Shiro是一个强大易用的安全框架，Shiro的API方便理解。经过网上各路大神对shiro与spring security的比较，最终决定使用shiro开发一个独立的权限管理平台。

该项目是在张开涛跟我学shiro Demo基础上进行开发、功能完善和管理页面优化，欢迎fork、star及提出改进意见。

<iframe height=500 width=100% src="http://yzfile.oss-cn-beijing.aliyuncs.com/QQ20180818-212046-HD.mp4"></iframe>

## 公用模块：shiro-distributed-platform-common
#### 自定义注解-CurrentUser
通过注解获取当前登录用户
#### 请求拦截器-SysUserFilter
拦截所有请求
1.通过shiro Subject 获取当前用户的用户名 
2.通过用户名获取用户信息
3.将用户信息保存ServletRequest对象中
#### Spring方法拦截器参数绑定-CurrentUserMethodArgumentResolver
通过SpringAOP拦截容器内所有Java方法参数是否有CurrentUser注解，若果有注解标识从NativeWebRequest中获取user信息进行参数绑定
#### 认证拦截器-ServerFormAuthenticationFilter
shiro权限认证通过后进行页面跳转
## 公用接口：shiro-distributed-platform-api
### 权限系统核心API
##### AppService-应用API
##### AreaService-区域API
##### AuthorizationService-授权API
##### OrganizationService-组织结构API
##### ResourceService-资源API
##### RoleService-角色API
##### UserService-用户API
## 客户端：shiro-distributed-platform-client
#### 客户端认证拦截-ClientAuthenticationFilter
1.判断是否认证通过 若未认证进入下一步
2.从ServletRequest获取回调url
3.获取默认回调url（客户端IP和端口）
4.将默认回调url保存到session中
5.将第2步中的回调url保存到ClientSavedRequest中（方便server回调时返回到当前请求url）
5.当前请求重定向到server端登录页面
#### ClientRealm
ClientRealm继承自Shiro AuthorizingRealm
该类忽略doGetAuthenticationInfo方法实现，所有认证操作会转到Server端实现
#### 客户端Session管理-ClientSessionDAO
实时更新、获取远程session
#### 客户端shiro拦截器工厂管理类-ClientShiroFilterFactoryBean
添加两个方法setFiltersStr、setFilterChainDefinitionsStr，方便在properties文件中配置拦截器和定义过滤链
## 服务端：shiro-distributed-platform-server
#### 接口暴露
通过Spring HttpInvokerServiceExporter工具将shiro-distributed-platform-api模块部分API暴露（remoteService、userService、resourceService），请参考spring-mvc-export-service.xml配置文件

配置ShiroFilterFactoryBean filterChainDefinitions属性将以上三个接口权限设置为游客、匿名（anon），请参考spring-config-shiro.xml配置文件

## 客户端集成：
#### 配置shiro-client.properties

```
#各应用的appKey
client.app.key=1f38e90b-7c56-4c1d-b3a5-7b4b6ec94778
#远程服务URL地址
client.remote.service.url=http://127.0.0.1:8080 #根据实际应用地址配置
#登录地址
client.login.url=http://127.0.0.1:8080/login #根据实际应用地址配置
#登录成功后，默认重定向到的地址
client.success.url=/
#未授权重定向到的地址
client.unauthorized.url=http://127.0.0.1:8080/login #根据实际应用地址配置
#session id 域名
client.cookie.domain=
#session id 路径
client.cookie.path=/
#cookie中的session id名称
client.session.id=sid
#cookie中的remember me名称
client.rememberMe.id=rememberMe
```
<h5 style="color:red;">注意这里配置的客户端127.0.0.1 如果使用localhost访问将会出现跨域session丢失问题</h5>

#### spring-client-shiro.xml配置

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:util="http://www.springframework.org/schema/util"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
       http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util.xsd
       http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <!-- Realm实现 -->
    <bean id="remoteRealm" class="com.yz.shiro.client.ClientRealm">
        <property name="cachingEnabled" value="false"/>
        <property name="appKey" value="${client.app.key}"/>
        <property name="remoteService" ref="remoteService"/>
    </bean>

    <!-- 会话ID生成器 -->
    <bean id="clientSessionIdGenerator" class="org.apache.shiro.session.mgt.eis.JavaUuidSessionIdGenerator"/>

    <!-- 会话Cookie模板 -->
    <bean id="clientSessionIdCookie" class="org.apache.shiro.web.servlet.SimpleCookie">
        <constructor-arg value="${client.session.id}"/>
        <property name="httpOnly" value="true"/>
        <property name="maxAge" value="-1"/>
        <property name="domain" value="${client.cookie.domain}"/>
        <property name="path" value="${client.cookie.path}"/>
    </bean>

    <bean id="clientRememberMeCookie" class="org.apache.shiro.web.servlet.SimpleCookie">
        <constructor-arg value="${client.rememberMe.id}"/>
        <property name="httpOnly" value="true"/>
        <property name="maxAge" value="2592000"/><!-- 30天 -->
        <property name="domain" value="${client.cookie.domain}"/>
        <property name="path" value="${client.cookie.path}"/>
    </bean>

    <!-- rememberMe管理器 -->
    <bean id="ClientRememberMeManager" class="org.apache.shiro.web.mgt.CookieRememberMeManager">
        <!-- rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度（128 256 512 位）-->
        <property name="cipherKey"
                  value="#{T(org.apache.shiro.codec.Base64).decode('4AvVhmFLUs0KTA3Kprsdag==')}"/>
        <property name="cookie" ref="clientRememberMeCookie"/>
    </bean>

    <!-- 会话DAO -->
    <bean id="clientSessionDao" class="com.yz.shiro.client.ClientSessionDAO">
        <property name="sessionIdGenerator" ref="clientSessionIdGenerator"/>
        <property name="appKey" value="${client.app.key}"/>
        <property name="remoteService" ref="remoteService"/>
    </bean>

    <bean id="sessionFactory" class="com.yz.shiro.common.session.ShiroSessionFactory"/>

    <!-- 会话管理器 -->
    <bean id="clientSessionManager" class="com.yz.shiro.client.ClientWebSessionManager">
        <property name="deleteInvalidSessions" value="false"/>
        <property name="sessionValidationSchedulerEnabled" value="false"/>
        <property name="sessionDAO" ref="clientSessionDao"/>
        <property name="sessionIdCookieEnabled" value="true"/>
        <property name="sessionIdCookie" ref="clientSessionIdCookie"/>
        <property name="sessionFactory" ref="sessionFactory"/>
    </bean>

    <!-- 安全管理器 -->
    <bean id="clientSecurityManager" class="org.apache.shiro.web.mgt.DefaultWebSecurityManager">
        <property name="realm" ref="remoteRealm"/>
        <property name="sessionManager" ref="clientSessionManager"/>
        <property name="rememberMeManager" ref="ClientRememberMeManager"/>
    </bean>

    <!-- 相当于调用SecurityUtils.setSecurityManager(securityManager) -->
    <bean class="org.springframework.beans.factory.config.MethodInvokingFactoryBean">
        <property name="staticMethod" value="org.apache.shiro.SecurityUtils.setSecurityManager"/>
        <property name="arguments" ref="clientSecurityManager"/>
    </bean>

    <bean id="clientAuthenticationFilter" class="com.yz.shiro.client.ClientAuthenticationFilter"/>
    <bean id="sysUserFilter" class="com.yz.shiro.common.filter.SysUserFilter"/>

    <!-- Shiro的Web过滤器 -->
    <bean id="shiroFilter" class="com.yz.shiro.client.ClientShiroFilterFactoryBean">
        <property name="securityManager" ref="clientSecurityManager"/>
        <property name="loginUrl" value="${client.login.url}"/>
        <property name="successUrl" value="${client.success.url}"/>
        <property name="unauthorizedUrl" value="${client.unauthorized.url}"/>
        <property name="filters">
            <util:map>
                <entry key="authc" value-ref="clientAuthenticationFilter"/>
                <entry key="sysUser" value-ref="sysUserFilter"/>
            </util:map>
        </property>
        <property name="filterChainDefinitions">
            <value>
                /** = authc,sysUser
            </value>
        </property>
    </bean>

    <!-- Shiro生命周期处理器-->
    <bean id="lifecycleBeanPostProcessor" class="org.apache.shiro.spring.LifecycleBeanPostProcessor"/>

    <import resource="classpath:spring-client-remote-service.xml"/>
</beans>
```

#### web.xml 配置

```
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
         metadata-complete="true" version="3.0">

  <display-name>Archetype Created Web Application</display-name>

  <listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
  </listener>

  <context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath:ApplicationContext.xml</param-value>
  </context-param>

  <listener>
    <listener-class>org.springframework.web.context.request.RequestContextListener</listener-class>
  </listener>

  <listener>
    <listener-class>org.springframework.web.util.IntrospectorCleanupListener</listener-class>
  </listener>

  <!-- Shiro的filter必须放在其他filter之前 -->
  <filter>
    <filter-name>shiroFilter</filter-name>
    <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
    <init-param>
      <param-name>targetFilterLifecycle</param-name>
      <param-value>true</param-value>
    </init-param>
  </filter>
  <filter-mapping>
    <filter-name>shiroFilter</filter-name>
    <url-pattern>/*</url-pattern>
  </filter-mapping>

  <filter>
    <filter-name>CharacterEncoding</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <async-supported>true</async-supported>
    <init-param>
      <param-name>encoding</param-name>
      <param-value>UTF-8</param-value>
    </init-param>
    <init-param>
      <param-name>forceEncoding</param-name>
      <param-value>true</param-value>
    </init-param>
  </filter>

  <filter-mapping>
    <filter-name>CharacterEncoding</filter-name>
    <url-pattern>/*</url-pattern>
  </filter-mapping>

  <servlet>
    <servlet-name>springmvc</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
      <param-name>contextConfigLocation</param-name>
      <param-value>classpath:dispatcher-servlet.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
    <async-supported>true</async-supported>
  </servlet>

  <servlet-mapping>
    <servlet-name>springmvc</servlet-name>
    <url-pattern>/</url-pattern>
  </servlet-mapping>
</web-app>
```
QQ交流群:776296081
Email:yangzhao_java@163.com


