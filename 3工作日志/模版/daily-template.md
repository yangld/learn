---
up:: [[{{date:YYYY-MM}}]]
prev:: [[{{date-1d:YYYY-MM-DD}}]]
next:: [[{{date+1d:YYYY-MM-DD}}]]
---

```dataview
list
from "3工作日志/日志"
where
contains(file.name, "{{date:YYYY-MM-DD}}-")
sort file.ctime
```