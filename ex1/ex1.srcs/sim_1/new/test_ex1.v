`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/11 14:43:15
// Design Name: 
// Module Name: test_ex1
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


module test_ex1();
reg a,b; //�����������Ϊreg���͵�
wire f; //�������Ҫ����Ϊwire���͵ģ�����wire����ȱʡswitch2 s0(.A(a),.B(b),.F(f));
ex1 s0(.A(a),.B(b),.F(f));
initial begin
a = 1'b0;  b = 1'b0;  #20;
a = 1'b0;  b = 1'b1;  #20; 
a = 1'b1;  b = 1'b0;  #20; 
a = 1'b1;  b = 1'b1;  #20; 
a = 1'b0;  b = 1'b0;  #20;
end
endmodule
