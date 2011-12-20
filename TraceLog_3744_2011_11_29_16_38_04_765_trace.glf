FILE_TYPE:DAAA96DE-B0FB-4c6e-AF7B-A445F5BF9BE2
ENCODING:UTF8
RECORD_SEPARATOR:30
COLUMN_SEPARATOR:124
ESC_CHARACTER:27
COLUMNS:Location|Guid|Time|Tzone|Importance|Severity|Exception|DeviceName|ProcessID|ThreadID|ThreadName|ScopeTag|MajorTick|MinorTick|MajorDepth|MinorDepth|RootName|RootID|CallerName|CallerID|CalleeName|CalleeID|ActionID|DSRRootContextID|DSRTransaction|DSRConnection|DSRCounter|User|ArchitectComponent|DeveloperComponent|Administrator|Unit|CSNComponent|Text
SEVERITY_MAP: |Information|W|Warning|E|Error|A|Assertion
HEADER_END
|694A53A8BD774C79B54FC73C9FC80E180|2011 11 29 16:38:04.765|+0800|>=|E| |TraceLog| 3744|  24|17225050@qtp-9619335-4| |0|0|0|0|-|-|-|-|-|-||||||||||com.businessobjects.rebean.wi.REException||REException message=Unable to instantiate ReportEngine. errorCode=RES 00001
com.businessobjects.rebean.wi.CommunicationException: Unable to instantiate ReportEngine.
	at com.businessobjects.rebean.wi.ReportEngines.createReportEngine(ReportEngines.java:290)
	at com.businessobjects.rebean.wi.ReportEngines.getService(ReportEngines.java:249)
	at com.itg.web.ctl.QueryController.getPrompts(QueryController.java:390)
	at com.itg.web.ctl.QueryController.index(QueryController.java:213)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
	at java.lang.reflect.Method.invoke(Method.java:597)
	at org.springframework.web.bind.annotation.support.HandlerMethodInvoker.doInvokeMethod(HandlerMethodInvoker.java:421)
	at org.springframework.web.bind.annotation.support.HandlerMethodInvoker.invokeHandlerMethod(HandlerMethodInvoker.java:136)
	at org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter.invokeHandlerMethod(AnnotationMethodHandlerAdapter.java:326)
	at org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter.handle(AnnotationMethodHandlerAdapter.java:313)
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:875)
	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:807)
	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:571)
	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:501)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:707)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:820)
	at org.mortbay.jetty.servlet.ServletHolder.handle(ServletHolder.java:511)
	at org.mortbay.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1166)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:96)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:76)
	at org.mortbay.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1157)
	at org.mortbay.jetty.servlet.ServletHandler.handle(ServletHandler.java:388)
	at org.mortbay.jetty.security.SecurityHandler.handle(SecurityHandler.java:216)
	at org.mortbay.jetty.servlet.SessionHandler.handle(SessionHandler.java:182)
	at org.mortbay.jetty.handler.ContextHandler.handle(ContextHandler.java:765)
	at org.mortbay.jetty.webapp.WebAppContext.handle(WebAppContext.java:418)
	at org.mortbay.jetty.handler.ContextHandlerCollection.handle(ContextHandlerCollection.java:230)
	at org.mortbay.jetty.handler.HandlerCollection.handle(HandlerCollection.java:114)
	at org.mortbay.jetty.handler.HandlerWrapper.handle(HandlerWrapper.java:152)
	at org.mortbay.jetty.Server.handle(Server.java:326)
	at org.mortbay.jetty.HttpConnection.handleRequest(HttpConnection.java:542)
	at org.mortbay.jetty.HttpConnection$RequestHandler.headerComplete(HttpConnection.java:923)
	at org.mortbay.jetty.HttpParser.parseNext(HttpParser.java:547)
	at org.mortbay.jetty.HttpParser.parseAvailable(HttpParser.java:212)
	at org.mortbay.jetty.HttpConnection.handle(HttpConnection.java:404)
	at org.mortbay.io.nio.SelectChannelEndPoint.run(SelectChannelEndPoint.java:409)
	at org.mortbay.thread.QueuedThreadPool$PoolThread.run(QueuedThreadPool.java:582)
Caused by: com.businessobjects.sdk.core.CoreException: findBundleConfigurator problem with URL: jar:file:/D:/workspace-sts/BOEFrame4/src/main/webapp/WEB-INF/lib/rebean.wi.jar!/META-INF/MANIFEST.MF
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.findBundleConfigurator(ManifestDiscoveryManager.java:172)
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.startDiscovery(ManifestDiscoveryManager.java:125)
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.<init>(ManifestDiscoveryManager.java:99)
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.<init>(ManifestDiscoveryManager.java:69)
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.<init>(ManifestDiscoveryManager.java:58)
	at com.businessobjects.sdk.core.Core.init(Core.java:118)
	at com.businessobjects.sdk.core.Core.checkInit(Core.java:156)
	at com.businessobjects.sdk.core.Core.create(Core.java:456)
	at com.businessobjects.rebean.wi.internal.ReportEngineFactory.makeOCCA(ReportEngineFactory.java:76)
	at com.businessobjects.rebean.wi.ReportEngines.createReportEngine(ReportEngines.java:281)
	... 38 more
Caused by: com.businessobjects.sdk.core.CoreException: Configurator problem with com.businessobjects.rebean.wi.impl.config.RebeanConfigurator: 
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.loadConfigurator(ManifestDiscoveryManager.java:278)
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.readConfigurator(ManifestDiscoveryManager.java:256)
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.readBundle(ManifestDiscoveryManager.java:210)
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.findBundleConfigurator(ManifestDiscoveryManager.java:143)
	... 47 more
Caused by: java.lang.NoClassDefFoundError: com/businessobjects/sdk/core/session/scheme/IScheme
	at com.businessobjects.rebean.wi.impl.config.RebeanConfigurator.<init>(RebeanConfigurator.java:37)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
	at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:39)
	at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:27)
	at java.lang.reflect.Constructor.newInstance(Constructor.java:513)
	at java.lang.Class.newInstance0(Class.java:355)
	at java.lang.Class.newInstance(Class.java:308)
	at com.businessobjects.sdk.core.internal.dynenv.impl.ManifestDiscoveryManager.loadConfigurator(ManifestDiscoveryManager.java:274)
	... 50 more
Caused by: java.lang.ClassNotFoundException: com.businessobjects.sdk.core.session.scheme.IScheme
	at java.net.URLClassLoader$1.run(URLClassLoader.java:202)
	at java.security.AccessController.doPrivileged(Native Method)
	at java.net.URLClassLoader.findClass(URLClassLoader.java:190)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:307)
	at org.codehaus.classworlds.RealmClassLoader.loadClassDirect(RealmClassLoader.java:195)
	at org.codehaus.classworlds.DefaultClassRealm.loadClass(DefaultClassRealm.java:255)
	at org.codehaus.classworlds.DefaultClassRealm.loadClass(DefaultClassRealm.java:274)
	at org.codehaus.classworlds.RealmClassLoader.loadClass(RealmClassLoader.java:214)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:248)
	at org.mortbay.jetty.webapp.WebAppClassLoader.loadClass(WebAppClassLoader.java:401)
	at org.mortbay.jetty.webapp.WebAppClassLoader.loadClass(WebAppClassLoader.java:363)
	... 58 more

