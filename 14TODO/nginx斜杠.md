```
server {
   listen       80;
   server_name  localhost;

   location /api1/ {
           proxy_pass http://localhost:8080;
        }
   # http://localhost/api1/xxx -> http://localhost:8080/api1/xxx


   location /api2/ {
           proxy_pass http://localhost:8080/;
        }
   # http://localhost/api2/xxx -> http://localhost:8080/xxx


   location /api3 {
           proxy_pass http://localhost:8080;
        }
   # http://localhost/api3/xxx -> http://localhost:8080/api3/xxx


   location /api4 {
           proxy_pass http://localhost:8080/;
        }
   # http://localhost/api4/xxx -> http://localhost:8080//xxx，请注意这里的双斜线，好好分析一下。


   location /api5/ {
           proxy_pass http://localhost:8080/haha;
        }
   # http://localhost/api5/xxx -> http://localhost:8080/hahaxxx，请注意这里的haha和xxx之间没有斜杠，分析一下原因。

   location /api6/ {
           proxy_pass http://localhost:8080/haha/;
        }
   # http://localhost/api6/xxx -> http://localhost:8080/haha/xxx

   location /api7 {
           proxy_pass http://localhost:8080/haha;
        }
   # http://localhost/api7/xxx -> http://localhost:8080/haha/xxx

   location /api8 {
           proxy_pass http://localhost:8080/haha/;
        }
  # http://localhost/api8/xxx -> http://localhost:8080/haha//xxx，请注意这里的双斜杠。
}
```

| proxy_pass         | 路径变化                 | 说明 |
| ------------------ | ------------------------ | ---- |
| 最后有/            | 去掉location路径         |      |
| 最后没有/,没有路径 | 使用ip端口后面的作为路径 |      |
| 最后没有/,有路径   | 替换location路径             |      |
|                    |                          |      |
