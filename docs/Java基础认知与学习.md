# Java基础认知与学习

Java：编程语言

IDEA：IDE编辑器工具

---

## 简短开场

Java21，Java8。

Java21，新的特性，关键字简化，性能更好，Springboot 集成 业务处理方法封装 注解（加方法）

java8，学校，目前已经261以上，兼顾部分企业

后端：业务处理方法封装

计算器 

一个方法对应一个功能 

加add() 方法 加操作

---

## 基础知识

基础变量（int、float、double、char、string）

输入输出（Scanner、System.out.println）

``` 
print("Hello World")
System.out.println("Hello World")
```

注释 单行注释// 

IDEA2026版本 字符块注释

程序结构：

顺序结构（从上到下）

```java
System.out.println("Hello World");
return 0;
```



分支结构 if else else if 单分支、双分支、多分支

```java
int i = 0;
if(i>0){
	// 假
}
else if(i<0){
	// 假
}
else{
	// 真
}
```

循环结构  for while do-while

```java
arrs = [1,2,3,4,5]
for(int i=0; i< arrs.lenth(); i++){
	// 0,1,2,3,4
}
while(1){
	// 传感器持续采集数据，监听，收发数据
}
int i = 0;
do{
    System.out.println(i); // 0
    i++; // i = 1
}while(i<0);
```



## 比大小实操 

逻辑分析以及实战

![image-20261018205740037](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20261018205740037.png)

两个基础去分析需求，需求分析完之后在去在实战

```java
// 1. 输入一段话进行输出 Scanner println()
        Scanner sc = new Scanner(System.in);
        System.out.println("请用户输入一段文字：");
        String text = sc.nextLine(); // 接收文本
        System.out.println("你输入的内容是：" + text);
```

```java
// 2. 分支结构
int i = 100;
// 分支逻辑判断
if(i > 100){
    System.out.println("i 大于100"); // false 假
}
else if(i < 100){
    System.out.println("i 小于100"); // false 假
}
else{
    System.out.println("i 等于100"); // 上面都为假
}
```

```java
// 3. 比大小
// Scanner 要求输入两个数字进行比较，a,b
        Scanner sc = new Scanner(System.in);
        System.out.println("请用户输入第一个数字：");
//        String text = sc.nextLine();接收文本
//        int a = sc.nextInt(); // 接收int整型数字 小数 float
//        float a = sc.nextFloat(); // 接收数字
        double a = sc.nextDouble();
        System.out.println("请用户输入第二个数字：");
        double b = sc.nextDouble(); // 接收数字
        if (a > b){
            System.out.println("a 大于 b");
        }
        else if(a < b){
            System.out.println("a 小于 b");
        }
        else{
            System.out.println("a 等于 b");
        }
```

## 真实案例

结合对话式Ai去分析项目

https://chat.deepseek.com/share/gp2a3plvkty1zxcqnd

```java
// TODO 1: 使用 for-each 逐项显示 items。
System.out.println("[待完成] 显示所有物品");
// TODO 2: 现在只执行一轮。把 if 改成能重复运行的循环。
        if (running) {
// TODO 3: 改成“不区分大小写，名称包含关键字”的判断。
            boolean matches = false;
            
if (matches) {
                System.out.println("找到：" + item);
                // TODO 4: 记录已经找到至少一项。
            }
```

iter for-each快捷键

List<String> items = Arrays.asList();

equals、nextLine()、trim() 

```java
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class WarehouseBasics {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<String> items = Arrays.asList(
                "螺丝刀",
                "Keyboard",
                "打印纸",
                "安全帽"
        );

        boolean running = true;

        // TODO 2: 现在只执行一轮。把 if 改成能重复运行的循环。
        if (running) {
            printMenu();
            String choice = scanner.nextLine().trim();

            if ("1".equals(choice)) {
                // TODO 1: 使用 for-each 逐项显示 items。
                System.out.println("[待完成] 显示所有物品");
            } else if ("2".equals(choice)) {
                System.out.print("请输入搜索关键字：");
                String keyword = scanner.nextLine().trim();

                if (keyword.isEmpty()) {
                    System.out.println("搜索关键字不能为空。");
                } else {
                    searchItems(items, keyword);
                }
            } else if ("0".equals(choice)) {
                running = false;
                System.out.println("已退出 103 仓库基础练习。");
            } else {
                System.out.println("无效选项：请输入 1、2 或 0。你输入的是：" + choice);
            }
        }

        scanner.close();
    }

    static void printMenu() {
        System.out.println();
        System.out.println("===== 103 仓库基础练习 =====");
        System.out.println("1. 查看所有物品");
        System.out.println("2. 按名称搜索");
        System.out.println("0. 退出");
        System.out.print("请选择：");
    }

    static void searchItems(List<String> items, String keyword) {
        boolean found = false;

        for (String item : items) {
            // TODO 3: 改成“不区分大小写，名称包含关键字”的判断。
            boolean matches = false;

            if (matches) {
                System.out.println("找到：" + item);
                // TODO 4: 记录已经找到至少一项。
            }
        }

        if (!found) {
            System.out.println("未找到包含“" + keyword + "”的物品。");
        }
    }
}
```

---

IDEA 软件Java

中文扩展包

![image-20261018204524413](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20261018204524413.png)

Sample Code 示例代码

新建项目

![image-20261018204749879](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20261018204749879.png)

![image-20261018204950259](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20261018204950259.png)

Ctrl+F5 运行（部分电脑Ctrl+Fn+F5）

打开项目
![image-20261018211906534](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20261018211906534.png)



---

```java

```

```java

```

```java
// 3. 比大小
// Scanner 要求输入两个数字进行比较，a,b
        Scanner sc = new Scanner(System.in);
        System.out.println("请用户输入第一个数字：");
//        String text = sc.nextLine();接收文本
//        int a = sc.nextInt(); // 接收int整型数字 小数 float
//        float a = sc.nextFloat(); // 接收数字
        double a = sc.nextDouble();
        System.out.println("请用户输入第二个数字：");
        double b = sc.nextDouble(); // 接收数字
        if (a > b){
            System.out.println("a 大于 b");
        }
        else if(a < b){
            System.out.println("a 小于 b");
        }
        else{
            System.out.println("a 等于 b");
        }
```

