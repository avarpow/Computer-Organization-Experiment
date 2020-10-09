`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/18 15:56:41
// Design Name: 
// Module Name: addsub
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


module addsub
    #(parameter WIDTH=8)	//ָ�����ݿ�Ȳ�����ȱʡֵ�� 8 (
   (
    input [(WIDTH-1):0] a,	// ȱʡλ���ɲ��� WIDTH ������ a Ϊ��һλ������
    input [(WIDTH-1):0] b,	// b Ϊ�ڶ�λ������
    input sub,	// sub=1 Ϊ������sub=0 Ϊ�ӷ�
    output [(WIDTH-1):0] sum, // sum Ϊ a �� b ����Ľ��
    output cf,	// cf Ϊ��λ��־
    output ovf,	// ovf Ϊ�����־
    output sf,	// sf Ϊ���ű�־
    output zf	// zf Ϊ 0 ��־
    );
    wire [(WIDTH-1):0] subb,subb1; 
    wire cf2; // �� λ
    assign subb1 = b ^ {WIDTH{sub}}; // ���ڼ�����ȡ��
    assign subb  =  subb1 + sub;	// ���ڼ����Ǽ� 1��sub=1��������sub=0���ӷ���// ������subb = b ȡ��+1 �� �ӷ���subb = b
    assign {cf2,sum} = a + subb;
    assign sf = sum[WIDTH-1];		//sum �����λΪ����λ
    assign zf = (sum == 0) ? 1 : 0 ; //sum=0�� �� 0 �� ־ zf=1 
    assign cf = cf2 ^ sub;	//��λ cf = cf2 ^ sub
    assign ovf = (a[WIDTH-1] ^ sum[WIDTH-1]) & (subb[WIDTH-1] ^ sum[WIDTH-1]
    
); //�ж����
endmodule