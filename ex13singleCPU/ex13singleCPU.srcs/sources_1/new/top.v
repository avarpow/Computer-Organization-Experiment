`timescale 1ns / 1ps
module top(
input clkin,
input reset,
input [7:0]PC,
output [6:0] sm_duan,//段码
output [3:0] sm_wei,//哪个数码管
output [31:0]aluRes,
output [31:0]instruction
);
// 复用器信号线
//wire[31:0] expand2, mux4, mux5, address, jmpaddr;
//数据存储器
wire[31:0] memreaddata;
// 指令存储器 
//wire [31:0] instruction; 
reg[7:0] Addr;
// CPU 控制信号线
wire reg_dst,jmp,branch, memread, memwrite, memtoreg,alu_src,ExtOp; 
wire[3:0] aluop;
wire regwrite;
// ALU 控制信号线
wire ZF,OF,CF; //alu运算为零标志 
wire[31:0] aluRes; //alu运算结果
// ALU控制信号线
wire[3:0] aluCtr;//根据aluop和指令后6位 选择alu运算类型
//wire[31:0] aluRes; //alu运算结果
wire[31:0] input2;
wire [15:0]data;
// 寄存器信号线
wire[31:0] RsData, RtData;
wire[31:0] expand; wire[4:0] shamt;
wire [4:0]regWriteAddr;
wire[31:0]regWriteData;
assign shamt=instruction[10:6];
assign regWriteAddr = reg_dst ? instruction[15:11] : instruction[20:16];//写寄存器的目标寄存器来自rt或rd
assign data=aluRes[15:0];
assign regWriteData = memtoreg ? memreaddata : aluRes; //写入寄存器的数据来自ALU或数据寄存器 
assign input2 = alu_src ? expand : RtData; //ALU的第二个操作数来自寄存器堆输出或指令低16位的符号扩展
// 例化指令存储器

rom_top trom(
    .Clk(clkin),
    .Rst(1b'1),
    .addr(PC[7:0]),
    .data()
)
// 实例化控制器模块
ctr mainctr(
.opCode(instruction[31:26]),
.regDst(reg_dst),
.aluSrc(alu_src),
.memToReg(memtoreg),
.regWrite(regwrite),
.memRead(memread),
.memWrite(memwrite),
.branch(branch),
.ExtOp(ExtOp),
.aluop(aluop),
.jmp(jmp));
//  实例化 ALU 控制模块
aluctr aluctr1(
.ALUOp(aluop),
.funct(instruction[5:0]),
.ALUCtr(aluCtr));
// 。。。。。。。。。。。。。。。。。。。。。。。。。实例化寄存器模块
RegFile regfile(
.RsAddr(instruction[25:21]),
.RtAddr(instruction[20:16]),
.clk(!clkin),
.reset(reset),
.regWriteAddr(regWriteAddr),
.regWriteData(regWriteData),
.regWriteEn(regwrite),
.RsData(RsData),
.RtData(RtData)
);

// 。。。。。。。。。。。。。。。。。。。。。。实例化ALU模块
alu alu(
.shamt(shamt),
.input1(RsData), //写入alu的第一个操作数必是Rs
.input2(input2),
.aluCtr(aluCtr),
.ZF(ZF),
.OF(OF),
.CF(CF),
.aluRes(aluRes));
//实例化符号扩展模块
signext signext(.inst(instruction[15:0]),.ExtOp(ExtOp), .data(expand));
//实例化数据存储器
 DM_unit dm(.clk(clkin), .Wr(memwrite),
            .reset(reset),           
             .DMAdr(aluRes), 
             .wd(RtData),
             .rd( memreaddata));
//...............................实例化数码管显示模块
display Smg(.clk(clkin),.sm_wei(sm_wei),.data(data),.sm_duan(sm_duan)); 

endmodule
