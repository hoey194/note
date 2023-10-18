---
title: Flink Timer定时器
abbrlink: e9455fee
date: 2023-07-24 17:24:24
tags:
---



在使用processFunction实现两张事实表的JOIN操作时，接触到了Timer，下面对Flink定时器的核心知识做一个简单总结：

### 1.1 Timers支持使用在KeyedStream

因为 Timer 是基于每个键即 key 注册并触发，所以 KeyedStream 是 Timer 在 Flink 中使用的先决条件

```java
ctx.timerService.deleteEventTimeTimer(timeStamp)
```

### 1.2 Timers的唯一性

TimerService 会自动消除计时器的重复数据，始终保持每个键 key 最多只有一个计时器，当一个键 key 注册多个 Timer 计时器时，onTimer 方法只会调用一次，重复注册会覆盖之前的 timer 注册

### 1.3 Timers支持checkpoint

ValueState 可以通过 checkpoint 进行检查点保存和恢复，同理 Timer 也可以由 checkpoint 托管，从 Flink checkpoint 检查点恢复任务时，将立即启动恢复前应启动的处于恢复状态的每个已注册计时器，这也提高了 Timer 的容错性

### 1.4 Timers支持被删除

从 Flink 1.6.x 开始，计时器可以暂停和删除，提供更便捷的 Timer 处理方式



文章发布自：[Flink Timer 与 TimerService 源码分析与详解](https://it.cha138.com/ios/show-36808.html#2.1 注册 Timer)

写的十分好，推荐阅读，除此之外推荐阅读：

[Flink Timer 机制原理，源码整理](https://it.cha138.com/mysql/show-110719.html)

[Flink的定时器EventTime和ProcessTime](https://it.cha138.com/shida/show-452473.html)

[Flink使用CoProcessFunction完成实时对账、基于时间的双流join_flink实时对账](https://blog.csdn.net/weixin_43923463/article/details/128043877)

