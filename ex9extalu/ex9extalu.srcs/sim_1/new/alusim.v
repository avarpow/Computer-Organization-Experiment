`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/30 14:52:16
// Design Name: 
// Module Name: alusim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alusim;
// Inputs
reg [31:0] input2;
reg [3:0] aluCtr;
reg [15:0] inst; // 输入16 位
// Outputs
wire [31:0] aluRes;
wire zero;
wire ZF,CF,OF,SF,PF;
// Instantiate the Unit Under Test (UUT)
alu uut (
.inst(inst),
.input2(input2),
.aluCtr(aluCtr),
.aluRes(aluRes),
.ZF(ZF),
.CF(CF),
.OF(OF),
.SF(SF),
.PF(PF)
);
initial begin
// Initialize Inputs
    input2 = 32'hfffffff8;
    aluCtr = 4'b0110;//减
    inst=16'b0000_0000_0000_0001; //符号扩展的输入
    #100;
    input2 = 1;
    aluCtr = 4'b0110;//加
    inst=16'b1000_0000_0000_0001;
    #100
    input2 = 1;
    aluCtr = 4'b0010;
    #100
    input2 = 0;
    aluCtr = 4'b0000;
    #100
    input2 = 0;
    aluCtr = 4'b0001;
    #100
    input2 = 0;
    aluCtr = 4'b0111;
    #100
    input2 = 1;
    aluCtr = 4'b0111;
end
endmodule


