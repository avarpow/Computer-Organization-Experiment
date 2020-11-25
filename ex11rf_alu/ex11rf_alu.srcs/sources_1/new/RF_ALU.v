`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/13 15:02:13
// Design Name:
// Module Name: RF_ALU
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


module RF_ALU(
           Clk,Clr,Write_Reg,Write_Select,//�����ź�
           R_Addr_A,R_Addr_B,W_Addr,//��д��ַ
           Input_Data,R_Data_A,R_Data_B,//����IO
           OP,ZF,CF,OF,SF,PF,ALU_F//ALU����
           ,W_Data );
parameter ADDR = 5;//��ַλ��
parameter SIZE = 32;//����λ��        //�Ĵ�����
input Clk, Clr;//д��ʱ���ź�, �����ź�
input Write_Reg;//д�����ź�
input [ADDR-1:0]R_Addr_A;//A���˿ڼĴ�����ַ
input [ADDR-1:0]R_Addr_B;//B���˿ڼĴ�����ַ
input [ADDR-1:0]W_Addr;//д�Ĵ�����ַ
input [SIZE:1]Input_Data;//�ⲿ��������

output [SIZE:1]R_Data_A;//A�˿ڶ�������
output [SIZE:1]R_Data_B;//B�˿ڶ�������        //ALU
input [3:0] OP;//���������
output ZF,//���־
       CF,//����λ��־(ֻ���޷���������������)
       OF,//�����־(ֻ���з���������������)
       SF,//���ű�־(ֻ���з���������������)
       PF;//��ż��־
output [SIZE:1] ALU_F;//������F
input wire Write_Select;//д������ѡ���ź�
wire [SIZE:1]ALU_F;//ALU�������м����
output  reg [SIZE:1]W_Data;//д������     //Write_Select�ߵ�ƽ��д�ⲿ���룬����д������
always@(*)
begin
    case (Write_Select)
        1'b0: W_Data=ALU_F;
        1'b1: W_Data=Input_Data;
    endcase
end
RegFile RF_Test(        //����
            .Clk(Clk),//ʱ���ź�
            .Clr(Clr),//�����ź�
            .Write_Reg(Write_Reg),//д�����
            .R_Addr_A(R_Addr_A),//A�˿ڶ���ַ
            .R_Addr_B(R_Addr_B),//B�˿ڶ���ַ
            .W_Addr(W_Addr),//д���ַ
            .W_Data(W_Data),//д������, ���ⲿ��ALU����                //���
            .R_Data_A(R_Data_A),//A�˿ڶ�������
            .R_Data_B(R_Data_B)//B�˿ڶ�������
        );              //ʵ����ALUģ��

ALU ALU_Test(    //����
        .OP(OP),//�����
        .A(R_Data_A),//�ӼĴ�����A������
        .B(R_Data_B),//�ӼĴ�����B������
        .F(ALU_F),//ALU_F��Ϊ�м�����ݴ�����������Input_Dataѡ������Ĵ���                //���
        .ZF(ZF),//���־
        .CF(CF),//����λ��־(ֻ���޷���������������)
        .OF(OF),//�����־(ֻ���з���������������)
        .SF(SF),//���ű�־(ֻ���з���������������)
        .PF(PF)//��ż��־
    );

endmodule

