`timescale 1ns / 1ps
module top( 
input clk, 
input reset, //��λ�źţ�����һ��������
output [6:0] seg,//����
output [3:0] sm_wei//�ĸ������
);
// ALU�ź���
wire [15:0]input1;
wire [15:0] input2;
wire zero; 
wire[15:0] aluRes; 
//wire[15:0] expand;
// ALU�����ź���
wire[3:0] aluCtr; 
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
