`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/26 22:04:22
// Design Name: 
// Module Name: cpu_sim
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


  
`timescale 1ns/1ns

module cpu_sim;
reg clk, rst;
initial begin
    clk = 0;
    rst = 1;
    #1000 rst = 0; 
end
    
    always #100 clk = ~clk;
    cpu cpu1 ( .clk(clk), .rst(rst) );

endmodule
