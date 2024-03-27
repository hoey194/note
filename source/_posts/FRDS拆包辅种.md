---
title: FRDS拆包辅种
date: 2024-03-26 18:33:45
tags:
---



利用拆包大法混一混时魔

![image-20240326183435863](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20240326183435863.png)



## 一、下载一个DouBan Top250大包

去一个小站点下载一个Douban Top250，推荐下载我这里的大包。因为大包不一样，可能会辅不上。

![image-20240326183607918](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20240326183607918.png)



查看一下你下载到磁盘上的目录，这里以我的目录为例，

```
downloads/bz/DouBan.2022.11.11.Top.250.BluRay.1080p.x265.10bit.MNHD-FRDS
```

## 二、 下载FRDS种子

1. 创建一个txt文件

2. 将下面的代码，拷贝到txt里面，把里面的{FRDS_URL}替换成FRDS的URL

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Document</title>
</head>
<body>
  <a id="link">链接</a>
  <script>
    function delay(time) {
      return new Promise((res) => setTimeout(res, time));
    }

    const links = [
      // 400多个种子会有冗余
    "https://{FRDS_URL}/download.php?id=5068",
    "https://{FRDS_URL}/download.php?id=5775",
    "https://{FRDS_URL}/download.php?id=5089",
    "https://{FRDS_URL}/download.php?id=7103",
    "https://{FRDS_URL}/download.php?id=12101",
    "https://{FRDS_URL}/download.php?id=6094",
    "https://{FRDS_URL}/download.php?id=6405",
    "https://{FRDS_URL}/download.php?id=6072",
    "https://{FRDS_URL}/download.php?id=10276",
    "https://{FRDS_URL}/download.php?id=5087",
    "https://{FRDS_URL}/download.php?id=5792",
    "https://{FRDS_URL}/download.php?id=5130",
    "https://{FRDS_URL}/download.php?id=5496",
    "https://{FRDS_URL}/download.php?id=7018",
    "https://{FRDS_URL}/download.php?id=10357",
    "https://{FRDS_URL}/download.php?id=6141",
    "https://{FRDS_URL}/download.php?id=4735",
    "https://{FRDS_URL}/download.php?id=5095",
    "https://{FRDS_URL}/download.php?id=5076",
    "https://{FRDS_URL}/download.php?id=5959",
    "https://{FRDS_URL}/download.php?id=9317",
    "https://{FRDS_URL}/download.php?id=3851",
    "https://{FRDS_URL}/download.php?id=5590",
    "https://{FRDS_URL}/download.php?id=6514",
    "https://{FRDS_URL}/download.php?id=5772",
    "https://{FRDS_URL}/download.php?id=4613",
    "https://{FRDS_URL}/download.php?id=4271",
    "https://{FRDS_URL}/download.php?id=10037",
    "https://{FRDS_URL}/download.php?id=5794",
    "https://{FRDS_URL}/download.php?id=7159",
    "https://{FRDS_URL}/download.php?id=5114",
    "https://{FRDS_URL}/download.php?id=5206",
    "https://{FRDS_URL}/download.php?id=4610",
    "https://{FRDS_URL}/download.php?id=9879",
    "https://{FRDS_URL}/download.php?id=856410",
    "https://{FRDS_URL}/download.php?id=9126",
    "https://{FRDS_URL}/download.php?id=7532",
    "https://{FRDS_URL}/download.php?id=8600",
    "https://{FRDS_URL}/download.php?id=13364",
    "https://{FRDS_URL}/download.php?id=8471",
    "https://{FRDS_URL}/download.php?id=8764",
    "https://{FRDS_URL}/download.php?id=4446",
    "https://{FRDS_URL}/download.php?id=12879",
    "https://{FRDS_URL}/download.php?id=12862",
    "https://{FRDS_URL}/download.php?id=11581",
    "https://{FRDS_URL}/download.php?id=11483",
    "https://{FRDS_URL}/download.php?id=12782",
    "https://{FRDS_URL}/download.php?id=12202",
    "https://{FRDS_URL}/download.php?id=5132",
    "https://{FRDS_URL}/download.php?id=5128",
    "https://{FRDS_URL}/download.php?id=5127",
    "https://{FRDS_URL}/download.php?id=6390",
    "https://{FRDS_URL}/download.php?id=5070",
    "https://{FRDS_URL}/download.php?id=13098",
    "https://{FRDS_URL}/download.php?id=6132",
    "https://{FRDS_URL}/download.php?id=4742",
    "https://{FRDS_URL}/download.php?id=4118",
    "https://{FRDS_URL}/download.php?id=5729",
    "https://{FRDS_URL}/download.php?id=6143",
    "https://{FRDS_URL}/download.php?id=5066",
    "https://{FRDS_URL}/download.php?id=6389",
    "https://{FRDS_URL}/download.php?id=9124",
    "https://{FRDS_URL}/download.php?id=6438",
    "https://{FRDS_URL}/download.php?id=5882",
    "https://{FRDS_URL}/download.php?id=4274",
    "https://{FRDS_URL}/download.php?id=11895",
    "https://{FRDS_URL}/download.php?id=13658",
    "https://{FRDS_URL}/download.php?id=10860",
    "https://{FRDS_URL}/download.php?id=942516",
    "https://{FRDS_URL}/download.php?id=6439",
    "https://{FRDS_URL}/download.php?id=5813",
    "https://{FRDS_URL}/download.php?id=5032",
    "https://{FRDS_URL}/download.php?id=9246",
    "https://{FRDS_URL}/download.php?id=11295",
    "https://{FRDS_URL}/download.php?id=3970",
    "https://{FRDS_URL}/download.php?id=5998",
    "https://{FRDS_URL}/download.php?id=12313",
    "https://{FRDS_URL}/download.php?id=4224",
    "https://{FRDS_URL}/download.php?id=6291",
    "https://{FRDS_URL}/download.php?id=11891",
    "https://{FRDS_URL}/download.php?id=4540",
    "https://{FRDS_URL}/download.php?id=4537",
    "https://{FRDS_URL}/download.php?id=11752",
    "https://{FRDS_URL}/download.php?id=6595",
    "https://{FRDS_URL}/download.php?id=6721",
    "https://{FRDS_URL}/download.php?id=4857",
    "https://{FRDS_URL}/download.php?id=3967",
    "https://{FRDS_URL}/download.php?id=3855",
    "https://{FRDS_URL}/download.php?id=5375",
    "https://{FRDS_URL}/download.php?id=5312",
    "https://{FRDS_URL}/download.php?id=6903",
    "https://{FRDS_URL}/download.php?id=3982",
    "https://{FRDS_URL}/download.php?id=3981",
    "https://{FRDS_URL}/download.php?id=5962",
    "https://{FRDS_URL}/download.php?id=5069",
    "https://{FRDS_URL}/download.php?id=4018",
    "https://{FRDS_URL}/download.php?id=4010",
    "https://{FRDS_URL}/download.php?id=9290",
    "https://{FRDS_URL}/download.php?id=4106",
    "https://{FRDS_URL}/download.php?id=3978",
    "https://{FRDS_URL}/download.php?id=6787",
    "https://{FRDS_URL}/download.php?id=6399",
    "https://{FRDS_URL}/download.php?id=5771",
    "https://{FRDS_URL}/download.php?id=5952",
    "https://{FRDS_URL}/download.php?id=4497",
    "https://{FRDS_URL}/download.php?id=10652",
    "https://{FRDS_URL}/download.php?id=11865",
    "https://{FRDS_URL}/download.php?id=12145",
    "https://{FRDS_URL}/download.php?id=11254",
    "https://{FRDS_URL}/download.php?id=6879",
    "https://{FRDS_URL}/download.php?id=10300",
    "https://{FRDS_URL}/download.php?id=13195",
    "https://{FRDS_URL}/download.php?id=4943",
    "https://{FRDS_URL}/download.php?id=9640",
    "https://{FRDS_URL}/download.php?id=915060",
    "https://{FRDS_URL}/download.php?id=6099",
    "https://{FRDS_URL}/download.php?id=6979",
    "https://{FRDS_URL}/download.php?id=12228",
    "https://{FRDS_URL}/download.php?id=3980",
    "https://{FRDS_URL}/download.php?id=3971",
    "https://{FRDS_URL}/download.php?id=10986",
    "https://{FRDS_URL}/download.php?id=2798",
    "https://{FRDS_URL}/download.php?id=9653",
    "https://{FRDS_URL}/download.php?id=4606",
    "https://{FRDS_URL}/download.php?id=5380",
    "https://{FRDS_URL}/download.php?id=5830",
    "https://{FRDS_URL}/download.php?id=6039",
    "https://{FRDS_URL}/download.php?id=5839",
    "https://{FRDS_URL}/download.php?id=9580",
    "https://{FRDS_URL}/download.php?id=10559",
    "https://{FRDS_URL}/download.php?id=3804",
    "https://{FRDS_URL}/download.php?id=5368",
    "https://{FRDS_URL}/download.php?id=5369",
    "https://{FRDS_URL}/download.php?id=10713",
    "https://{FRDS_URL}/download.php?id=5558",
    "https://{FRDS_URL}/download.php?id=5764",
    "https://{FRDS_URL}/download.php?id=1738414",
    "https://{FRDS_URL}/download.php?id=7025",
    "https://{FRDS_URL}/download.php?id=6073",
    "https://{FRDS_URL}/download.php?id=4495",
    "https://{FRDS_URL}/download.php?id=5997",
    "https://{FRDS_URL}/download.php?id=7973",
    "https://{FRDS_URL}/download.php?id=5321",
    "https://{FRDS_URL}/download.php?id=6747",
    "https://{FRDS_URL}/download.php?id=4544",
    "https://{FRDS_URL}/download.php?id=4618",
    "https://{FRDS_URL}/download.php?id=10352",
    "https://{FRDS_URL}/download.php?id=8511",
    "https://{FRDS_URL}/download.php?id=6632",
    "https://{FRDS_URL}/download.php?id=10914",
    "https://{FRDS_URL}/download.php?id=6351",
    "https://{FRDS_URL}/download.php?id=6346",
    "https://{FRDS_URL}/download.php?id=6927",
    "https://{FRDS_URL}/download.php?id=4554",
    "https://{FRDS_URL}/download.php?id=6998",
    "https://{FRDS_URL}/download.php?id=9863",
    "https://{FRDS_URL}/download.php?id=5856",
    "https://{FRDS_URL}/download.php?id=6616",
    "https://{FRDS_URL}/download.php?id=7356",
    "https://{FRDS_URL}/download.php?id=10301",
    "https://{FRDS_URL}/download.php?id=4276",
    "https://{FRDS_URL}/download.php?id=3983",
    "https://{FRDS_URL}/download.php?id=5418",
    "https://{FRDS_URL}/download.php?id=4410",
    "https://{FRDS_URL}/download.php?id=4409",
    "https://{FRDS_URL}/download.php?id=3854",
    "https://{FRDS_URL}/download.php?id=9301",
    "https://{FRDS_URL}/download.php?id=6330",
    "https://{FRDS_URL}/download.php?id=6852",
    "https://{FRDS_URL}/download.php?id=9676",
    "https://{FRDS_URL}/download.php?id=4114",
    "https://{FRDS_URL}/download.php?id=5460",
    "https://{FRDS_URL}/download.php?id=10994",
    "https://{FRDS_URL}/download.php?id=5761",
    "https://{FRDS_URL}/download.php?id=4186",
    "https://{FRDS_URL}/download.php?id=5979",
    "https://{FRDS_URL}/download.php?id=5143",
    "https://{FRDS_URL}/download.php?id=5151",
    "https://{FRDS_URL}/download.php?id=5144",
    "https://{FRDS_URL}/download.php?id=7451",
    "https://{FRDS_URL}/download.php?id=4417",
    "https://{FRDS_URL}/download.php?id=7001",
    "https://{FRDS_URL}/download.php?id=8247",
    "https://{FRDS_URL}/download.php?id=12535",
    "https://{FRDS_URL}/download.php?id=5860",
    "https://{FRDS_URL}/download.php?id=5093",
    "https://{FRDS_URL}/download.php?id=9880",
    "https://{FRDS_URL}/download.php?id=5047",
    "https://{FRDS_URL}/download.php?id=6075",
    "https://{FRDS_URL}/download.php?id=6596",
    "https://{FRDS_URL}/download.php?id=5739",
    "https://{FRDS_URL}/download.php?id=5738",
    "https://{FRDS_URL}/download.php?id=12663",
    "https://{FRDS_URL}/download.php?id=5886",
    "https://{FRDS_URL}/download.php?id=7041",
    "https://{FRDS_URL}/download.php?id=6639",
    "https://{FRDS_URL}/download.php?id=5077",
    "https://{FRDS_URL}/download.php?id=5588",
    "https://{FRDS_URL}/download.php?id=10041",
    "https://{FRDS_URL}/download.php?id=3933",
    "https://{FRDS_URL}/download.php?id=5981",
    "https://{FRDS_URL}/download.php?id=4542",
    "https://{FRDS_URL}/download.php?id=4543",
    "https://{FRDS_URL}/download.php?id=9073",
    "https://{FRDS_URL}/download.php?id=10524",
    "https://{FRDS_URL}/download.php?id=7190",
    "https://{FRDS_URL}/download.php?id=10754",
    "https://{FRDS_URL}/download.php?id=5862",
    "https://{FRDS_URL}/download.php?id=11315",
    "https://{FRDS_URL}/download.php?id=7104",
    "https://{FRDS_URL}/download.php?id=5063",
    "https://{FRDS_URL}/download.php?id=7705",
    "https://{FRDS_URL}/download.php?id=5067",
    "https://{FRDS_URL}/download.php?id=3965",
    "https://{FRDS_URL}/download.php?id=4037",
    "https://{FRDS_URL}/download.php?id=7065",
    "https://{FRDS_URL}/download.php?id=8544",
    "https://{FRDS_URL}/download.php?id=4668",
    "https://{FRDS_URL}/download.php?id=4669",
    "https://{FRDS_URL}/download.php?id=8119",
    "https://{FRDS_URL}/download.php?id=10802",
    "https://{FRDS_URL}/download.php?id=5749",
    "https://{FRDS_URL}/download.php?id=4122",
    "https://{FRDS_URL}/download.php?id=13374",
    "https://{FRDS_URL}/download.php?id=1974610",
    "https://{FRDS_URL}/download.php?id=1491774",
    "https://{FRDS_URL}/download.php?id=1974795",
    "https://{FRDS_URL}/download.php?id=1975635",
    "https://{FRDS_URL}/download.php?id=1079",
    "https://{FRDS_URL}/download.php?id=4271",
    "https://{FRDS_URL}/download.php?id=10037",
    "https://{FRDS_URL}/download.php?id=9879",
    "https://{FRDS_URL}/download.php?id=856410",
    "https://{FRDS_URL}/download.php?id=9126",
    "https://{FRDS_URL}/download.php?id=12879",
    "https://{FRDS_URL}/download.php?id=12862",
    "https://{FRDS_URL}/download.php?id=8600",
    "https://{FRDS_URL}/download.php?id=11581",
    "https://{FRDS_URL}/download.php?id=11483",
    "https://{FRDS_URL}/download.php?id=527",
    "https://{FRDS_URL}/download.php?id=13374",
    "https://{FRDS_URL}/download.php?id=12782",
    "https://{FRDS_URL}/download.php?id=8764",
    "https://{FRDS_URL}/download.php?id=12202",
    "https://{FRDS_URL}/download.php?id=13658",
    "https://{FRDS_URL}/download.php?id=5997",
    "https://{FRDS_URL}/download.php?id=7973",
    "https://{FRDS_URL}/download.php?id=5882",
    "https://{FRDS_URL}/download.php?id=5127",
    "https://{FRDS_URL}/download.php?id=5132",
    "https://{FRDS_URL}/download.php?id=5128",
    "https://{FRDS_URL}/download.php?id=6390",
    "https://{FRDS_URL}/download.php?id=1975635",
    "https://{FRDS_URL}/download.php?id=13098",
    "https://{FRDS_URL}/download.php?id=4742",
    "https://{FRDS_URL}/download.php?id=4118",
    "https://{FRDS_URL}/download.php?id=6389",
    "https://{FRDS_URL}/download.php?id=1974795",
    "https://{FRDS_URL}/download.php?id=9124",
    "https://{FRDS_URL}/download.php?id=6438",
    "https://{FRDS_URL}/download.php?id=4274",
    "https://{FRDS_URL}/download.php?id=11895",
    "https://{FRDS_URL}/download.php?id=10860",
    "https://{FRDS_URL}/download.php?id=942516",
    "https://{FRDS_URL}/download.php?id=6439",
    "https://{FRDS_URL}/download.php?id=5032",
    "https://{FRDS_URL}/download.php?id=9246",
    "https://{FRDS_URL}/download.php?id=11295",
    "https://{FRDS_URL}/download.php?id=5998",
    "https://{FRDS_URL}/download.php?id=12313",
    "https://{FRDS_URL}/download.php?id=6291",
    "https://{FRDS_URL}/download.php?id=11891",
    "https://{FRDS_URL}/download.php?id=4540",
    "https://{FRDS_URL}/download.php?id=4537",
    "https://{FRDS_URL}/download.php?id=11752",
    "https://{FRDS_URL}/download.php?id=6721",
    "https://{FRDS_URL}/download.php?id=3967",
    "https://{FRDS_URL}/download.php?id=5375",
    "https://{FRDS_URL}/download.php?id=6903",
    "https://{FRDS_URL}/download.php?id=5962",
    "https://{FRDS_URL}/download.php?id=4018",
    "https://{FRDS_URL}/download.php?id=4106",
    "https://{FRDS_URL}/download.php?id=6787",
    "https://{FRDS_URL}/download.php?id=11865",
    "https://{FRDS_URL}/download.php?id=11254",
    "https://{FRDS_URL}/download.php?id=6879",
    "https://{FRDS_URL}/download.php?id=10300",
    "https://{FRDS_URL}/download.php?id=13195",
    "https://{FRDS_URL}/download.php?id=9640",
    "https://{FRDS_URL}/download.php?id=915060",
    "https://{FRDS_URL}/download.php?id=6979",
    "https://{FRDS_URL}/download.php?id=12228",
    "https://{FRDS_URL}/download.php?id=10986",
    "https://{FRDS_URL}/download.php?id=2798",
    "https://{FRDS_URL}/download.php?id=9653",
    "https://{FRDS_URL}/download.php?id=4606",
    "https://{FRDS_URL}/download.php?id=5380",
    "https://{FRDS_URL}/download.php?id=10559",
    "https://{FRDS_URL}/download.php?id=3804",
    "https://{FRDS_URL}/download.php?id=10713",
    "https://{FRDS_URL}/download.php?id=5558",
    "https://{FRDS_URL}/download.php?id=1738414",
    "https://{FRDS_URL}/download.php?id=7025",
    "https://{FRDS_URL}/download.php?id=6073",
    "https://{FRDS_URL}/download.php?id=4495",
    "https://{FRDS_URL}/download.php?id=6747",
    "https://{FRDS_URL}/download.php?id=4544",
    "https://{FRDS_URL}/download.php?id=4618",
    "https://{FRDS_URL}/download.php?id=10352",
    "https://{FRDS_URL}/download.php?id=8511",
    "https://{FRDS_URL}/download.php?id=6632",
    "https://{FRDS_URL}/download.php?id=10914",
    "https://{FRDS_URL}/download.php?id=6346",
    "https://{FRDS_URL}/download.php?id=6927",
    "https://{FRDS_URL}/download.php?id=4554",
    "https://{FRDS_URL}/download.php?id=6616",
    "https://{FRDS_URL}/download.php?id=4403",
    "https://{FRDS_URL}/download.php?id=7356",
    "https://{FRDS_URL}/download.php?id=10301",
    "https://{FRDS_URL}/download.php?id=4276",
    "https://{FRDS_URL}/download.php?id=5418",
    "https://{FRDS_URL}/download.php?id=4409",
    "https://{FRDS_URL}/download.php?id=4410",
    "https://{FRDS_URL}/download.php?id=9301",
    "https://{FRDS_URL}/download.php?id=6330",
    "https://{FRDS_URL}/download.php?id=6852",
    "https://{FRDS_URL}/download.php?id=9676",
    "https://{FRDS_URL}/download.php?id=4114",
    "https://{FRDS_URL}/download.php?id=5052",
    "https://{FRDS_URL}/download.php?id=5460",
    "https://{FRDS_URL}/download.php?id=10994",
    "https://{FRDS_URL}/download.php?id=7001",
    "https://{FRDS_URL}/download.php?id=8247",
    "https://{FRDS_URL}/download.php?id=12535",
    "https://{FRDS_URL}/download.php?id=1292008",
    "https://{FRDS_URL}/download.php?id=5093",
    "https://{FRDS_URL}/download.php?id=9880",
    "https://{FRDS_URL}/download.php?id=5047",
    "https://{FRDS_URL}/download.php?id=1974610",
    "https://{FRDS_URL}/download.php?id=6596",
    "https://{FRDS_URL}/download.php?id=5738",
    "https://{FRDS_URL}/download.php?id=12663",
    "https://{FRDS_URL}/download.php?id=1491774",
    "https://{FRDS_URL}/download.php?id=7041",
    "https://{FRDS_URL}/download.php?id=6639",
    "https://{FRDS_URL}/download.php?id=1079",
    "https://{FRDS_URL}/download.php?id=5588",
    "https://{FRDS_URL}/download.php?id=10041",
    "https://{FRDS_URL}/download.php?id=3933",
    "https://{FRDS_URL}/download.php?id=4542",
    "https://{FRDS_URL}/download.php?id=4543",
    "https://{FRDS_URL}/download.php?id=9073",
    "https://{FRDS_URL}/download.php?id=10524",
    "https://{FRDS_URL}/download.php?id=10754",
    "https://{FRDS_URL}/download.php?id=5862",
    "https://{FRDS_URL}/download.php?id=11315",
    "https://{FRDS_URL}/download.php?id=7104",
    "https://{FRDS_URL}/download.php?id=7705",
    "https://{FRDS_URL}/download.php?id=7065",
    "https://{FRDS_URL}/download.php?id=8544",
    "https://{FRDS_URL}/download.php?id=4669",
    "https://{FRDS_URL}/download.php?id=4668",
    "https://{FRDS_URL}/download.php?id=8119",
    "https://{FRDS_URL}/download.php?id=4122",
    "https://{FRDS_URL}/download.php?id=5775",
    "https://{FRDS_URL}/download.php?id=7103",
    "https://{FRDS_URL}/download.php?id=12101",
    "https://{FRDS_URL}/download.php?id=6405",
    "https://{FRDS_URL}/download.php?id=6072",
    "https://{FRDS_URL}/download.php?id=10276",
    "https://{FRDS_URL}/download.php?id=13626",
    "https://{FRDS_URL}/download.php?id=13583",
    "https://{FRDS_URL}/download.php?id=5496",
    "https://{FRDS_URL}/download.php?id=7018",
    "https://{FRDS_URL}/download.php?id=10357",
    "https://{FRDS_URL}/download.php?id=6141",
    "https://{FRDS_URL}/download.php?id=4735",
    "https://{FRDS_URL}/download.php?id=4895",
    "https://{FRDS_URL}/download.php?id=5095",
    "https://{FRDS_URL}/download.php?id=5076",
    "https://{FRDS_URL}/download.php?id=9317",
    "https://{FRDS_URL}/download.php?id=5590",
    "https://{FRDS_URL}/download.php?id=5772",
    "https://{FRDS_URL}/download.php?id=4088",
    "https://{FRDS_URL}/download.php?id=1840321",
    "https://{FRDS_URL}/download.php?id=12383",
    "https://{FRDS_URL}/download.php?id=10652#",
    "https://{FRDS_URL}/download.php?id=10652",
    "https://{FRDS_URL}/download.php?id=9580",
    "https://{FRDS_URL}/download.php?id=5886",
    "https://{FRDS_URL}/download.php?id=12793",
    "https://{FRDS_URL}/download.php?id=2541",
    "https://{FRDS_URL}/download.php?id=1818",
    "https://{FRDS_URL}/download.php?id=7451",
    "https://{FRDS_URL}/download.php?id=1976323",
    "https://{FRDS_URL}/download.php?id=10802",
    "https://{FRDS_URL}/download.php?id=11318",
    "https://{FRDS_URL}/download.php?id=4446",
    "https://{FRDS_URL}/download.php?id=1977576",
    "https://{FRDS_URL}/download.php?id=1977573",
    "https://{FRDS_URL}/download.php?id=1977574",
    "https://{FRDS_URL}/download.php?id=1977578",
    "https://{FRDS_URL}/download.php?id=1977575",
    "https://{FRDS_URL}/download.php?id=1977566",
    "https://{FRDS_URL}/download.php?id=1977577",
    "https://{FRDS_URL}/download.php?id=4236",
    "https://{FRDS_URL}/download.php?id=5887"
    ];
    const a = document.getElementById("link");

    async function download() {
      for (const link of links) {
        await delay(2000);
        a.href = link;
        a.click();
      }
    }

    download();
  </script>
</body>
</html>
```

3. 等待种子下好以后，开始添加种子

推荐使用TR进行上传校验，因为QB很占用内存。

在操作之前推荐你限速TR的下载为0，避免一会上传完种子直接下载了，因为我们是想校验种子

![](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20240327103740896.png)



因为上面利用脚本下载的种子也是冗余过的种子，很多种子都不免费

打开TR： 

![image-20240327103833112](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20240327103833112.png)

点击左上角的⬇️，选择刚刚下载的种子，然后回车。

在下载界面一定要选择好存储的目录，这里的目录要写Douban的那个目录，按照自己的目录替换

![image-20240326184551365](https://hoey-images.oss-cn-hangzhou.aliyuncs.com/img/image-20240326184551365.png)



添加以后，等待种子校验即可。



## 三、 其他

浏览器默认会下载400多个种子，需要等一会，看一下哪些种子辅不上，就删掉。

如果有一些没有辅上，你可以手动在搜一搜。

结语：还有这么多在FDRS搜不到的种子

```
สิ่งเล็กเล็กที่เรียกว่า...รัก.A.Little.Thing.Called.Love.AKA.First.Love.2010.WEB-DL.1080p.x264.AAC-PTHome.mp4
"Avatar.2009.Extended.Collector's.Edition.Hybrid.BluRay.1080p.x265.10bit.DDP5.1.Repack.H.MNHD-FRDS.mkv"
CCTV6-HD.The.Teahouse.1982.1080p.HDTV.x264.DD2.0-LTF
Heart.and.Yummie.2010.1080p.BluRay.x264-WiKi
Late.Blossom2011.1080p.WEB-DL.H265.AAC-PTHweb'
Memories.of.Matsuko.2006.BluRay.1080p.x265.10bit.MNHD-FRDS
"Prince.Nezha's.Triumph.Against.Dragon.King.1979.Webrip.1080p.x265.10bit.AAC.MNHD-FRDS.mkv"
Top138.英雄本色(4K修复版).A.Better.Tomorrow.1986.REMASTERED.Bluray.1080p.x265.AAC(5.1).2Audios.GREENOTEA'
To.the.Forest.of.Firefly.Lights.2011.1080p.BluRay.x264-WiKi
We.Made.a.Beautiful.Bouquet.2021.1080p.BluRay.x265.10bit.DTS-WiKi
二十二.Twenty.Two.2015.1080p.WEB-DL.H265.DDP-LeagueWEB
倩女幽魂.A.Chinese.Ghost.Story.1987.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
加勒比海盗：黑珍珠号的诅咒.Pirates.of.the.Caribbean.The.Curse.of.the.Black.Pearl.2003.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
哈利波特与密室.Harry.Potter.and.the.Chamber.of.Secrets.2002.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
哈利波特与死亡圣器上.Harry.Potter.and.the.Deathly.Hallows.Part.1.2010.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
哈利波特与死亡圣器下.Harry.Potter.and.the.Deathly.Hallows.Part.2.2011.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
哈利波特与火焰杯.Harry.Potter.and.the.Goblet.of.Fire.2005.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
哈利波特与阿兹卡班的囚徒.Harry.Potter.and.the.Prisoner.of.Azkaban.2004.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
"哈利波特与魔法石.Harry.Potter.and.the.Sorcerer's.Stone.2001.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS"
"哈尔的移动城堡.Howl's.Moving.Castle.2004.BluRay.1080p.x265.10bit.4Audio.MNHD-FRDS"
喜剧之王.1999.1080i.AC3-2Audio.x5.1-H264_HDCTV_翡翠台源码.ts
寄生虫.Parasite.AKA.Gisaengchung.2019.BluRay.1080p.x265.10bit.MNHD-FRDS
'幽灵公主.PrincessMononoke.1997.BluRay.1080p.x265.10bit.4Audio.MNHD-FRDS'
"忠犬八公的故事.Hachi.A.Dog'sTale.2009.BluRay.1080p.x265.10bit.MNHD-FRDS"
情书.Love.Letter.1995.BluRay.1080p.x265.10bit.3Audio.MNHD-FRDS
教父2.The.Godfather.Part.II.1974.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
教父3.The.Godfather.Part.III.1990.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
教父.The.Godfather.1972.BluRay.1080p.x265.10bit.2Audio.MNHD-FRDS
海边的曼彻斯特.ManchesterbytheSea.2016.BluRay.1080p.x265.10bit.MNHD-FRDS'
迪士尼自然：海洋.Oceans2009.CHN.Bluray.1080p.x265.10bit.2Audios.MNHD-FRDS'
"阳光姐妹淘.Sseo-ni.AKA.Sunny.2011.Director's.Cut.1080p.KOR.Bluray.x265.10bit.DDP5.1.MNHD-FRDS"
"飞越疯人院.One.Flew.Over.the.Cuckoo's.Nest.1975.BluRay.1080p.x265.10bit.3Audio.MNHD-FRDS"
鬼子来了.Devils.on.the.Doorstep.2000.DVDrip.720p.x265.10bit.FRDS
"魔女宅急便.Kiki's.Delivery.Service.1989.BluRay.1080p.x265.10bit.4Audio.MNHD-FRDS"
```

