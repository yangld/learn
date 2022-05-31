1. 安装node
https://nodejs.org/zh-cn/download/
验证： 
node --version   
npm --version

2. 安装elasticdump
https://github.com/elasticsearch-dump/elasticsearch-dump
npm install elasticdump -g
elasticdump

3. 导出
elasticdump --input=http://20.153.10.31:9200/pekall-dev-app-log-2022-01 --output=202201.json --type=data
elasticdump --input=http://20.153.10.31:9200/pekall-dev-app-log-2022-02 --output=202202.json --type=data
elasticdump --input=http://20.153.10.31:9200/pekall-dev-app-log-2022-03 --output=202203.json --type=data
elasticdump --input=http://20.153.10.31:9200/pekall-dev-app-log-2022-04 --output=202204.json --type=data
elasticdump --input=http://20.153.10.31:9200/pekall-dev-app-log-2022-05 --output=202205.json --type=data

4. 导入
elasticdump --input=202204.json --output=http://20.153.10.31:9200/pekall-test-2022-05 --type=data


[	] 	aaa