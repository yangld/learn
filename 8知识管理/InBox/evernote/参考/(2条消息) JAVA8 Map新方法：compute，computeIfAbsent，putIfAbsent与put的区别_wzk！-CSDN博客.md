
![[8知识管理/InBox/evernote/参考/_resources/(2条消息)_JAVA8_Map新方法：compute，computeIfAbsent，putIfAbsent与put的区别_wzk！-CSDN博客.resources/embedded.svg]]

本文参考自：[Java8（3）：Java8 中 Map 接口的新方法](https://segmentfault.com/a/1190000007838166)

# 不管存不存在key，都设值：

## 1\. put

put返回旧值，如果没有则返回null

        @Test
        public void testMap() {
            Map<String, String> map = new HashMap<>();
            map.put("a","A");
            map.put("b","B");
            String v = map.put("b","v"); // 输出 B
            System.out.println(v);
            String v1 = map.put("c","v");
            System.out.println(v1); // 输出：NULL
        }
    

## 2\. compute（相当于put,只不过返回的是新值）

compute：返回新值
当key不存在时，执行value计算方法，计算value

    
        @Test
        public void testMap() {
            Map<String, String> map = new HashMap<>();
            map.put("a", "A");
            map.put("b", "B");
            String val = map.compute("b", (k, v) -> "v"); // 输出 v
            System.out.println(val);
            String v1 = map.compute("c", (k, v) -> "v"); // 输出 v
            System.out.println(v1);
        }
    
    

# 以下几个方法，如果不存在，再put：

## 1\. putIfAbsent

putIfAbsent返回旧值，如果没有则返回null
先计算value，再判断key是否存在

        @Test
        public void testMap() {
            Map<String, String> map = new HashMap<>();
            map.put("a","A");
            map.put("b","B");
            String v = map.putIfAbsent("b","v");  // 输出 B
            System.out.println(v);
            String v1 = map.putIfAbsent("c","v");  // 输出 null
            System.out.println(v1);
        }
    
    

## 2\. computeIfAbsent

computeIfAbsent:存在时返回存在的值，不存在时返回新值
参数为：key，value计算方法
当key不存在时，执行value计算方法，计算value

        @Test
        public void testMap() {
            Map<String, String> map = new HashMap<>();
            map.put("a","A");
            map.put("b","B");
            String v = map.computeIfAbsent("b",k->"v");  // 输出 B
            System.out.println(v);
            String v1 = map.computeIfAbsent("c",k->"v"); // 输出 v
            System.out.println(v1);
        }

    Created at: 2020-10-13T10:40:17+08:00
    Updated at: 2020-10-13T10:40:17+08:00

