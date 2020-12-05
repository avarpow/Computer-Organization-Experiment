`timescale 1ns / 1ps//�Ĵ�����ģ��
module RegFile(
           Clk,Clr,Write_Reg,R_Addr_A,R_Addr_B,W_Addr,W_Data,R_Data_A,R_Data_B,mfhi,mflo,mult,div,W_data_hi,W_data_lo
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
input [SIZE-1:0]W_Data;//д������
output [SIZE-1:0]R_Data_A;//A�˿ڶ�������
output [SIZE-1:0]R_Data_B;//B�˿ڶ�������
reg [SIZE-1:0]REG_Files[0:NUMB-1];//�Ĵ����ѱ���
reg [SIZE-1:0]hi;//hi�Ĵ���
reg [SIZE-1:0]lo;//lo�Ĵ���
integer i;//���ڱ���NUMB���Ĵ���
initial//��ʼ��NUMB���Ĵ�����ȫΪ0
    for(i=0;i<NUMB;i=i+1)
        REG_Files[i]<=0;
always@(posedge Clk or posedge Clr)//ʱ���źŻ������ź�������
begin
    if(Clr)begin//����
        for(i=0;i<NUMB;i=i+1)
            REG_Files[i]<=0;
        lo<=0;
        hi<=0;
    end

    else//������,���д����, �ߵ�ƽ��д��Ĵ���
        if(Write_Reg)begin
            if(mfhi)//�ƶ�hi
                REG_Files[W_Addr]=hi;
            else if(mflo)//�ƶ�lo
                REG_Files[W_Addr]=hi;
            else if(mult || div)begin//�˳������д��lo,hi�Ĵ���
                hi=W_data_hi;
                lo=W_data_lo;    
            end
            else
                REG_Files[W_Addr]<=W_Data;//��������д��Ĵ���
            
        end
end        //������û��ʹ�ܻ�ʱ���źſ���, ʹ����������ģ(����߼���·,������Ҫʱ�ӿ���)
assign R_Data_A=REG_Files[R_Addr_A];
assign R_Data_B=REG_Files[R_Addr_B];
endmodule