# Java 基础速查

> 课堂可查，不要求背诵。先看输入、预期和实际结果，再决定改哪一处。

## 输出与变量

```java
String name = "螺丝刀";
System.out.println("物品：" + name);
```

## 读取整行输入

```java
Scanner scanner = new Scanner(System.in);
String choice = scanner.nextLine().trim();
```

- `nextLine()` 读取一整行文字。
- `trim()` 去掉首尾空白。
- 输入文字保存在变量中，后续分支使用这个变量。

## 比较字符串内容

```java
if ("1".equals(choice)) {
    System.out.println("查看物品");
}
```

本课不要用 `choice == "1"` 比较输入内容。

## 多条分支

```java
if ("1".equals(choice)) {
    // 查看
} else if ("2".equals(choice)) {
    // 搜索
} else if ("0".equals(choice)) {
    // 退出
} else {
    // 未知输入
}
```

## 重复与退出

```java
boolean running = true;

while (running) {
    // 菜单逻辑

    if ("0".equals(choice)) {
        running = false;
    }
}
```

## 判断空字符串

```java
String keyword = scanner.nextLine().trim();

if (keyword.isEmpty()) {
    System.out.println("搜索关键字不能为空。");
}
```

## List 与逐项遍历

```java
List<String> items = Arrays.asList(
        "螺丝刀",
        "Keyboard",
        "打印纸",
        "安全帽"
);

for (String item : items) {
    System.out.println(item);
}
```

每一轮，`item` 代表列表中的一项。

## 不区分大小写的部分匹配

```java
boolean matches = item.toLowerCase()
        .contains(keyword.toLowerCase());
```

搜索 `key` 可以匹配 `Keyboard`。

## 阅读一个方法

```java
searchItems(items, keyword); // 调用

static void searchItems(List<String> items, String keyword) {
    // 方法内容
}
```

阅读时只回答：传入什么、执行什么、在哪里调用。

## 最小排错顺序

1. 是编译失败、结果不对，还是环境没启动？
2. 记录输入、预期和实际。
3. 编译错误先看第一条错误和对应行。
4. 结果错误先找处理这个输入的分支。
5. 一次只改一小处，重新编译和运行。

