`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/13 15:01:21
// Design Name:
// Module Name: RegFile
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


module RegFile(
           Clk,Clr,Write_Reg,R_Addr_A,R_Addr_B,W_Addr,W_Data,R_Data_A,R_Data_B
       );
parameter ADDR = 5;//�Ĵ�������/��ַλ��
parameter NUMB = 1<<ADDR;//�Ĵ�������
parameter SIZE = 32;//�Ĵ�������λ��
input Clk;//д��ʱ���ź�
input Clr;//�����ź�
input Write_Reg;//д�����ź�
input [ADDR-1:0]R_Addr_A;//A�˿ڶ��Ĵ�����ַ
input [ADDR-1:0]R_Addr_B;//B�˿ڶ��Ĵ�����ַ
input [ADDR-1:0]W_Addr;//д�Ĵ�����ַ
input [SIZE:1]W_Data;//д������
output [SIZE:1]R_Data_A;//A�˿ڶ�������
output [SIZE:1]R_Data_B;//B�˿ڶ�������
reg [SIZE:1]REG_Files[0:NUMB-1];//�Ĵ����ѱ���
integer i;//���ڱ���NUMB���Ĵ���
initial//��ʼ��NUMB���Ĵ�����ȫΪ0
    for(i=0;i<NUMB;i=i+1)
        REG_Files[i]<=i;
always@(posedge Clk or posedge Clr)//ʱ���źŻ������ź�������
begin
    if(Clr)//����
        for(i=0;i<NUMB;i=i+1)
            REG_Files[i]<=0;
    else//������,���д����, �ߵ�ƽ��д��Ĵ���
        if(Write_Reg)
            REG_Files[W_Addr]<=W_Data;
end        //������û��ʹ�ܻ�ʱ���źſ���, ʹ����������ģ(����߼���·,������Ҫʱ�ӿ���)
assign R_Data_A=REG_Files[R_Addr_A];
assign R_Data_B=REG_Files[R_Addr_B];
endmodule
