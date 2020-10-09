`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/25 23:10:04
// Design Name: 
// Module Name: add_8_test
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


module add_8_test(

    );
    reg [7:0] a,b;
    wire [7:0] sum;
    reg cin;
    wire co;
    add_8 u0(
        .a(a),
        .b(b),
        .cin(cin),
        .s(sum),
        .co(co)
        );
    initial begin
        $dumpfile("testadd_8.vcd");
        $dumpvars;
        a=8'b0000_1111;     b=8'b1111_0000;     cin=0;
        $monitor ("%0t a=%8b b=%8b cin=%1b sum=%8b co=%1b", $time, a, b, cin,sum,co);
        #200; 
        a=8'b0101_0101;     b=8'b1010_1010;     cin=0;
        $monitor ("%0t a=%8b b=%8b cin=%1b sum=%8b co=%1b", $time, a, b, cin,sum,co);
        #200; 
        a=8'b0000_1111;     b=8'b1111_0000;     cin=1;
        $monitor ("%0t a=%8b b=%8b cin=%1b sum=%8b co=%1b", $time, a, b, cin,sum,co);
        #200; 
        a=8'b0001_1111;     b=8'b1111_0000;     cin=0;
        $monitor ("%0t a=%8b b=%8b cin=%1b sum=%8b co=%1b", $time, a, b, cin,sum,co);                  
        #200; 
    
    end
endmodule
