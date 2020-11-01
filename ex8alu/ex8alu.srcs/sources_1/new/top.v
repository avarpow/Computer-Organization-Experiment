`timescale 1ns / 1ps
module top( 
input clk, 
input reset, //复位信号（连接一个按键）
output [6:0] seg,//段码
output [3:0] sm_wei//哪个数码管
);
// ALU信号线
wire [15:0]input1;
wire [15:0] input2;
wire zero; 
wire[15:0] aluRes; 
//wire[15:0] expand;
// ALU控制信号线
wire[3:0] aluCtr; 
// 实例化ALU模块
alu alu0(.input1(input1), 
.input2(input2), 
.aluCtr(aluCtr), 
.zero(zero), 
.aluRes(aluRes)); 
// 实例化符号扩展模块
//signext signext(.inst(inst[15:0]), .data(expand));
//...............................实例化数码管显示模块
diaplay_wrapper disp1 (.clk_0(clk),.sm_wei_0(sm_wei),.data_0(aluRes[15:0]),.sm_duan_0(seg));
//此处文件名使用你自己定义的显示文件名
					
endmodule
