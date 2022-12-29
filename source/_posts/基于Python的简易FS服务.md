---
title: 基于Python的简易FS服务
abbrlink: b422eee5
date: 2022-12-12 16:43:04
tags:
---

创建start.py，代码如下：

```python
#!/usr/bin/env python
try:
    # Python 3
    from http.server import HTTPServer, SimpleHTTPRequestHandler, test as test_orig
    import sys
    def test (*args):
        test_orig(*args, port=int(sys.argv[1]) if len(sys.argv) > 1 else 8000)
except ImportError: # Python 2
    from BaseHTTPServer import HTTPServer, test
    from SimpleHTTPServer import SimpleHTTPRequestHandler
 
class CORSRequestHandler (SimpleHTTPRequestHandler):
    def end_headers (self):
        self.send_header('Access-Control-Allow-Origin', '*')
        SimpleHTTPRequestHandler.end_headers(self)
 
if __name__ == '__main__':
    test(CORSRequestHandler, HTTPServer)
```

运行start.py,端口为8000

```pytho
python start.py 8000
```

