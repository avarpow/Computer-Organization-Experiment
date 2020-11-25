`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/13 15:00:20
// Design Name:
// Module Name: ALU
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

module ALU(OP,A,B,F,ZF,CF,OF,SF,PF);
parameter SIZE = 32;//����λ��
input [3:0] OP;//�������
input [SIZE:1] A;//��������
input [SIZE:1] B;//��������
output [SIZE:1] F;//������
output      ZF, //0��־λ, ������Ϊ0(ȫ��)����1, ������0
            CF, //����λ��־λ, ȡ���λ��λC,�ӷ�ʱC=1��CF=1��ʾ�н�λ,����ʱC=0��CF=1��ʾ�н�λ
            OF, //�����־λ�����з��������������壬�����OF=1������Ϊ0
            SF, //���ű�־λ����F�����λ��ͬ
            PF; //��ż��־λ��F��������1����PF=1������Ϊ0
reg [SIZE:1] F;
reg C,ZF,CF,OF,SF,PF;//CΪ���λ��λ
always@(*)
begin
    C=0;
    case(OP)
        4'b0000:begin F=A&B; end    //��λ��
        4'b0001:begin F=A|B; end    //��λ��
        4'b0010:begin F=A^B; end    //��λ���
        4'b0011:begin F=~(A|B); end //��λ���
        4'b0100:begin {C,F}=A+B; end //�ӷ�
        4'b0101:begin {C,F}=A-B; end //����
        4'b0110:begin F=A<B; end//A<B��F=1������F=0
        4'b0111:begin F=B<<A; end   //��B����Aλ
    endcase
    ZF = F==0;//FȫΪ0����ZF=1
    CF = C; //��λ��λ��־
    OF = A[SIZE]^B[SIZE]^F[SIZE]^C;//�����־��ʽ
    SF = F[SIZE];//���ű�־,ȡF�����λ
    PF = ^F;//��ż��־��F��������1����F=1��ż����1����F=0
end
endmodule
