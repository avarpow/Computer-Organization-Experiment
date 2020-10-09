`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/25 23:09:40
// Design Name: 
// Module Name: add_8
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


module add_8 ( input [7:0]a, input [7:0]b, input cin, output [7:0] s, output co ); 
wire [7:0]c_tmp; 
wire [7:0]g;
wire [7:0]p;  
assign co = c_tmp[7];  
assign  
        //G ��ʾ�����Ǻ���Ľ�λ�������Ƿ��н�λ
        g = a & b; 
assign  
        //P ��ʾa��b����һλ��������һ��
        p = a | b;
assign  
c_tmp[0] = g[0] | ( p[0] & cin ),  
c_tmp[1] = g[1] | ( p[1] & g[0]) 
                | ( p[1] & p[0] & cin),    
c_tmp[2] = g[2] | ( p[2] & g[1]) 
                | ( p[2] & p[1] & g[0]) 
                | ( p[2] & p[1] & p[0] & cin),           
c_tmp[3] = g[3] | ( p[3] & g[2]) 
                | ( p[3] & p[2] & g[1]) 
                | ( p[3] & p[2] & p[1] & g[0])  
                | ( p[3] & p[2] & p[1] & p[0] & cin),        
c_tmp[4] = g[4] | ( p[4] & g[3]) 
                | ( p[4] & p[3] & g[2]) 
                | ( p[4] & p[3] & p[2] & g[1]) 
                | ( p[4] & p[3] & p[2] & p[1] & g[0]) 
                | ( p[4] & p[3] & p[2] & p[1] & p[0] &cin),       
c_tmp[5] = g[5] | ( p[5] & g[4]) 
                | ( p[5] & p[4] & g[3]) 
                | ( p[5] & p[4] & p[3] & g[2])  
                | ( p[5] & p[4] & p[3] & p[2] & g[1]) 
                | ( p[5] & p[4] & p[3] & p[2] & p[1] & g[0])  
                | ( p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin),         
c_tmp[6] = g[6] | ( p[6] & g[5]) 
                | ( p[6] & p[5] & g[4]) 
                | ( p[6] & p[5] & p[4] & g[3]) 
                | ( p[6] & p[5] & p[4] & p[3] & g[2]) 
                | ( p[6] & p[5] & p[4] & p[3] & p[2] & g[1])  
                | ( p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0])  
                | ( p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin),      
c_tmp[7] = g[7] | ( p[7] & g[6]) 
                | ( p[7] & p[6] & g[5]) 
                | ( p[7] & p[6] & p[5] & g[4] ) 
                | ( p[7] & p[6] & p[5] & p[4] & g[3]) 
                | ( p[7] & p[6] & p[5] & p[4] & p[3] & g[2])
                | ( p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1])  
                | ( p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0])  
                | ( p[7] & p[6]& p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin); 
assign s[7:0] = a[7:0] ^ b[7:0] ^{c_tmp[6:0],cin};
endmodule 