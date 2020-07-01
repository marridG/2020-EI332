# Lab 2 单周期 CPU 的 IO 接口模块设计仿真 实验报告
EI332 计算机组成 SJTU, 2020 Spring  
  

<br>

## 目录
<!-- MarkdownTOC -->

- [实验目的](#%E5%AE%9E%E9%AA%8C%E7%9B%AE%E7%9A%84)
- [实验要求](#%E5%AE%9E%E9%AA%8C%E8%A6%81%E6%B1%82)
- [IO 模块设计实现](#io-%E6%A8%A1%E5%9D%97%E8%AE%BE%E8%AE%A1%E5%AE%9E%E7%8E%B0)
    - [修改 `sc_computer.v` 中的模块](#%E4%BF%AE%E6%94%B9-sc_computerv-%E4%B8%AD%E7%9A%84%E6%A8%A1%E5%9D%97)
    - [编写 `clk_and_mem_clk.v` 中的模块](#%E7%BC%96%E5%86%99-clk_and_mem_clkv-%E4%B8%AD%E7%9A%84%E6%A8%A1%E5%9D%97)
    - [编写 `in_port.v` 中的模块](#%E7%BC%96%E5%86%99-in_portv-%E4%B8%AD%E7%9A%84%E6%A8%A1%E5%9D%97)
    - [编写 `out_port_seg.v` 中的模块](#%E7%BC%96%E5%86%99-out_port_segv-%E4%B8%AD%E7%9A%84%E6%A8%A1%E5%9D%97)
    - [编写 `test.v` 顶层文件](#%E7%BC%96%E5%86%99-testv-%E9%A1%B6%E5%B1%82%E6%96%87%E4%BB%B6)
    - [波形仿真结果验证](#%E6%B3%A2%E5%BD%A2%E4%BB%BF%E7%9C%9F%E7%BB%93%E6%9E%9C%E9%AA%8C%E8%AF%81)
- [【选做】指令扩展](#%E3%80%90%E9%80%89%E5%81%9A%E3%80%91%E6%8C%87%E4%BB%A4%E6%89%A9%E5%B1%95)
    - [修改 `alu.v`，扩展功能](#%E4%BF%AE%E6%94%B9-aluv%EF%BC%8C%E6%89%A9%E5%B1%95%E5%8A%9F%E8%83%BD)
    - [修改 `sc_cu.v`，扩展功能](#%E4%BF%AE%E6%94%B9-sc_cuv%EF%BC%8C%E6%89%A9%E5%B1%95%E5%8A%9F%E8%83%BD)
    - [转译新增指令，修改 `sc_instmem.mif` 初始化文件](#%E8%BD%AC%E8%AF%91%E6%96%B0%E5%A2%9E%E6%8C%87%E4%BB%A4%EF%BC%8C%E4%BF%AE%E6%94%B9-sc_instmemmif-%E5%88%9D%E5%A7%8B%E5%8C%96%E6%96%87%E4%BB%B6)
    - [波形仿真结果验证](#%E6%B3%A2%E5%BD%A2%E4%BB%BF%E7%9C%9F%E7%BB%93%E6%9E%9C%E9%AA%8C%E8%AF%81-1)
- [实验总结](#%E5%AE%9E%E9%AA%8C%E6%80%BB%E7%BB%93)

<!-- /MarkdownTOC -->


<a id="%E5%AE%9E%E9%AA%8C%E7%9B%AE%E7%9A%84"></a>
## 实验目的
1. 在理解计算机五大组成部分的协调工作原理，理解存储程序自动执行的原理和掌握运算器、存储器、控制器的设计和实现原理基础上，掌握 I/O 端口的设计方法，理解 I/O 地址空间的设计方法。
2. 通过设计 I/O 端口与外部设备进行信息交互。
3. （选做）通过设计并实现新的自定义指令拓展 CPU 功能深入理解 CPU 对指令的译码、执行原理和实现方式。

<a id="%E5%AE%9E%E9%AA%8C%E8%A6%81%E6%B1%82"></a>
## 实验要求
1. 采用 `Verilog` 硬件描述语言在 Quartus II EDA 设计平台中，基于 Intel cyclone II 系列 FPGA 完成具有执行 20 条 MIPS 基本指令的单周期 CPU 的输入输出部件，亦即进行 I/O 接口扩展模块设计。在之前 提供并自行补充已完成的单周期 CPU 模块基础上，添加对 I/O 的内部相应处理并添加 I/O 接口 模块，实现 CPU 对外设的 I/O 访问。
2. 利用实验提供的标准测试程序代码，对单周期 CPU 的 I/O 模块进行功能仿真测试，要求CPU能够采用查询方式模拟接收 输入 按键或开关的状态，并产生相应的输出状态驱动模拟数码管显示结果从而验证 CPU 可正确执行 I/O 读写指令。
3. （选做）自行设计添加一条新的 CPU 指令，修改 CPU 控制部件和执行部件模块代码，支持新指令的操作，并 通过仿真验证功能的正确性。




<br>


<a id=""></a>
<a id="io-%E6%A8%A1%E5%9D%97%E8%AE%BE%E8%AE%A1%E5%AE%9E%E7%8E%B0"></a>
## IO 模块设计实现
根据实验指导中的相关要求，采用两个 LED 数码管以被“加数”、“加数”（十进制）的形式，作为系统输入；采用另一个 LED 数码管以和（十进制）作为系统输出。实验主要步骤如下：

1. 进行实验指导中推荐的对 `sc_datamem.v`, `io_output.v`, `io_input.v` 文件的创建、修改；
2. 对 `sc_computer.v` 进行端口声明、实例化信号修改；
3. 创建顶层文件（以实验指导图 2 的参考方式为例） `test.v`。
4. 编写 `clk_and_mem_clk.` 模块。其功能是采用一个 clk 作为主时钟输入，在内部给出二分频后作为 CPU 模块的工作时钟，并产生模块的工作时钟，并产生 `mem_clk`，用于对 CPU 模块内含的存储器读写控制；
5. 编写 I/O 端口模块 `in_port`。其功能是接收按键输入，将 5 bits 的数码管二进制信号转换为 32 bits；
6. 编写 I/O 端口模块 `out_port_seg`。其功能是将输出数据转成十进制并经过七段译码器输出到 LED；
7. 在顶层文件中，结合测试波形文件 `sc_computer_test_wave_02.vwf` 定义端口、实例化相关模块。



<a id=""></a>
<a id="%E4%BF%AE%E6%94%B9-sc_computerv-%E4%B8%AD%E7%9A%84%E6%A8%A1%E5%9D%97"></a>
### 修改 `sc_computer.v` 中的模块
根据已修改的 `sc_datamem.v`, `io_out put.v`, `io_input.v` 文件，可以将 `sc_computer.v` 修改为：
```Verilog
module sc_computer (resetn, clock, mem_clk,
                     in_port0, in_port1,
                     out_port0, out_port1, out_port2);

   input          resetn, clock, mem_clk;
   input  [31:0]  in_port0, in_port1;                 // [ADD]

   output [31:0]  out_port0, out_port1, out_port2;    // [ADD]

   // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
   wire   [31:0]  pc, inst, aluout, memout;
   wire   [31:0]  data;
   wire           wmem;
   wire           imem_clk, dmem_clk;
   wire   [31:0]  out_port0, out_port1, out_port2;    // [ADD]
   
   sc_cpu      cpu   (clock,resetn,inst,memout,pc,wmem,aluout,data);    // CPU module.
   sc_instmem  imem  (pc,inst,clock,mem_clk,imem_clk);                  // instruction memory.
   sc_datamem  dmem  (aluout,data,memout,wmem,clock,mem_clk,dmem_clk,resetn,
                        out_port0, out_port1, out_port2,
                        in_port0,in_port1, mem_dataout, io_read_data);  // data memory.

endmodule
```



<a id="%E7%BC%96%E5%86%99-clk_and_mem_clkv-%E4%B8%AD%E7%9A%84%E6%A8%A1%E5%9D%97"></a>
### 编写 `clk_and_mem_clk.v` 中的模块
该模块的功能是采用一个 clk 作为主时钟输入，在内部给出二分频后作为 CPU 模块的工作时钟，并产生模块的工作时钟，并产生 `mem_clk`，用于对 CPU 模块内含的存储器读写控制，故可结合实验指导中的仿真结果示例，采用非阻塞式赋值。
```Verilog
module clock_and_mem_clock(clk, clock_out);
    // Notice that in .vwf, it is clock_out

    input       clk;

    output      clock_out;

    reg         clock_out;


    initial
    begin
        clock_out = 0;
    end

    always @(posedge clk)
    begin
        clock_out <= ~ clock_out;       
    end
    

endmodule 
```



<a id="%E7%BC%96%E5%86%99-in_portv-%E4%B8%AD%E7%9A%84%E6%A8%A1%E5%9D%97"></a>
### 编写 `in_port.v` 中的模块
该模块功能是接收按键输入，将 5 bits 的数码管二进制信号转换为 32 bits，故有：
```
module in_port(in_4, in_3, in_2, in_1, in_0,
                    in_port);
    // 接受按键输入，将 5bit < 32bit 输入端口转换为 32 位

    input               in_4, in_3, in_2, in_1, in_0;


    output  [31:0]      in_port;
    

    // 5bit (*****) ==> 32 bit (00...0000*****)
    assign in_port = {27'b0, in_4, in_3, in_2, in_1, in_0};


endmodule
```



<a id="%E7%BC%96%E5%86%99-out_port_segv-%E4%B8%AD%E7%9A%84%E6%A8%A1%E5%9D%97"></a>
### 编写 `out_port_seg.v` 中的模块
该模块功能是将输出数据转成十进制并经过七段译码器输出到 LED。经查阅相关资料，LED 管脚排列顺序为 `gfedcba`，故，为了更好的程序结构，可以编写一个十进制数字到 LED 各管脚高低电平信号的转换模块。
``` Verilog
module num_2_seg(num, out);
    input   [3:0]       num;
    output  [6:0]       out;

    reg     [6:0]       out;

    initial
    begin
        out = 0;
    end

    always @ (*)
    begin
        case(num) //seven-digit-seg: gfedcba
            0:          out[6:0] = 7'b1000000;
            1:          out[6:0] = 7'b1111001;
            2:          out[6:0] = 7'b0100100;
            3:          out[6:0] = 7'b0110000;
            4:          out[6:0] = 7'b0011001;
            5:          out[6:0] = 7'b0010010;
            6:          out[6:0] = 7'b0000010;
            7:          out[6:0] = 7'b1111000;
            8:          out[6:0] = 7'b0000000;
            9:          out[6:0] = 7'b0010000;
            default:    out[6:0] = 7'b1111111;
        endcase
    end

endmodule
```

由此，可以在对 `outport` 进行进制转换、分离高低位后，分别对高低位 `outport` 实例化模块 `num_2_seg`，`out_port_seg` 模块的代码如下：
```Verilog
module out_port_seg(out_port, out_high, out_low);

    input   [31:0]      out_port;

    output  [6 :0]      out_high, out_low;


    wire    [6 :0]      out_high, out_low;

    // calculate the output numbers on each digit
    wire    [3 :0]      num_high = out_port / 10;
    wire    [3 :0]      num_low  = out_port - num_high * 10;


    num_2_seg num2seghigh   (num_high, out_high);
    num_2_seg num2seglow    (num_low,  out_low);


endmodule
```



<a id="%E7%BC%96%E5%86%99-testv-%E9%A1%B6%E5%B1%82%E6%96%87%E4%BB%B6"></a>
### 编写 `test.v` 顶层文件
顶层文件中的大致逻辑如下：

+ 生成实际工作时钟，即实例化 `clock_and_mem_clock`；
+ 获取两路 5 bits 输入信号，即分别实例化 `in_port`。需要注意，这里输入信号分别代表加数和被加数，并以高五位（由高至低）作为被加数，低五位（由高至低）为加数，；
+ 实例化单周期 CPU，进行指令的执行
+ 根据计算得到的结果，将 `outport` 转化为数码管的输出信号，即对被加数、加数、和分别实例化 `out_port_seg`。需要注意，这里按输出端口号由小至大，每“两位”（6 bits + 6 bits），按被加数、加数、和的顺序，分别表示其中的一个。

具体代码如下：
```Verilog
module test (SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9,
                clk, reset,
                out_port0, out_port1, out_port2, clock_out,
                HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    input           reset, clk;                     // control signals
    input           SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9;
    
    output  [31:0]  out_port0, out_port1, out_port2;
    output  [6 :0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    output          clock_out;
    wire    [31:0]  in_port0, in_port1;
    wire    [6 :0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    
    clock_and_mem_clock inst (clk, clock_out);

    
    // Inputs: result = number_high(DEC) + number_low(DEC)
    in_port inst1(SW9,SW8,SW7,SW6,SW5, in_port0);   // the added
    in_port inst2(SW4,SW3,SW2,SW1,SW0, in_port1);   // the addeend

    
    // Single-cycle CPU instance
    sc_computer inst4(reset, clock_out, clk,
                        in_port0, in_port1,
                        out_port0, out_port1, out_port2);

    // module out_port_seg(out_port, out_high, out_low);
    out_port_seg inst5(out_port0, HEX1,HEX0);
    out_port_seg inst6(out_port1, HEX3,HEX2);
    out_port_seg inst7(out_port2, HEX5,HEX4);
    
    
endmodule
```



<a id="%E6%B3%A2%E5%BD%A2%E4%BB%BF%E7%9C%9F%E7%BB%93%E6%9E%9C%E9%AA%8C%E8%AF%81"></a>
### 波形仿真结果验证
编译该工程并运行波形仿真，有如下结果
<div align="center">
    ![tag](pics/res01.png)  
    ![tag](pics/res02.png)
</div>  
不难看出，I/O 输入输出“加法计算器”的功能得到了基本实现。





<br>


<a id="%E3%80%90%E9%80%89%E5%81%9A%E3%80%91%E6%8C%87%E4%BB%A4%E6%89%A9%E5%B1%95"></a>
## 【选做】指令扩展
按照实验指导中的相关要求，这里采用了建议的计算 Hamming Distance 的功能，在实际实现、测试中，主要需要进行以下步骤：

1. 修改 `alu.v`，扩展 `aluc [3:0]` 的功能，增加 Hamming Distance 计算具体操作；
2. 修改 `sc_cu.v`，扩展 `func` 翻译指令的指令集，增加 Hamming Distance 的判断标准、修改 `aluc` 信号的生成，修改 `shift`, `aluimm` 等控制信号的生成；
3. 将加入的 Hamming Distance 指令转译，添加在 `sc_instmem.mif` 中，初始化待执行指令；
4. 进行波形仿真，验证结果



<a id="%E4%BF%AE%E6%94%B9-aluv%EF%BC%8C%E6%89%A9%E5%B1%95%E5%8A%9F%E8%83%BD"></a>
### 修改 `alu.v`，扩展功能
出于简洁性的考虑，这里仅展示添加部分代码，其余部分与 Lab 1 的实现相同
```Verilog
always @ (a or b or aluc) 
    begin                                    // event
        casex (aluc)
            4'b1011:                         // hamming code
                begin
                    t = a ^ b;
                    s =  t[0]  + t[1]  + t[2]  + t[3]  + 
                         t[4]  + t[5]  + t[6]  + t[7]  + 
                         t[8]  + t[9]  + t[10] + t[11] + 
                         t[12] + t[13] + t[14] + t[15] + 
                         t[16] + t[17] + t[18] + t[19] + 
                         t[20] + t[21] + t[22] + t[23] + 
                         t[24] + t[25] + t[26] + t[27] +
                         t[28] + t[29] + t[30] + t[31];
                end

            4'bx000: s = a + b;              //x000 ADD
            // ......
        endcase
        // ......
    end
```



<a id="%E4%BF%AE%E6%94%B9-sc_cuv%EF%BC%8C%E6%89%A9%E5%B1%95%E5%8A%9F%E8%83%BD"></a>
### 修改 `sc_cu.v`，扩展功能
出于简洁性的考虑，这里仅展示添加部分代码，其余部分与 Lab 1 的实现相同
```Verilog
    // ......

    // hamming code
    wire i_hamm = r_type &  func[5] &  func[4] & ~func[3] &
                           ~func[2] &  func[1] & ~func[0];   // 110010
    // ......

    assign wreg = i_add  | i_sub | i_and | i_or   | i_xor  |
                   i_sll | i_srl | i_sra | i_addi | i_andi |
                   i_ori | i_xori| i_lw  | i_lui  | i_jal
                   | i_hamm;
    
    // ......
    
    // hamm-aluc: 1011
    assign aluc[3] = i_sra | i_hamm;
    assign aluc[2] = i_sub | i_or  | i_srl | i_sra | i_ori | i_lui;
    assign aluc[1] = i_xor | i_sll | i_srl | i_sra | i_xori | i_lui | i_hamm;
    assign aluc[0] = i_and | i_or  | i_sll | i_srl | i_sra | i_andi | i_ori | i_hamm;
    
    assign shift   = i_sll | i_srl | i_sra ;                 // No edits for those signals
    
    // ......
```



<a id="%E8%BD%AC%E8%AF%91%E6%96%B0%E5%A2%9E%E6%8C%87%E4%BB%A4%EF%BC%8C%E4%BF%AE%E6%94%B9-sc_instmemmif-%E5%88%9D%E5%A7%8B%E5%8C%96%E6%96%87%E4%BB%B6"></a>
### 转译新增指令，修改 `sc_instmem.mif` 初始化文件
这里新增的 Hamming Distance 的指令采用 R 型指令格式。以执行指令 `hamm $9, $4, $5`为例，即计算四号、五号寄存器中值的 Hamming Distance，将结果存入九号寄存器。

指令格式  | op      | rs      | rt      | rd    | sa      | funct
:-:       | :-:     | :-:    | :-:     | :-:   | :-:     | :-:
位数      | 6 bits  | 5 bits  | 5 bits  | 5     | 5      | 6      
指令范例  | 000000  | 00100   | 00101   |01001  | 00000   | 110010
转译分组  | <font color="#09AEEC"><b>0000</b></font>00  | 00<font color="#09AEEC"><b>100</b></font>   | <font color="#09AEEC"><b>0</b></font>0101   | <font color="#09AEEC"><b>0100</b></font>1  | 000<font color="#09AEEC"><b>00</b></font>   | <font color="#09AEEC"><b>11</b></font>0010

在指令码中，`rs`, `rt`, `rd` 的编号即为其 `$X` 格式编号中 `X` 的二进制。  
我们观察到，`.mif` 文件中每条指令为 8 位，而目前我们得到了 32 位的完整指令码，故，以每四位二进制码为一组，将其由二进制转化为十进制，便得到了最终的指令。这里需要注意，大于等于 10 的“码”，可以采用 `a, b, c...` 等进行表示。  
故，得到的指令为 `00854832`。

这里将新增指令添加在 `.mif` 文件中 `loop` 中第五条指令后，即执行完 `add` 指令后执行 `hamm` 指令。  
这里还需要注意，这里我们还需要增加内存深度，即改为 64，以保证指令正确执行，参见 [Quartus II Help v13.0 > Memory Initialization File (.mif) Definition](https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/reference/glossary/def_mif.htm)。 `sc_instmem.mif` 具体代码如下：
```Verilog
DEPTH = 64;           % Memory depth and width are required %
WIDTH = 32;           % Enter a decimal number %
ADDRESS_RADIX = HEX;  % Address and value radixes are optional %
DATA_RADIX = HEX;     % Enter BIN, DEC, HEX, or OCT; unless %
                      % otherwise specified, radixes = HEX %
CONTENT
BEGIN

0 : 20010080;        % (00) main: addi $1, $0, 128 # outport0, inport0              %
1 : 20020084;        % (04)       addi $2, $0, 132 # outport1, inport1              %
2 : 20030088;        % (08)       addi $3, $0, 136 # outport2                       %
3 : 8c240000;        % (0c) loop: lw   $4, 0($1)   # input inport0 to $4            %
4 : 8c450000;        % (10)       lw   $5, 0($2)   # input inport1 to $5            %
5 : 00853020;        % (14)       add  $6, $4, $5  # add inport0 with inport1 to $6 %
6 : 00854832;        % (99)       hamm $9, $4, $5  # hamming dist of inport0&1 to $9%
7 : ac240000;        % (18)       sw   $4, 0($1)   # output inport0 to outport0     %
8 : ac450000;        % (1c)       sw   $5, 0($2)   # output inport1 to outport1     %
9 : ac660000;        % (20)       sw   $6, 0($3)   # output result to outport2      %
10: 08000003;        % (24)       j loop           #                                %
END ;
```



<a id="%E6%B3%A2%E5%BD%A2%E4%BB%BF%E7%9C%9F%E7%BB%93%E6%9E%9C%E9%AA%8C%E8%AF%81-1"></a>
### 波形仿真结果验证
<div align="center">
    ![tag](pics/res03.png)  
    ![tag](pics/res04.png)
</div>  
不难看出，I/O 输入输出扩展指令 Hamming Distance 的功能得到了基本实现。




<br>


<a id="%E5%AE%9E%E9%AA%8C%E6%80%BB%E7%BB%93"></a>
## 实验总结
总的来说，本次实验基本实现了实验相关要求，达到了实验目的。  

在此过程中，依据理论学习讲授的知识，结合参考代码，通过 `Verilog` 硬件描述语言等，在某种程度上来说，实验的过程达到了“学以致用”、“理论实际相结合”的目的。  

当然，也需要注意到，这次实验上手的的难度偏大，相关指导、介绍仍偏少，且有很多未提及却一定会遇到的问题，因此在实际操作过程中，对相关知识进行多方查找、参考便即为重要。当然，在软件操作、逻辑梳理、代码编写等等方面遇到的许许多多困难，令我也在解决这些挑战的过程中收获了一定的提高。