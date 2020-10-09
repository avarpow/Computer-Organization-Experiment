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
    #(parameter WIDTH=8)	//指定数据宽度参数，缺省值是 8 (
   (
    input [(WIDTH-1):0] a,	// 缺省位数由参数 WIDTH 决定， a 为第一位运算数
    input [(WIDTH-1):0] b,	// b 为第二位运算数
    input sub,	// sub=1 为减法，sub=0 为加法
    output [(WIDTH-1):0] sum, // sum 为 a 与 b 运算的结果
    output cf,	// cf 为进位标志
    output ovf,	// ovf 为溢出标志
    output sf,	// sf 为符号标志
    output zf	// zf 为 0 标志
    );
    wire [(WIDTH-1):0] subb,subb1; 
    wire cf2; // 进 位
    assign subb1 = b ^ {WIDTH{sub}}; // 对于减法是取反
    assign subb  =  subb1 + sub;	// 对于减法是加 1，sub=1（减法）sub=0（加法）// 减法：subb = b 取反+1 ； 加法：subb = b
    assign {cf2,sum} = a + subb;
    assign sf = sum[WIDTH-1];		//sum 的最高位为符号位
    assign zf = (sum == 0) ? 1 : 0 ; //sum=0， 则 0 标 志 zf=1 
    assign cf = cf2 ^ sub;	//进位 cf = cf2 ^ sub
    assign ovf = (a[WIDTH-1] ^ sum[WIDTH-1]) & (subb[WIDTH-1] ^ sum[WIDTH-1]
    
); //判断溢出
endmodule