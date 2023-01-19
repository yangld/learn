spark

无穷数据集
有界数据集

流式
批处理

基石
checkpoint
state
time
window

sql/table api
stream api
function

Source  --> Transformation --> Sink

Source
	基于本地集合的source
	基于文件的source
	基于网络套接字的source
	自定义的source
		Apache kafka
		Amazon Kinesis Streams
		RabbitMQ
		Twitter Streaming API
		Apache NiFi
		自己定义
Transformation
	Map / FlatMap / Filter / KeyBy / Reduce / Fold / Aggregations / Window / WindowAll / Union / Window join / Split / Select / Project
Sink
	写入文件
	打印出来
	写入Socket
	自定义的Sink
		Apacke kafka
		Rabbit MQ
		MySQL
		ElasticSearch
		Apache Cassandra
		Hadoop FileSystem
		自己定义

保证状态化计算强一致性

处理时间
事件时间
进入时间

水印