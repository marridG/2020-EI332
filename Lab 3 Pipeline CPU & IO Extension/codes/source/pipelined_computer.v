/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module pipelined_computer (resetn,clock,mem_clock,
                     opc,oinst,oins,oealu,omalu,owalu,onpc,/*da,db,
							pcsource*/,
                     in_port0,in_port1,
                     out_port0,out_port1,out_port2,out_port3);

    input             resetn,clock/*,mem_clock*/;
    // 定义整个计算机 module 和外界交互的输入信号 包括复位信号 resetn、时钟信号 clock、
    // 以及一个和 clock 同频率但反相的 mem_clock 信号。 mem_clock 用于指令同步 ROM 和数据同步 RAM 使用，其波形需要有别于实验一。
    // 这些信号可以用作仿真验证时的输出观察信号
    input   [5:0]   in_port0,in_port1;
    output  [31:0]  out_port0,out_port1,out_port2,out_port3;    // output [6:0] out_port0,out_port1,out_port2,out_port3;
    
    wire    [31:0]  real_out_port0,real_out_port1,real_out_port2,real_out_port3;
    
    wire    [31:0]  real_in_port0 = {26'b00000000000000000000000000,in_port0};
    wire    [31:0]  real_in_port1 = {26'b00000000000000000000000000,in_port1};
    
    assign out_port0 = real_out_port0[31:0];    //assign out_port0 = real_out_port0[6:0];
    assign out_port1 = real_out_port1[31:0];    //assign out_port0 = real_out_port1[6:0];
    assign out_port2 = real_out_port2[31:0];    //assign out_port0 = real_out_port2[6:0];
    assign out_port3 = real_out_port3[31:0];    //assign out_port0 = real_out_port3[6:0];
    // IO 口的定义，宽度可根据自己设计选择
   
    output          mem_clock;
   
    assign mem_clock = ~clock;
    
    // 模块用于仿真输出的观察信号。缺省为 wire 型。 为了便于观察内部关键信号将其接到输出管脚
    // 不输出也一样，只是仿真时候要从内部信号里去寻找。

    wire    [31:0]  pc, ealu, malu, walu;
    output  [31:0]  opc, oealu, omalu, owalu;   // for watch
	assign opc = pc;
	assign oealu = ealu;
	assign omalu = malu ;
	assign owalu = walu ;
	
    // 模块间互联传递数据或控制信息的信号线, 均为 32 位宽信号。 IF 取指令阶段。
    wire    [31:0]  bpc,jpc,pc4,npc,ins,inst;
    output  [31:0]  onpc,oins,oinst;// for watch
	assign  onpc=npc;
	assign  oins=ins;
	assign  oinst=inst;

    // 模块间互联传递数据或控制信息的信号线, 均为 32 位宽信号。 ID 指令译码阶段。
    wire    [31:0]  dpc4,da,db,dimm,dsa;

    // 模块间互联传递数据或控制信息的信号线, 均为 32 位宽信号。 EXE 指令运算阶段。
    wire    [31:0]  epc4,ea,eb,eimm,esa;

    // 模块间互联传递数据或控制信息的信号线, 均为 32 位宽信号。 MEM 访问数据阶段。
    wire    [31:0]  mb,mmo;

    // 模块间互联传递数据或控制信息的信号线, 均为 32 位宽信号。 WB 回写寄存器阶段。
    wire    [31:0]  wmo,wdi;

    // 模块间互联通过流水线寄存器传递结果寄存器号的信号线, 寄存器号 (32 个) 为 5bit
    wire    [4:0]   ern0,ern,drn,mrn,wrn;

    // 模块间互联通过流水线寄存器传递 rs, rt 寄存器号的信号线, 寄存器号 (32 个) 为 5bit
    wire    [4:0]   drs,drt,ers,ert;

    // ID 阶段向 EXE 阶段通过流水线寄存器传递的 aluc 控制信号，4bit
    wire    [3:0]   daluc,ealuc;

    // CU 模块向 IF 阶段模块传递的 PC 选择信号，2bit
    wire    [1:0]   pcsource;

    // CU 模块发出的控制流水线停顿的控制信号，使 PC 和 IF/ID 流水线寄存器保持不变。
    wire            wpcir;

    // ID 阶段产生，需往后续流水级传播的信号。
    wire            dwreg,dm2reg,dwmem,daluimm,dshift,djal;  //id stage

    // 来自于 ID/EXE 流水线寄存器，EXE 阶段使用，或需要往后续流水级传播的信号。
    wire            ewreg,em2reg,ewmem,ealuimm,eshift,ejal;  //exe stage

    // 来自于 EXE/MEM 流水线寄存器， MEM 阶段使用，或需要往后续流水级传播的信号。
    wire            mwreg,mm2reg,mwmem;  //mem stage

    // 来自于 MEM/WB 流水线寄存器， WB 阶段使用的信号。
    wire            wwreg,wm2reg;  //wb stage

    // 模块间互联通过流水线寄存器传递的 zero 信号线
    wire            ezero,mzero;  
    
    // 模块间互联通过流水线寄存器传递的流水线冒险处理 bubble 控制信号线
    wire            ebubble,dbubble;
   
    // 程序计数器模块，是最前面一级 IF 流水段的输入。
    pipepc   prog_cnt(npc,wpcir,clock,resetn,pc);

    // IF 取指令模块, 注意其中包含的指令同步 ROM 存储器的同步信号
    // 即输入给该模块的 mem_clock 信号模块内定义为 rom_clk。 // 注意 mem_clock。
    // 实验中可采用系统 clock 的反相信号作为 mem_clock（亦即 rom_clock）,
    // 即留给信号半个节拍的传输时间。
    pipeif   if_stage(pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock);  // IF stage

    // IF/ID 流水线寄存器模块，起承接 IF 阶段和 ID 阶段的流水任务。
    // 在 clock 上升沿时，将 IF 阶段需传递给 ID 阶段的信息，锁存在 IF/ID 流水线寄存器中，并呈现在 ID 阶段。
    pipeir   inst_reg(pc4,ins,wpcir,clock,resetn,
                        dpc4,inst);  // IF\ID 流水线寄存器

    // ID 指令译码模块。注意其中包含控制器 CU、寄存器堆、及多个多路器等。
    // 其中的寄存器堆，会在系统 clock 的下沿进行寄存器写入，也就是给信号从 WB 阶段
    // 传输过来留有半个 clock 的延迟时间，亦即确保信号稳定。
    // 该阶段 CU 产生的、要传播到流水线后级的信号较多。
    pipeid   id_stage(mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,ins,
                        wrn,wdi,ealu,malu,mmo,wwreg,mem_clock,resetn,
    					bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc,
    					daluimm,da,db,dimm,dsa,drn,dshift,djal,mzero,
    					drs,drt/*,npc*/,ebubble,dbubble);  // ID stage

    // ID/EXE 流水线寄存器模块，起承接 ID 阶段和 EXE 阶段的流水任务。
    // 在 clock 上升沿时，将 ID 阶段需传递给 EXE 阶段的信息，锁存在 ID/EXE 流水线寄存器中，并呈现在 EXE 阶段。
    pipedereg de_reg(dbubble,drs,drt,dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,dsa,drn,dshift,djal,dpc4,clock,resetn,
					ebubble,ers,ert,ewreg,em2reg,ewmem,ealuc,ealuimm,ea,eb,eimm,esa,ern0,eshift,ejal,epc4);  // ID\EXE 流水线寄存器
    
    // EXE 运算模块。其中包含 ALU 及多个多路器等
    pipeexe  exe_stage(ealuc,ealuimm,ea,eb,eimm,esa,eshift,ern0,epc4,ejal,ern,ealu,/*ezero,ert,
                wrn,wdi,malu,wwreg*/);  //EXE stage

    // EXE/MEM 流水线寄存器模块，起承接 EXE 阶段和 MEM 阶段的流水任务。
    // 在 clock 上升沿时，将 EXE 阶段需传递给 MEM 阶段的信息，锁存在 EXE/MEM
    // 流水线寄存器中，并呈现在 MEM 阶段。
    pipeemreg em_reg(ewreg,em2reg,ewmem,ealu,eb,ern,ezero,clock,resetn,
					mwreg,mm2reg,mwmem,malu,mb,mrn,mzero);  //EXE\MEM 流水线寄存器

    // MEM 数据存取模块。其中包含对数据同步 RAM 的读写访问。 // 注意 mem_clock。
    // 输入给 该同步 RAM 的 mem_clock 信号，模块内定义为 ram_clk。
    // 实验中可采用系统 clock 的反相信号作为 mem_clock 信号（亦即 ram_clk））,
    // 即留给信号半个节拍的传输时间，然后在 mem_clock 上沿时，读输出、或写输入。
    pipemem mem_stage(mwmem,malu,mb,clock,mem_clock,mmo,resetn,
					real_in_port0,real_in_port1,
                    real_out_port0,real_out_port1,real_out_port2,real_out_port3);  // MEM stage

    // MEM/WB 流水线寄存器模块 起承接 MEM 阶段和 WB 阶段的流水任务。
    // 在 clock 上升沿时 将 MEM 阶段需传递给 WB 阶段的信息 锁存在 MEM/WB
    // 流水线寄存器中，并呈现在 WB 阶段。
    pipemwreg mw_reg(mwreg,mm2reg,mmo,malu,mrn,clock,resetn,
					wwreg,wm2reg,wmo,walu,wrn);  // MEM\WB 流水线寄存器

    // WB 写回阶段模块。事实上，从设计原理图上可以看出，该阶段的逻辑功能部件只
    // 包含一个多路器，所以可以仅用一个多路器的实例即可实现该部分。
    // 当然，如果专门写一个完整的模块也是很好的。
    mux2x32 wb_stage(walu,wmo,wm2reg,wdi);  // WB stage


endmodule
