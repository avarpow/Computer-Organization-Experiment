`timescale 1ns / 1ps
module top( 
input [3:0]aluCtr,
input [8:0] _input2, 
input clk, 
output [6:0] seg,//����
output [3:0] sm_wei//�ĸ������
);
// ALU�ź���
wire [15:0]input1;
wire [15:0] input2;
assign input1=16'h0x0007;
assign input2[15:8]={8{_input2[8]}};
assign input2[7:0]=_input2[7:0]; 
wire zero; 
wire[15:0] aluRes; 
//wire[15:0] expand;
// ALU�����ź���
//wire[3:0] aluCtr; 
// ʵ����ALUģ��
alu alu0(.input1(input1), 
.input2(input2), 
.aluCtr(aluCtr), 
.zero(zero), 
.aluRes(aluRes)); 
// ʵ����������չģ��
//signext signext(.inst(inst[15:0]), .data(expand));
//...............................ʵ�����������ʾģ��
diaplay_wrapper disp1 (.clk_0(clk),.sm_wei_0(sm_wei),.data_0(aluRes[15:0]),.sm_duan_0(seg));
//�˴��ļ���ʹ�����Լ��������ʾ�ļ���
					
endmodule
