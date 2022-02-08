
# mac中修改系统限制量--ulimit和sysctl

![[8知识管理/InBox/evernote/参考/_resources/mac中修改系统限制量--ulimit和sysctl_whereismatrix的专栏-CSDN博客.resources/original.png]]
[whereismatrix](https://me.csdn.net/whereismatrix) 2016-01-25 21:10:50 ![[8知识管理/InBox/evernote/参考/_resources/mac中修改系统限制量--ulimit和sysctl_whereismatrix的专栏-CSDN博客.resources/articleReadEyes.png]] 21597  

		
分类专栏： [mac](https://blog.csdn.net/whereismatrix/category_6042621.html) [内核配置变量](https://blog.csdn.net/whereismatrix/category_6081758.html) 文章标签： [mac](https://www.csdn.net/gather_2f/MtTaEg0sNTM1OTAtYmxvZwO0O0OO0O0O.html) [内核配置](https://www.csdn.net/gather_26/MtjaMg0sMDA0MzktYmxvZwO0O0OO0O0O.html)

![[8知识管理/InBox/evernote/参考/_resources/mac中修改系统限制量--ulimit和sysctl_whereismatrix的专栏-CSDN博客.resources/embedded.svg]]

在\*nux中，对于每个用户，系统限制其最大进程数、文件数……。为提高性能，可以根据设备资源情况，设置各用户的最大进程数，文件数等等
在mac中，要设置这些系统值，也使用这些命令。

可以用ulimit -a 来显示当前的各种用户进程限制。

    $ulimit -a
    core file size          (blocks, -c) 0
    data seg size           (kbytes, -d) unlimited
    file size               (blocks, -f) unlimited
    max locked memory       (kbytes, -l) unlimited
    max memory size         (kbytes, -m) unlimited
    open files                      (-n) 256
    pipe size            (512 bytes, -p) 1
    stack size              (kbytes, -s) 8192
    cpu time               (seconds, -t) unlimited
    max user processes              (-u) 709
    virtual memory          (kbytes, -v) unlimited
    
    $ ulimit -n 1000
    
    $ ulimit -a
    core file size          (blocks, -c) 0
    data seg size           (kbytes, -d) unlimited
    file size               (blocks, -f) unlimited
    max locked memory       (kbytes, -l) unlimited
    max memory size         (kbytes, -m) unlimited
    open files                      (-n) 1000
    pipe size            (512 bytes, -p) 1
    stack size              (kbytes, -s) 8192
    cpu time               (seconds, -t) unlimited
    max user processes              (-u) 709
    virtual memory          (kbytes, -v) unlimited
    
    $ 

在服务器类中，可能要对可以使用的socket端口等限制放大，修改其值

    $ ulimit -n 1000
    $

如果修改太大，并不一定成功。

    $ ulimit -n 100000
    -bash: ulimit: open files: cannot modify limit: Operation not permitted

这是，需要使用的命令是launchctl和sysctl

*   sysctl 命令：

    NAME
         sysctl -- get or set kernel state
    
    SYNOPSIS
         sysctl [-bdehiNnoqx] name[=value] ...
         sysctl [-bdehNnoqx] -a
    
    DESCRIPTION
         The sysctl utility retrieves kernel state and allows processes with appropriate privilege to set kernel
         state.  The state to be retrieved or set is described using a ``Management Information Base'' (``MIB'')
         style name, described as a dotted set of components.
    
         The following options are available:
    
         -A      Equivalent to -o -a (for compatibility).
    
         -a      List all the currently available non-opaque values.  This option is ignored if one or more variable
                 names are specified on the command line.
        ... ...          

可以尝试使用`sysctl -a` 来列出系统状态值，这是一个超长的列表。

*   launchctl 命令

    NAME
         launchctl -- Interfaces with launchd
    
    SYNOPSIS
         launchctl subcommand [arguments ...]
    
    DESCRIPTION
         launchctl interfaces with launchd to manage and inspect daemons, agents and XPC services.
    
    SUBCOMMANDS
         launchctl allows for detailed examination of launchd endpoints. A domain manages the execution policy for a
         collection of services.  A service may be thought of as a virtual process that is always available to be
         spawned in response to demand. Each service has a collection of endpoints, and sending a message to one of
         those endpoints will cause the service to launch on demand. Domains advertise these endpoints in a shared
         namespace and may be thought of as synonymous with Mach bootstrap subsets.
    
         Many subcommands in launchctl take a specifier which indicates the target domain or service for the subcom-
         mand. This specifier may take one of the following forms:
    
         system/[service-name]
                  Targets the system domain or a service within the system domain. The system domain manages the root
                  Mach bootstrap and is considered a privileged execution context. Anyone may read or query the sys-
                  tem domain, but root privileges are required to make modifications.
    
         user/<uid>/[service-name]
                  Targets the user domain for the given UID or a service within that domain. A user domain may exist
                  independently of a logged-in user. User domains do not exist on iOS.
    
         login/<asid>/[service-name]
                  Targets a user-login domain or service within that domain. A user-login domain is created when the
                  user logs in at the GUI and is identified by the audit session identifier associated with that
                  login. If a user domain has an associated login domain, the print subcommand will display the ASID
                  of that login domain. User-login domains do not exist on iOS.
    
         gui/<uid>/[service-name]
                  Another form of the login specifier. Rather than specifying a user-login domain by its ASID, this
                  specifier targets the domain based on which user it is associated with and is generally more conve-
                  nient.
    
                  Note: GUI domains and user domains share many resources. For the purposes of the Mach bootstrap
                  name lookups, they are "flat", so they share the same set of registered names. But they still have
                  discrete sets of services. So when printing the user domain's contents, you may see many Mach boot-
                  strap name registrations from services that exist in the GUI domain for that user, but you will not
                  see the services themselves in that list.
    
         session/<asid>/[service-name]
                  Targets the session domain for the given audit session ID or a service within that domain. For more
                  information about audit sessions, see auditon(2) and libbsm(3)
    
         pid/<pid>/[service-name]
                  Targets the domain for the given PID or a service within that domain. Each process on the system
                  will have a PID domain associated with it that consists of the XPC services visible to that process
                  which can be reached with xpc_connection_create(3).
         ... ... ... ... 

*   设置打开文件数

    $sudo launchctl limit maxfiles 100000 500000
    $sudo ulimit -n 100000

*   设置进程数

    $sudo launchctl limit maxproc 100000 100000
    $ launchctl limit 
        cpu         unlimited      unlimited      
        filesize    unlimited      unlimited      
        data        unlimited      unlimited      
        stack       8388608        67104768       
        core        0              unlimited      
        rss         unlimited      unlimited      
        memlock     unlimited      unlimited      
        maxproc     709            1064           
        maxfiles    100000         100000 
    
    $sysctl -a  | grep "files"
    kern.maxfiles: 100000
    kern.maxfilesperproc: 100000
    kern.num_files: 7622
    

要查看有哪些项是可以修改的，请使用命令`man 3 sysctl`,其列出了各种类型的配置变量，还有哪些是可以修改，哪些不可以修改。

    $sudo ulimit -u 1064

*   设置端口

    $sudo sysctl net.inet.ip.portrange.first=10000

要想支持更高数量的TCP并发连接的通讯处理程序，就必须修改系统对当前用户的进程同时打开的文件数量的软限制(soft limit)和硬限制(hardlimit)。其中软限制是指Linux在当前系统能够承受的告警范围内进一步限制用户同时打开的文件数，超过则会告警；硬限制则是根据系统硬件资源状况(主要是系统内存)计算出来的系统最多可同时打开的文件数量，超过则无法打开了。

查看网络的设置

    $ sysctl -a | grep "net.inet.ip"
    net.inet.ip.portrange.lowfirst: 1023
    net.inet.ip.portrange.lowlast: 600
    net.inet.ip.portrange.first: 49152
    net.inet.ip.portrange.last: 65535
    net.inet.ip.portrange.hifirst: 49152
    net.inet.ip.portrange.hilast: 65535
    net.inet.ip.forwarding: 0
    net.inet.ip.redirect: 1
    net.inet.ip.ttl: 64
    net.inet.ip.rtexpire: 2400
    net.inet.ip.rtminexpire: 10
    net.inet.ip.rtmaxcache: 128
    net.inet.ip.sourceroute: 0
    net.inet.ip.accept_sourceroute: 0
    net.inet.ip.gifttl: 30
    net.inet.ip.subnets_are_local: 0
    net.inet.ip.mcast.maxgrpsrc: 512
    net.inet.ip.mcast.maxsocksrc: 128
    net.inet.ip.mcast.loop: 1
    net.inet.ip.dummynet.hash_size: 64
    net.inet.ip.dummynet.curr_time: 0
    net.inet.ip.dummynet.ready_heap: 0
    net.inet.ip.dummynet.extract_heap: 0
    net.inet.ip.dummynet.searches: 0
    net.inet.ip.dummynet.search_steps: 0
    net.inet.ip.dummynet.expire: 1
    net.inet.ip.dummynet.max_chain_len: 16
    net.inet.ip.dummynet.red_lookup_depth: 256
    net.inet.ip.dummynet.red_avg_pkt_size: 512
    net.inet.ip.dummynet.red_max_pkt_size: 1500
    net.inet.ip.dummynet.debug: 0
    net.inet.ip.fw.enable: 1
    net.inet.ip.fw.autoinc_step: 100
    net.inet.ip.fw.one_pass: 0
    net.inet.ip.fw.debug: 0
    net.inet.ip.fw.verbose: 0
    net.inet.ip.fw.verbose_limit: 0
    net.inet.ip.fw.dyn_buckets: 256
    net.inet.ip.fw.curr_dyn_buckets: 256
    net.inet.ip.fw.dyn_count: 0
    net.inet.ip.fw.dyn_max: 4096
    net.inet.ip.fw.static_count: 1
    net.inet.ip.fw.dyn_ack_lifetime: 300
    net.inet.ip.fw.dyn_syn_lifetime: 20
    net.inet.ip.fw.dyn_fin_lifetime: 1
    net.inet.ip.fw.dyn_rst_lifetime: 1
    net.inet.ip.fw.dyn_udp_lifetime: 10
    net.inet.ip.fw.dyn_short_lifetime: 5
    net.inet.ip.fw.dyn_keepalive: 1
    net.inet.ip.random_id_statistics: 0
    net.inet.ip.random_id_collisions: 0
    net.inet.ip.random_id_total: 0
    net.inet.ip.sendsourcequench: 0
    net.inet.ip.maxfragpackets: 2048
    net.inet.ip.fragpackets: 0
    net.inet.ip.maxfragsperpacket: 128
    net.inet.ip.scopedroute: 1
    net.inet.ip.adj_clear_hwcksum: 0
    net.inet.ip.check_interface: 0
    net.inet.ip.rx_chaining: 1
    net.inet.ip.rx_chainsz: 6
    net.inet.ip.input_perf: 0
    net.inet.ip.input_perf_bins: 0
    net.inet.ip.linklocal.in.allowbadttl: 1
    net.inet.ip.random_id: 1
    net.inet.ip.maxchainsent: 11
    net.inet.ip.select_srcif_debug: 0
    net.inet.ip.output_perf: 0
    net.inet.ip.output_perf_bins: 0
    net.inet.ipsec.def_policy: 1
    net.inet.ipsec.esp_trans_deflev: 1
    net.inet.ipsec.esp_net_deflev: 1
    net.inet.ipsec.ah_trans_deflev: 1
    net.inet.ipsec.ah_net_deflev: 1
    net.inet.ipsec.ah_cleartos: 1
    net.inet.ipsec.ah_offsetmask: 0
    net.inet.ipsec.dfbit: 0
    net.inet.ipsec.ecn: 0
    net.inet.ipsec.debug: 0
    net.inet.ipsec.esp_randpad: -1
    net.inet.ipsec.bypass: 1
    net.inet.ipsec.esp_port: 4500

    Created at: 2020-09-25T14:24:31+08:00
    Updated at: 2020-09-25T14:24:31+08:00

