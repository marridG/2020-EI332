<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>

# EI332 Finals Review

<br>


## Table of Contents
<!-- MarkdownTOC -->

- [01 Introduction](#01-introduction)
    - [Architecture v.s. Organization](#architecture-vs-organization)
    - [Structure v.s. Function](#structure-vs-function)
    - [Computer Functions](#computer-functions)
- [02 Computer Evolution and Performance](#02-computer-evolution-and-performance)
    - [Von Neumann/Turing Structure](#von-neumannturing-structure)
    - [Moore's Law](#moores-law)
    - [Performance](#performance)
    - [Embedded Systems: RISC -> ARM](#embedded-systems-risc---arm)
    - [Calculations](#calculations)
- [03 Top Level View of Computer Function and Interconnection](#03-top-level-view-of-computer-function-and-interconnection)
    - [Computer Components: CPU, I/O, Main Memory](#computer-components-cpu-io-main-memory)
    - [Instruction Cycle](#instruction-cycle)
    - [Interrupts](#interrupts)
        - [Basis](#basis)
        - [Multiple Interrupts](#multiple-interrupts)
    - [Bus](#bus)
        - [Data Bus](#data-bus)
        - [Address Bus](#address-bus)
        - [Control Bus](#control-bus)
        - [Implementation](#implementation)
        - [Synchronous v.s. Asynchronous](#synchronous-vs-asynchronous)
- [04a Instructions Language of the Computer](#04a-instructions-language-of-the-computer)
    - [架构 ↔ 指令集](#%E6%9E%B6%E6%9E%84-%E2%86%94-%E6%8C%87%E4%BB%A4%E9%9B%86)
    - [地址线例子 & 地址存量](#%E5%9C%B0%E5%9D%80%E7%BA%BF%E4%BE%8B%E5%AD%90--%E5%9C%B0%E5%9D%80%E5%AD%98%E9%87%8F)
    - [字节编址和字访问](#%E5%AD%97%E8%8A%82%E7%BC%96%E5%9D%80%E5%92%8C%E5%AD%97%E8%AE%BF%E9%97%AE)
    - [指令类型](#%E6%8C%87%E4%BB%A4%E7%B1%BB%E5%9E%8B)
    - [历史](#%E5%8E%86%E5%8F%B2)
- [04b Instructions Language of the Computer](#04b-instructions-language-of-the-computer)
    - [数的表示与符号扩展](#%E6%95%B0%E7%9A%84%E8%A1%A8%E7%A4%BA%E4%B8%8E%E7%AC%A6%E5%8F%B7%E6%89%A9%E5%B1%95)
    - [MIPS 指令](#mips-%E6%8C%87%E4%BB%A4)
- [04c Instructions Language of the Computer](#04c-instructions-language-of-the-computer)
    - [MIPS 指令（续）](#mips-%E6%8C%87%E4%BB%A4%EF%BC%88%E7%BB%AD%EF%BC%89)
        - [逻辑和算数运算](#%E9%80%BB%E8%BE%91%E5%92%8C%E7%AE%97%E6%95%B0%E8%BF%90%E7%AE%97)
        - [条件转移和分支指令](#%E6%9D%A1%E4%BB%B6%E8%BD%AC%E7%A7%BB%E5%92%8C%E5%88%86%E6%94%AF%E6%8C%87%E4%BB%A4)
        - [循环操作的例子](#%E5%BE%AA%E7%8E%AF%E6%93%8D%E4%BD%9C%E7%9A%84%E4%BE%8B%E5%AD%90)
- [04d Instructions Language of the Computer](#04d-instructions-language-of-the-computer)
    - [MIPS 指令（续）](#mips-%E6%8C%87%E4%BB%A4%EF%BC%88%E7%BB%AD%EF%BC%89-1)
        - [过程调用设计实现](#%E8%BF%87%E7%A8%8B%E8%B0%83%E7%94%A8%E8%AE%BE%E8%AE%A1%E5%AE%9E%E7%8E%B0)
    - [栈](#%E6%A0%88)
- [05a The Processor](#05a-the-processor)
- [05b The Processor](#05b-the-processor)
    - [流水线介绍](#%E6%B5%81%E6%B0%B4%E7%BA%BF%E4%BB%8B%E7%BB%8D)
- [05c The Processor](#05c-the-processor)
    - [流水线冒险](#%E6%B5%81%E6%B0%B4%E7%BA%BF%E5%86%92%E9%99%A9)
        - [结构冒险](#%E7%BB%93%E6%9E%84%E5%86%92%E9%99%A9)
        - [数据冒险](#%E6%95%B0%E6%8D%AE%E5%86%92%E9%99%A9)
        - [控制冒险](#%E6%8E%A7%E5%88%B6%E5%86%92%E9%99%A9)
- [06a Large and Fast: Exploiting Memory Hierachy](#06a-large-and-fast-exploiting-memory-hierachy)
    - [存储器](#%E5%AD%98%E5%82%A8%E5%99%A8)
        - [存储器的层次结构](#%E5%AD%98%E5%82%A8%E5%99%A8%E7%9A%84%E5%B1%82%E6%AC%A1%E7%BB%93%E6%9E%84)
    - [Cache 介绍](#cache-%E4%BB%8B%E7%BB%8D)
        - [局部性原理](#%E5%B1%80%E9%83%A8%E6%80%A7%E5%8E%9F%E7%90%86)
        - [Cache 映射](#cache-%E6%98%A0%E5%B0%84)
        - [Cache 数据结构和查找](#cache-%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E5%92%8C%E6%9F%A5%E6%89%BE)
        - [Cache 数据替换](#cache-%E6%95%B0%E6%8D%AE%E6%9B%BF%E6%8D%A2)
        - [写 Cache](#%E5%86%99-cache)
        - [Cache 性能](#cache-%E6%80%A7%E8%83%BD)
- [06b Large and Fast: Exploiting Memory Hierachy](#06b-large-and-fast-exploiting-memory-hierachy)
    - [虚拟存储器](#%E8%99%9A%E6%8B%9F%E5%AD%98%E5%82%A8%E5%99%A8)
        - [概念](#%E6%A6%82%E5%BF%B5)
        - [页表访问](#%E9%A1%B5%E8%A1%A8%E8%AE%BF%E9%97%AE)
        - [页表优化：快表 TLB](#%E9%A1%B5%E8%A1%A8%E4%BC%98%E5%8C%96%EF%BC%9A%E5%BF%AB%E8%A1%A8-tlb)
- [Chapter 6 Storage and Other I/O Topics](#chapter-6-storage-and-other-io-topics)
    - [概念](#%E6%A6%82%E5%BF%B5-1)
    - [其他](#%E5%85%B6%E4%BB%96)
- [07 Multicores, Multiprocessors and Clusters](#07-multicores-multiprocessors-and-clusters)
    - [多处理器组织方式](#%E5%A4%9A%E5%A4%84%E7%90%86%E5%99%A8%E7%BB%84%E7%BB%87%E6%96%B9%E5%BC%8F)
    - [多核，集群 \(Cluster\)，多线程](#%E5%A4%9A%E6%A0%B8%EF%BC%8C%E9%9B%86%E7%BE%A4-cluster%EF%BC%8C%E5%A4%9A%E7%BA%BF%E7%A8%8B)
- [Chapter 3 Arithmetic for Computers](#chapter-3-arithmetic-for-computers)
    - [整数表示和运算](#%E6%95%B4%E6%95%B0%E8%A1%A8%E7%A4%BA%E5%92%8C%E8%BF%90%E7%AE%97)
    - [浮点数表示和运算](#%E6%B5%AE%E7%82%B9%E6%95%B0%E8%A1%A8%E7%A4%BA%E5%92%8C%E8%BF%90%E7%AE%97)
- [其他](#%E5%85%B6%E4%BB%96-1)
    - [时序逻辑 & 组合逻辑](#%E6%97%B6%E5%BA%8F%E9%80%BB%E8%BE%91--%E7%BB%84%E5%90%88%E9%80%BB%E8%BE%91)

<!-- /MarkdownTOC -->

<br>


<a id="01-introduction"></a>
## 01 Introduction
<a id="architecture-vs-organization"></a>
#### Architecture v.s. Organization
<a id="structure-vs-function"></a>
#### Structure v.s. Function
<a id="computer-functions"></a>
#### Computer Functions
+ Data Processing
+ Data Storage
+ Data Movement
+ Control



<br><br>

<a id="02-computer-evolution-and-performance"></a>
## 02 Computer Evolution and Performance

<a id="von-neumannturing-structure"></a>
#### Von Neumann/Turing Structure
+ IAS computer

<a id="moores-law"></a>
#### Moore's Law

<a id="performance"></a>
#### Performance
+ Power Wall: $ Power = Capacitive Load \times Voltage^2 \times Frequency $
+ Solutions
    * increase cache capacity
    * more complex execution logic: pipeline, superscalar(单处理器多流水线)
    * multiple cores (e.g. x86)

<a id="embedded-systems-risc---arm"></a>
#### Embedded Systems: RISC -> ARM

<a id="calculations"></a>
####  Calculations
+ $ Performance = 1/ Execution Time $
+ Clock Period: duration of a clock cycle
+ Clock Frequency / Rate: cycles per second
+ $ CPU Time = CPU Clock Cycles \times Clock Cycle Time = CPU Clock Cycles / Clock Rate $
+ G: $ 10^9 $
+ Instruction Count, CPI(average Cycles Per Instruction)
    * $ Clock Cycles = Instruction Count \times CPI $
    * $ CPU Time = Instruction Count \times CPI \times Clock Cycle Time $
+ MIPS: Millions of Instructions Per Second
    



<br><br>

<a id="03-top-level-view-of-computer-function-and-interconnection"></a>
## 03 Top Level View of Computer Function and Interconnection
<a id="computer-components-cpu-io-main-memory"></a>
#### Computer Components: CPU, I/O, Main Memory

<a id="instruction-cycle"></a>
#### Instruction Cycle
+ Fetch
+ Execute

<a id="interrupts"></a>
#### Interrupts

<a id="basis"></a>
###### Basis
+ Marked by an interrupt signal
+ Save context (register, program status, PC) & restore context
+ PC not changed

<a id="multiple-interrupts"></a>
###### Multiple Interrupts

+ Disable
+ Priorities: Sequential, Nested

<a id="bus"></a>
#### Bus

<a id="data-bus"></a>
###### Data Bus

+ Carries Data
+ Width determines performance

<a id="address-bus"></a>
###### Address Bus
+ Identify src/dest of data
+ Width determines Maximum Memory Capacity (20 bit -> $ 2^20 = 1M $)

<a id="control-bus"></a>
###### Control Bus

<a id="implementation"></a>
###### Implementation
+ ISA - Traditional (with cache)
+ High Performance Bus

<a id="synchronous-vs-asynchronous"></a>
###### Synchronous v.s. Asynchronous
+ Synchronous: controlled by clock signals
+ Asynchronous



<br><br>

<a id="04a-instructions-language-of-the-computer"></a>
## 04a Instructions Language of the Computer

<a id="%E6%9E%B6%E6%9E%84-%E2%86%94-%E6%8C%87%E4%BB%A4%E9%9B%86"></a>
#### 架构 ↔ 指令集
+ MIPS, ARM, x86
    * 操作数来源
        - MIPS: 仅来源于 (约) 32 个寄存器
        - x86: 可以直接来自内存
        - ARM： (约) 16 个寄存器

<a id="%E5%9C%B0%E5%9D%80%E7%BA%BF%E4%BE%8B%E5%AD%90--%E5%9C%B0%E5%9D%80%E5%AD%98%E9%87%8F"></a>
#### 地址线例子 & 地址存量
若有 32 根地址线，则寻址范围为 4G，每个地址对应内存大小 8 bits

+ 寻址范围只与地址线宽度有关，与数据线(影响传输性能)无关
+ 每个地址对应的内存大小规定为 8 bits (8 位，即 1 字节)

<a id="%E5%AD%97%E8%8A%82%E7%BC%96%E5%9D%80%E5%92%8C%E5%AD%97%E8%AE%BF%E9%97%AE"></a>
#### 字节编址和字访问
+ (LOCATION ++) 大端模式 (MSB->LSB) 与小端模式 (LSB->MSB)
+ index register 寻址方式：\[offset] + \[base/index register]

<a id="%E6%8C%87%E4%BB%A4%E7%B1%BB%E5%9E%8B"></a>
#### 指令类型
+ MIPS 指令：无立即数参与运算
+ RISC 指令：有立即数参与运算
    * 4 字节

<a id="%E5%8E%86%E5%8F%B2"></a>
#### 历史
+ CISC -> RISC: 更基础、更通用

    | 风格  | 指令集             | 长度、格式、寻址方式  | 访存方式 | 寄存器     | 执行一条指令时间      | 控制       |
    | ---  | ---                | ---                | ----    | ---        | ---                 | ---        |
    | CISC | 指令集很大          | 多                 | 自由访存 | 多为专用   | 常需多个时钟周期      | 微程序控制  |
    | RISC | 使用频率高的指令构成 | 少                 | 特定指令 | 多个寄存器 | 流水技术，一个时钟周期 | 组合逻辑    |



<br><br>

<a id="04b-instructions-language-of-the-computer"></a>
## 04b Instructions Language of the Computer

<a id="%E6%95%B0%E7%9A%84%E8%A1%A8%E7%A4%BA%E4%B8%8E%E7%AC%A6%E5%8F%B7%E6%89%A9%E5%B1%95"></a>
#### 数的表示与符号扩展
+ 有符号和无符号数的表示
+ 求负
+ 符号扩展
    * 算数运算：保持正负，在前部填充高符号位，即零(正)/一(负)
    * 逻辑运算：直接在前部填充零

<a id="mips-%E6%8C%87%E4%BB%A4"></a>
#### MIPS 指令
+ 32 位
+ R 型: op + rs + rt + rd + sa + func (6, 5, 5, 5, 5, 6)
    * 地址符号扩展 5 -> 32 位
    * add, sub, and, or, xor... (e.g. add rd rs rt)
+ I 型: op + rs + rt + imm (6, 5, 5, 16)
    * 地址符号扩展 5 -> 32 位
    * 立即数符号扩展 16 -> 32 位
    * addi, andi, lw, sw (e.g. addi rt rs imm)
+ J 型: op + addr (6, 26)




<br><br>

<a id="04c-instructions-language-of-the-computer"></a>
## 04c Instructions Language of the Computer
<a id="mips-%E6%8C%87%E4%BB%A4%EF%BC%88%E7%BB%AD%EF%BC%89"></a>
#### MIPS 指令（续）

<a id="%E9%80%BB%E8%BE%91%E5%92%8C%E7%AE%97%E6%95%B0%E8%BF%90%E7%AE%97"></a>
###### 逻辑和算数运算
+ sll, srl, and, or, xor... 

<a id="%E6%9D%A1%E4%BB%B6%E8%BD%AC%E7%A7%BB%E5%92%8C%E5%88%86%E6%94%AF%E6%8C%87%E4%BB%A4"></a>
###### 条件转移和分支指令
+ beq, bne (beq rs rt imm)
+ rs rt 等(不等)，则 PC 转移到 PC + 4 + (sign)imm * 4

<a id="%E5%BE%AA%E7%8E%AF%E6%93%8D%E4%BD%9C%E7%9A%84%E4%BE%8B%E5%AD%90"></a>
###### 循环操作的例子




<br><br>

<a id="04d-instructions-language-of-the-computer"></a>
## 04d Instructions Language of the Computer
<a id="mips-%E6%8C%87%E4%BB%A4%EF%BC%88%E7%BB%AD%EF%BC%89-1"></a>
#### MIPS 指令（续）
<a id="%E8%BF%87%E7%A8%8B%E8%B0%83%E7%94%A8%E8%AE%BE%E8%AE%A1%E5%AE%9E%E7%8E%B0"></a>
###### 过程调用设计实现
+ jal: 保存返回地址（即进阶的下一条指令的地址），跳转
    * J 型: jal addr (6+26)
+ jr: 跳转到寄存器所指定的地址
    * R 型: jr rs (6+5+ 000..000)

<a id="%E6%A0%88"></a>
#### 栈
+ PUSH: 栈顶指针上移（往小端地址）
+ POP：栈顶指针下移（往大端地址）
+ 进出栈编译实现




<br><br>

<a id="05a-the-processor"></a>
## 05a The Processor

<a id="05b-the-processor"></a>
## 05b The Processor
<a id="%E6%B5%81%E6%B0%B4%E7%BA%BF%E4%BB%8B%E7%BB%8D"></a>
#### 流水线介绍
+ 流水线减少指令的平均执行时间
+ 硬件实现，编程者无法控制
+ MIPS 流水线
    * 流水段
        - IF: 从内存中读取指令
        - ID: 指令译码的同时读取寄存器
        - EX: 执行操作或计算地址
        - MEM: 在数据存储器中读取操作数
        - WB: 将结果写回寄存器
+ 流水线寄存器
    * IF/ID, ID/EX, EX/MEM, MEM/WB
    * 各段之间加入
    * 保证流水线在不同段中的指令不相互影响
    * 每个时钟周期结束后保存执行结果，下个时钟周期作为输入加载
    * 流水线传递所有可能有用的信息
+ 流水线工作
    * lw 目标寄存器的问题：ID/EX 逐级传到 MEM/WB
+ 控制信号的流水线传递
+ 单周期 CPU => 分隔成级 => 五级流水线 CPU





<br><br>

<a id="05c-the-processor"></a>
## 05c The Processor
<a id="%E6%B5%81%E6%B0%B4%E7%BA%BF%E5%86%92%E9%99%A9"></a>
#### 流水线冒险
<a id="%E7%BB%93%E6%9E%84%E5%86%92%E9%99%A9"></a>
###### 结构冒险
+ 硬件资源冲突
+ 解决方案
    * 插入气泡/停顿周期 (NOP)
        - PC, IF/ID 保持不变
        - 控制信号全部置零/无效

<a id="%E6%95%B0%E6%8D%AE%E5%86%92%E9%99%A9"></a>
###### 数据冒险
+ 指令执行依赖数据缺失
+ 解决方案
    - 插入气泡/停顿周期 (NOP): lw
    - 转发直通/旁路
        + EX/MEM, MEM/WB -> ALU MUX
        + 检测方式
            * 分情况考虑
            * 考虑不写寄存器的不必要转发
            * 考虑特殊的零号寄存器
            * 注意前第二条指令判断时，也需要判断是否和前一条产生冒险
        

<a id="%E6%8E%A7%E5%88%B6%E5%86%92%E9%99%A9"></a>
###### 控制冒险
+ 跳转转移指令、改写 PC 指令等造成的冒险
+ 往往造成的损失最大
+ 解决方案
    * 冻结或冲刷流水线
    * 调度转移延迟槽
    * 动态分支预测




<br><br>

<a id="06a-large-and-fast-exploiting-memory-hierachy"></a>
## 06a Large and Fast: Exploiting Memory Hierachy
<a id="%E5%AD%98%E5%82%A8%E5%99%A8"></a>
#### 存储器
<a id="%E5%AD%98%E5%82%A8%E5%99%A8%E7%9A%84%E5%B1%82%E6%AC%A1%E7%BB%93%E6%9E%84"></a>
###### 存储器的层次结构
+ SRAM 性能优于 DRAM


<a id="cache-%E4%BB%8B%E7%BB%8D"></a>
#### Cache 介绍
<a id="%E5%B1%80%E9%83%A8%E6%80%A7%E5%8E%9F%E7%90%86"></a>
###### 局部性原理
+ Cache 命中
+ Cache 缺失
+ 时间局部性：将来会被再次访问，存储是有意义的
+ 空间局部性：其他数据将来会被再次访问

<a id="cache-%E6%98%A0%E5%B0%84"></a>
###### Cache 映射
+ 直接映射：块地址 mod Cache 块数 (e.g. \#12 mod 8块 => 块4)
    * 简单
    * 易冲突
+ 全相连映射：随机放到空的地方
    * 不易冲突
    * 映射复杂
+ 组相联映射：Cache 分组再“直接映射”，组内几块即为几路组相连；块地址 mod Cache 组数 (e.g. \#12 mod 3组 => 组0)
    * 兼具二者的优缺点

<a id="cache-%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E5%92%8C%E6%9F%A5%E6%89%BE"></a>
###### Cache 数据结构和查找
+ 地址部分：标志对应的主存块地址
+ 有效位
+ 例子：256 组的两路组相连
    * Cache 数据结构 (40 bits)：标志(25), 组号(9), 偏移量(6)

<a id="cache-%E6%95%B0%E6%8D%AE%E6%9B%BF%E6%8D%A2"></a>
###### Cache 数据替换
+ 随机替换
+ 最近最少使用 (LRU)
+ 先进先出 (FIFO)

<a id="%E5%86%99-cache"></a>
###### 写 Cache
+ 写直达法：同时写到 Cache 和低层存储块
+ 写回法：只写到 Cache，被替换的写到低层存储块
    * 重写位/脏位：避免无改写的写回
+ 写缺失：写一个不在 Cache 中的数据
    * 写分配：读到 Cache 中执行写；常与写回法匹配
    * 不按写分配：直接写主存，Cache 不变；常与写直达法匹配

<a id="cache-%E6%80%A7%E8%83%BD"></a>
###### Cache 性能
+ 评价方法：平均存储器访问时间
+ $ 平均存储器访问时间 = 命中时间 + 缺失率 \times 缺失代价 $
+ 多级 Cache 降低缺失代价
    * 局部缺失率
    * 全局缺失率





<br><br>

<a id="06b-large-and-fast-exploiting-memory-hierachy"></a>
## 06b Large and Fast: Exploiting Memory Hierachy
<a id="%E8%99%9A%E6%8B%9F%E5%AD%98%E5%82%A8%E5%99%A8"></a>
#### 虚拟存储器
<a id="%E6%A6%82%E5%BF%B5"></a>
###### 概念
+ 目的：解决大的程序寻址空间和小的物理主存空间的矛盾
+ 虚拟地址连续，但对应的真实地址不一定连续
+ 磁盘块和内存：全相连
+ 查找：页表
+ 虚拟存储器缺失替换原则：LRU
+ 写操作原则：写回法

<a id="%E9%A1%B5%E8%A1%A8%E8%AE%BF%E9%97%AE"></a>
###### 页表访问
+ 物理内存中的页表起始地址寄存器
+ 虚拟地址页号
+ 页内偏移
+ 得到真实地址访存

<a id="%E9%A1%B5%E8%A1%A8%E4%BC%98%E5%8C%96%EF%BC%9A%E5%BF%AB%E8%A1%A8-tlb"></a>
###### 页表优化：快表 TLB
+ 频繁访问的页表存储在 Cache 中，全相连
+ 查找：使用相连存储器





<br><br>
<a id="chapter-6-storage-and-other-io-topics"></a>
## Chapter 6 Storage and Other I/O Topics
<a id="%E6%A6%82%E5%BF%B5-1"></a>
#### 概念
+ 可靠性：MTTF / MTBF = MTTF / (MTTF + MTTR)
+ 联结：处理器-存储器 Bus V.S. I/O Bus
+ 数据、控制线；同步、异步
+ 地址映射
+ 通信控制
    * 轮询 (polling)：间歇性询问设备状态，若可执行操作
    * 中断：设备请求中断
    * DMA：CPU 直接下放权限存储器权限

<a id="%E5%85%B6%E4%BB%96"></a>
#### 其他
+ 磁盘阵列 RAID
+ 服务器





<br><br>
<a id="07-multicores-multiprocessors-and-clusters"></a>
## 07 Multicores, Multiprocessors and Clusters
<a id="%E5%A4%9A%E5%A4%84%E7%90%86%E5%99%A8%E7%BB%84%E7%BB%87%E6%96%B9%E5%BC%8F"></a>
#### 多处理器组织方式
+ 分类
    * 一致性内存访问
    * 非一致性内存访问
    * Cache 一直的非一致内存访问
+ 共享主存的多处理器结构（注意 Cache 一致性）：监听标记
+ 网络连接的多处理器结构（分布式主存）
+ 同步
    * 无全局统一地址空间：消息通讯
    * 共享地址空间：原子交换加锁：一个总线操作周期读写一个地址，不可被打断

<a id="%E5%A4%9A%E6%A0%B8%EF%BC%8C%E9%9B%86%E7%BE%A4-cluster%EF%BC%8C%E5%A4%9A%E7%BA%BF%E7%A8%8B"></a>
#### 多核，集群 (Cluster)，多线程
+ 多线程
    * 细粒度多线程：每条指令后切换线程
    * 粗粒度多线程：遇到阻塞等大开销时切换线程
    * 同时多线程：线程级并行、指令级并行






<br><br>
<a id="chapter-3-arithmetic-for-computers"></a>
## Chapter 3 Arithmetic for Computers
<a id="%E6%95%B4%E6%95%B0%E8%A1%A8%E7%A4%BA%E5%92%8C%E8%BF%90%E7%AE%97"></a>
#### 整数表示和运算
+ $ X + X\ba = -1 $
+ 溢出
    * 下溢：abs < min abs
    * 上溢：abs > max abs
+ 减法：A - B = A + (-B)
+ 乘法：和竖式类似，被乘数(64)靠右全部不断左移，乘数(32)靠右不断右移但只取末位，寄存器(64)中累积
    * 面积减半改良
    * 增加加法器提升速度
    * 流水加法器
+ 除法：和竖式类似但有一点区别，余数(64)靠右，除数(64)靠左，不断减去 0/1 倍的除数（通过测试+恢复），商(32)左移，除数右移
    * 面积减半改良
    * SRT
    * 不能流水


<a id="%E6%B5%AE%E7%82%B9%E6%95%B0%E8%A1%A8%E7%A4%BA%E5%92%8C%E8%BF%90%E7%AE%97"></a>
#### 浮点数表示和运算
+ 符号(1) + 指数(8/11) + 数值(23/52)
+ $ x = (-1)^{s} \times (1 + 数值) \times 2^{指数 - bias} $
    * bias: single 127，double 1023
+ 指数 000..000, 111...111 不能使用
+ 加法：对齐指数，数值相加
+ 乘法：指数相加（若有 bias 需要减去一次），数值相乘
 



<br><br>

<a id="%E5%85%B6%E4%BB%96-1"></a>
## 其他
<a id="%E6%97%B6%E5%BA%8F%E9%80%BB%E8%BE%91--%E7%BB%84%E5%90%88%E9%80%BB%E8%BE%91"></a>
#### 时序逻辑 & 组合逻辑
+ 组合逻辑：输出只是当前输入逻辑电平的函数（有延时），与电路的原始状态无关
+ 时序逻辑：输出不仅是当前输入电平的函数，还与目前电路的状态有关
+ Memory 默认是组合逻辑


