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
reg a,b; //输入变量声明为reg类型的
wire f; //输出变量要声明为wire类型的，这里wire不可缺省switch2 s0(.A(a),.B(b),.F(f));
ex1 s0(.A(a),.B(b),.F(f));
initial begin
a = 1'b0;  b = 1'b0;  #20;
a = 1'b0;  b = 1'b1;  #20; 
a = 1'b1;  b = 1'b0;  #20; 
a = 1'b1;  b = 1'b1;  #20; 
a = 1'b0;  b = 1'b0;  #20;
end
endmodule
