`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/30 14:48:31
// Design Name: 
// Module Name: alu
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

module alu( 
input [15:0] inst, 
input [31:0] input2, 
input [3:0] aluCtr, 
output reg[31:0] aluRes, 
output reg ZF,CF,OF,SF,PF 
); 
wire [31:0]input1;
always @(input1 or input2 or aluCtr)
 // 运算数或控制码变化时操作
    begin 
        case(aluCtr) 
            4'b0110: // 减
                begin
                {CF,aluRes} = input1 - input2;
                OF=input1[31]^input2[31]^aluRes[31]^CF; 
                end
            4'b0010: // 加
                begin
                {CF,aluRes} = input1 + input2;
                OF=input1[31]^input2[31]^aluRes[31]^CF; 
                end 
            4'b0000: // 与
                begin
                aluRes = input1 & input2; 
                OF=0;
                end
            4'b0001: // 或
                begin
                aluRes = input1 | input2; 
                OF=0;
                end
            4'b1100: // 异或
                begin
                aluRes = ~(input1 | input2); 
                OF=0;
                end
            4'b0111: // 小于设置
                begin 
                if(input1<input2) 
                aluRes = 1; 
                OF=0;
                end 
            default: 
            aluRes = 0; 
        endcase 

        if(aluRes==0)
            ZF=1;
        else
            ZF=0;

        SF=aluRes[31];
        PF=~^aluRes;
    end 


signext signext(.inst(inst[15:0]), .data(input1));
endmodule 

