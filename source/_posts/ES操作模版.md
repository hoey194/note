---
title: ES操作模版
abbrlink: 8614bb4c
date: 2023-11-08 09:36:04
tags:
---



下面是一些ES日常操作，记录下来方便查询

```
#查看集群的健康情况
GET /_cat/health?v

#查看节点的情况
GET /_cat/nodes?v

#查询各个索引状态
GET /_cat/indices?v

#创建索引
PUT /movie_index

#查看某一个索引的分片情况
GET /_cat/shards/movie_index?v

#删除索引
DELETE /movie_index

#创建文档
PUT /movie_index/movie/1
{ "id":100,
  "name":"operation red sea",
  "doubanScore":8.5,
  "actorList":[  
  {"id":1,"name":"zhang yi"},
  {"id":2,"name":"hai qing"},
  {"id":3,"name":"zhang han yu"}
  ]
}

PUT /movie_index/movie/2
{
  "id":200,
  "name":"operation meigong river",
  "doubanScore":8.0,
  "actorList":[  
{"id":3,"name":"zhang han yu"}
]
}

PUT /movie_index/movie/3
{
  "id":300,
  "name":"incident red sea",
  "doubanScore":5.0,
  "actorList":[  
{"id":4,"name":"zhang san feng"}
]
}

#查询某一个索引中的全部文档
GET /movie_index/_search

#根据id查询某一个文档
GET /movie_index/movie/3

#根据文档id，删除某一个文档
DELETE /movie_index/movie/3

POST /_forcemerge

#put 对已经存在的文档进行替换(幂等性)
PUT /movie_index/movie/3
{
  "id":300,
  "name":"incident red sea",
  "doubanScore":5.0,
  "actorList":[  
{"id":4,"name":"zhang cuishan"}
]
}


#post 进行新增操作，无法保证幂等性
#根据主键保证幂等性
POST /movie_index/movie/
{
  "id":300,
  "name":"incident red sea",
  "doubanScore":5.0,
  "actorList":[  
{"id":4,"name":"zhang cuishan111"}
]
}


GET /movie_index/_search

GET /movie_index/movie/1

POST /movie_index/movie/1/_update
{
  "doc":  { "name": "新的字段值" }
}


POST /movie_index/_update_by_query
{
	"query": {
	  "match":{
	    "actorList.id":1
	  }  
	},
	"script": {
	  "lang": "painless",
	  "source":"for(int i=0;i<ctx._source.actorList.length;i++){if(ctx._source.actorList[i].id==3){ctx._source.actorList[i].name='tttt'}}"
	}
}

GET /movie_index/_search

POST /movie_index/_delete_by_query
{
  "query": {
    "match_all": {}
  }
}

#批量添加两个document
POST /movie_index/movie/_bulk
{"index":{"_id":66}}
{"id":300,"name":"incident red sea","doubanScore":5.0,"actorList":[{"id":4,"name":"zhang cuishan"}]}
{"index":{"_id":88}}
{"id":300,"name":"incident red sea","doubanScore":5.0,"actorList":[{"id":4,"name":"zhang cuishan"}]}




POST /movie_index/movie/_bulk
{"update":{"_id":"66"}}
{"doc": { "name": "wudangshanshang" } }
{"delete":{"_id":"88"}}


#------------------查询操作--------------------
#查询出当前索引中的全部数据
GET /movie_index/_search

GET /movie_index/_search?q=_id:66

#查询全部
GET /movie_index/_search
{
  "query": {
    "match_all": {}
  }
}

#根据电影的名称进行查询
GET /movie_index/_search
{
  "query": {
    "match": {
      "name": "operation red sea"
    }
  }
}

GET /movie_index

#按分词进行查询
GET /movie_index/_search
{
  "query": {
    "match": {
      "actorList.name": "zhang han yu"
    }
  }
}

#按短语查询  相当于like 
GET /movie_index/_search
{
  "query": {
    "match_phrase": {
      "actorList.name": "zhang han yu"
    }
  }
}

#不分词 通过精准匹配进行查询  term精准匹配
GET /movie_index/_search
{
  "query": {
    "term": {
       "actorList.name.keyword":"zhang han yu"
    }
  }
}


#容错匹配
GET /movie_index/_search
{
  "query": {
    "fuzzy": {
      "name": "radd"
    }
  }
}

#先匹配 再过滤
GET /movie_index/_search
{
  "query": {
    "match": {
      "name": "red"
    }
  }, 
  "post_filter": {
    "term": {
      "actorList.id": "3"
    }  
  }
}


#匹配和过滤同时
GET /movie_index/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "name": "red"
          }
        }
      ], 
      "filter": {
        "term": {
          "actorList.id": "3"
        }
      }
    }
  }
}

#范围过滤  ，将豆瓣评分在6到9的文档查询出来
GET /movie_index/_search
{
  "query": {
    "range": {
      "doubanScore": {
        "gte": 6,
        "lte": 9
      }
    }
  }
}


#按照豆瓣评分降序排序
GET /movie_index/_search
{
  "query": {
    "match": {
      "name": "red"
    }
  }, 
  "sort": [
    {
      "doubanScore": {
        "order": "asc"
      }
    }
  ]
}

#分页查询
GET /movie_index/_search
{
  "from": 0,
  "size": 2
}

#查询指定字段
GET /movie_index/_search
{
  "_source": ["name", "doubanScore"]
}

#高亮显示
GET /movie_index/_search
{
  "query": {
    "match": {
      "name": "red"
    }
  },
  "highlight": {
    "fields":  {"name":{} },
    "pre_tags": "<a>",
    "post_tags": "</a>"
  }
}


#需求1：取出每个演员共参演了多少部电影
#aggs 聚合
#term  精准匹配
#terms 聚合操作，相当于groupBy  
GET /movie_index/_search
{
  "aggs": {
    "myAggs": {
      "terms": {
        "field": "actorList.name.keyword",
        "size": 10
      }
    }
  }
}

#需求2：每个演员参演电影的平均分是多少，并按评分排序

GET /movie_index/_search
{
  "aggs": {
    "groupByName": {
      "terms": {
        "field": "actorList.name.keyword",
        "size": 10,
        "order": {
          "avg_score": "asc"
        }
      },
      "aggs": {
        "avg_score": {
          "avg": {
            "field": "doubanScore"
          }
        }
      }
    }
  }
}


#分词
#英文默认分词规则
GET /_analyze
{
  "text": "hello world"
}

#中文默认分词规则
GET /_analyze
{
  "text": "蓝瘦香菇",
  "analyzer": "ik_smart"
}

GET /_analyze
{
  "text": "蓝瘦香菇",
  "analyzer": "ik_max_word"
}


GET /movie_index



#自动定义mapping
PUT /movie_chn_1/movie/1
{ "id":1,
  "name":"红海行动",
  "doubanScore":8.5,
  "actorList":[  
  {"id":1,"name":"张译"},
  {"id":2,"name":"海清"},
  {"id":3,"name":"张涵予"}
 ]
}
PUT /movie_chn_1/movie/2
{
  "id":2,
  "name":"湄公河行动",
  "doubanScore":8.0,
  "actorList":[  
{"id":3,"name":"张涵予"}
]
}

PUT /movie_chn_1/movie/3
{
  "id":3,
  "name":"红海事件",
  "doubanScore":5.0,
  "actorList":[  
{"id":4,"name":"张三丰"}
]
}

GET /movie_chn_1/_search
{
  "query": {
    "match": {
      "name": "海行"
    }
  }
}

GET /movie_chn_1/_mapping


#自定义mapping
DELETE movie_chn_2

PUT movie_chn_2
{
  "mappings": {
    "movie":{
      "properties": {
        "id":{
          "type": "long"
        },
        "name":{
          "type": "keyword"
        },
        "doubanScore":{
          "type": "double"
        },
        "actorList":{
          "properties": {
            "id":{
              "type":"long"
            },
            "name":{
              "type":"keyword"
            }
          }
        }
      }
    }
  }
}


PUT /movie_chn_2/movie/1
{ "id":1,
  "name":"红海行动",
  "doubanScore":8.5,
  "actorList":[  
  {"id":1,"name":"张译"},
  {"id":2,"name":"海清"},
  {"id":3,"name":"张涵予"}
 ]
}
PUT /movie_chn_2/movie/2
{
  "id":2,
  "name":"湄公河行动",
  "doubanScore":8.0,
  "actorList":[  
{"id":3,"name":"张涵予"}
]
}

PUT /movie_chn_2/movie/3
{
  "id":3,
  "name":"红海事件",
  "doubanScore":5.0,
  "actorList":[  
{"id":4,"name":"张三丰"}
]
}

GET /movie_chn_2/_mapping

GET /movie_chn_2/_search
{
  "query": {
    "match": {
      "name": "海行"
    }
  }
}

POST /_reindex
{
  "source": {}
  , "dest": {}
}

#创建索引  并指定别名
PUT movie_chn_3
{
  "aliases": {
      "movie_chn_3_aliase": {}
  },
  "mappings": {
    "movie":{
      "properties": {
        "id":{
          "type": "long"
        },
        "name":{
          "type": "text", 
          "analyzer": "ik_smart"
        },
        "doubanScore":{
          "type": "double"
        },
        "actorList":{
          "properties": {
            "id":{
              "type":"long"
            },
            "name":{
              "type":"keyword"
            }
          }
        }
      }
    }
  }
}


GET /_cat/indices



GET /_cat/aliases


POST /_aliases
{
  "actions": [
    {
      "add": {
        "index": "movie_chn_3",
        "alias": "movie_chn_3_a2"
      }
    }
  ]
}


GET /movie_chn_3/_search

GET /movie_chn_3_a2/_search

GET /_cat/aliases

POST /_aliases
{
  "actions": [
    {
      "remove": {"index": "movie_chn_3","alias": "movie_chn_3_a2"}
    }
  ]
}


GET /movie_chn_1/_search

GET /movie_chn_2/_search



POST  _aliases
{
    "actions": [
        { "add":    { "index": "movie_chn_1", "alias": "movie_chn_query" }},
        { "add":    { "index": "movie_chn_2", "alias": "movie_chn_query" }}
    ]
}


GET /movie_chn_query/_search


POST  _aliases
{
    "actions": [
        { 
          "add":    
          { 
            "index": "movie_chn_1", 
            "alias": "movie_chn_1_sub_query",
            "filter": {
                "term": {  "actorList.id": "4"}
            }
          }
        }
    ]
}

GET /movie_chn_1_sub_query/_search


POST /_aliases
{
    "actions": [
        { "remove": { "index": "movie_chn_1", "alias": "movie_chn_query" }},
        { "remove": { "index": "movie_chn_2", "alias": "movie_chn_query" }},
        { "add":    { "index": "movie_chn_3", "alias": "movie_chn_query" }}
    ]
}


#创建模板
PUT _template/template_movie0523
{
  "index_patterns": ["movie_test*"],                  
  "settings": {                                               
    "number_of_shards": 1
  },
  "aliases" : { 
    "{index}-query": {},
    "movie_test-query":{}
  },
  "mappings": {                                          
    "_doc": {
      "properties": {
        "id": {
          "type": "keyword"
        },
        "movie_name": {
          "type": "text",
          "analyzer": "ik_smart"
        }
      }
    }
  }
}

POST movie_test_202010/_doc
{
  "id":"333",
  "name":"zhang3"
}

GET /movie_test_202010-query/_mapping


GET /_cat/templates

GET /_template/template_movie*
```



