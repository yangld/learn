
## [python 查询 elasticsearch 常用方法（Query DSL）](https://www.cnblogs.com/ExMan/p/11323984.html)

### 1\. 建立连接

    from elasticsearch import Elasticsearch
    es = Elasticsearch(["localhost:9200"])
    

### 2\. 查询所有数据

    
    # 方式1：
    es.search(index="index_name", doc_type="type_name")
     
    # 方式2：
    body = {
        "query":{
            "match_all":{}
        }
    }
    es.search(index="index_name", doc_type="type_name", body=body)
    

### 3\. 等于查询，term与terms

    # term: 查询 xx = “xx”
    body = {
        "query":{
            "term":{
                "name":"python"
            }
        }
    }
    # 查询name="python"的所有数据
    es.search(index="index_name",doc_type="type_name",body=body)
    
    # terms: 查询 xx = “xx” 或 xx = “yy”
    body = {
        "query":{
            "terms":{
                "name":[
                    "ios","android"
                ]
            }
        }
    }
    
    # 查询出name="ios"或name="android"的所有数据
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 4\. 包含查询，match与multi\_match

    # match: 匹配name包含"python"关键字的数据
    body = {
        "query":{
            "match":{
                "name":"python"
            }
        }
    }
    # 查询name包含python关键字的数据
    es.search(index="index_name",doc_type="type_name",body=body)
     
    # multi_match: 在name和addr里匹配包含深圳关键字的数据
    body = {
        "query":{
            "multi_match":{
                "query":"深圳",
                "fields":["name", "addr"]
            }
        }
    }
    # 查询name和addr包含"深圳"关键字的数据
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 5\. ids

    body = {
        "query":{
            "ids":{
                "type":"type_name",
                "values":[
                    "1","2"
                ]
            }
        }
    }
    # 搜索出id为1或2的所有数据
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 6\. 复合查询bool

bool有3类查询关系，must(都满足),should(其中一个满足),must\_not(都不满足)

    body = {
        "query":{
            "bool":{
                "must":[
                    {
                        "term":{
                            "name":"python"
                        }
                    },
                    {
                        "term":{
                            "age":18
                        }
                    }
                ]
            }
        }
    }
    # 获取name="python"并且age=18的所有数据
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 7\. 切片式查询

    body = {
        "query":{
            "match_all":{}
        }
        "from":2    # 从第二条数据开始
        "size":4    # 获取4条数据
    }
    # 从第2条数据开始，获取4条数据
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 8\. 范围查询

    body = {
        "query":{
            "range":{
                "age":{
                    "gte":18,       # >=18
                    "lte":30        # <=30
                }
            }
        }
    }
    # 查询18<=age<=30的所有数据
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 9\. 前缀查询

    body = {
        "query":{
            "prefix":{
                "name":"p"
            }
        }
    }
    # 查询前缀为"赵"的所有数据
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 10\. 通配符查询

    body = {
        "query":{
            "wildcard":{
                "name":"*id"
            }
        }
    }
    # 查询name以id为后缀的所有数据
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 11\. 排序

    body = {
        "query":{
            "match_all":{}
        }
        "sort":{
            "age":{                 # 根据age字段升序排序
                "order":"asc"       # asc升序，desc降序
            }
        }
    }
    
    # 多字段排序，注意顺序！写在前面的优先排序
    body = {
        "query":{
            "match_all":{}
        }
        "sort":[{
            "age":{                # 先根据age字段升序排序
                "order":"asc"      # asc升序，desc降序
            }
        },{
            "name":{               # 后根据name字段升序排序
                "order":"asc"      # asc升序，desc降序
            }
        }],
    }
    

### 12\. filter\_path, 响应过滤

    # 只需要获取_id数据,多个条件用逗号隔开
    es.search(index="index_name",doc_type="type_name",filter_path=["hits.hits._id"])
     
    # 获取所有数据
    es.search(index="index_name",doc_type="type_name",filter_path=["hits.hits._*"])
    

### 13\. count, 执行查询并获取该查询的匹配数

    # 获取数据量
    es.count(index="index_name",doc_type="type_name")
    

### 14\. 度量类聚合

##### 14.1. 获取最小值

    body = {
        "query":{
            "match_all":{}
        },
        "aggs":{                        # 聚合查询
            "min_age":{                 # 最小值的key
                "min":{                 # 最小
                    "field":"age"       # 查询"age"的最小值
                }
            }
        }
    }
    # 搜索所有数据，并获取age最小的值
    es.search(index="index_name",doc_type="type_name",body=body)
    

##### 14.2. 获取最大值

    body = {
        "query":{
            "match_all":{}
        },
        "aggs":{                        # 聚合查询
            "max_age":{                 # 最大值的key
                "max":{                 # 最大
                    "field":"age"       # 查询"age"的最大值
                }
            }
        }
    }
    # 搜索所有数据，并获取age最大的值
    es.search(index="index_name",doc_type="type_name",body=body)
    

##### 14.3. 获取和

    body = {
        "query":{
            "match_all":{}
        },
        "aggs":{                        # 聚合查询
            "sum_age":{                 # 和的key
                "sum":{                 # 和
                    "field":"age"       # 获取所有age的和
                }
            }
        }
    }
    # 搜索所有数据，并获取所有age的和
    es.search(index="index_name",doc_type="type_name",body=body)
    

##### 14.4. 获取平均值

    body = {
        "query":{
            "match_all":{}
        },
        "aggs":{                        # 聚合查询
            "avg_age":{                 # 平均值的key
                "sum":{                 # 平均值
                    "field":"age"       # 获取所有age的平均值
                }
            }
        }
    }
    # 搜索所有数据，获取所有age的平均值
    es.search(index="index_name",doc_type="type_name",body=body)
    

### 15\. from、size

1.  from：从“第几条”开始查询
2.  size：查询多少条

    body = {
        "query":{
            "match_all":{}
        },
        "size":"50",
        "from":"0"
    }
    

### 原文连接：

1.  <https://blog.csdn.net/y472360651/article/details/76652021>
2.  [https://blog.csdn.net/m\_z\_g\_y/article/details/82628972](https://blog.csdn.net/m_z_g_y/article/details/82628972)

分类: [ElasticSearch](https://www.cnblogs.com/ExMan/category/1412021.html)

[[# | 好文要顶]] [[# | 关注我]] [[# | 收藏该文]] [[# | ![[./_resources/python_查询_elasticsearch_常用方法（Query_DSL）_-_ExplorerMan_-_博客园.resources/icon_weibo_24.png]]]] [[# | ![[./_resources/python_查询_elasticsearch_常用方法（Query_DSL）_-_ExplorerMan_-_博客园.resources/wechat.png]]]]

[![[./_resources/python_查询_elasticsearch_常用方法（Query_DSL）_-_ExplorerMan_-_博客园.resources/20140222201827.png]]](https://home.cnblogs.com/u/ExMan/)
[ExplorerMan](https://home.cnblogs.com/u/ExMan/)
[关注 - 75](https://home.cnblogs.com/u/ExMan/followees/)
[粉丝 - 304](https://home.cnblogs.com/u/ExMan/followers/)

[[# | +加关注]]

0
0

[«](https://www.cnblogs.com/ExMan/p/11323651.html) 上一篇： [es笔记---新建es索引](https://www.cnblogs.com/ExMan/p/11323651.html)
[»](https://www.cnblogs.com/ExMan/p/11324003.html) 下一篇： [python连接 elasticsearch 查询数据，支持分页](https://www.cnblogs.com/ExMan/p/11324003.html)

posted on 2019-08-08 21:31  [ExplorerMan](https://www.cnblogs.com/ExMan/)  阅读(4511)  评论(1)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=11323984)  [[# | 收藏]]

    Created at: 2021-02-04T18:06:49+08:00
    Updated at: 2021-02-04T18:06:49+08:00

