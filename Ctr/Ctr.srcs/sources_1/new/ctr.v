`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/25 09:17:49
// Design Name:
// Module Name: ctr
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


`timescale 1ns / 1ps
module ctr(
           input [5:0] opCode, output reg regDst, output reg aluSrc, output reg memToReg, output reg regWrite, output reg memRead, output reg memWrite, output reg branch,
           output reg ExtOp, //符号扩展方式，1 为 sign-extend，0 为 zero-extend
           output reg[3:0] aluop, // 经过 ALU 控制译码决定 ALU 功能
           output reg jmp
       );
always@(opCode) begin
    // 操作码改变时改变控制信号
    case(opCode)
        6'b000010: begin // 'J 型' 指令操作码: 000010，无需 ALU
            regDst = 0;  aluSrc = 0; memToReg = 0;
            regWrite = 0; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0111; jmp = 1; ExtOp = 1;
        end
        6'b000011: begin // 'jal' 指令操作码: 000011，无需 ALU
            regDst = 0;  aluSrc = 0; memToReg = 0;
            regWrite = 0; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0111; jmp = 1; ExtOp = 1;
        end
        6'b000000: begin// 'R 型' 指令操作码: 000000
            regDst = 1;  aluSrc = 0; memToReg = 0;
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0000; jmp = 0; ExtOp = 1;
        end
        6'b100011: begin// 'lw' 指令操作码: 100011
            regDst = 0;  aluSrc = 1; memToReg = 1;
            regWrite = 1; memRead = 1; memWrite = 0; branch = 0; aluop = 4'b0011; jmp = 0; ExtOp = 1;
        end 
        6'b101011: begin// 'sw' 指令操作码: 101011
            regDst = 0;  aluSrc = 1; memToReg = 0;
            regWrite = 0; memRead = 0; memWrite = 1; branch = 0; aluop = 4'b0011; jmp = 0; ExtOp = 1;
        end 
        6'b000100: begin// 'beq' 指令操作码: 000100
            regDst = 0;  aluSrc = 0; memToReg = 0;
            regWrite = 0; memRead = 0; memWrite = 0; branch = 1; aluop = 4'b0101; jmp = 0; ExtOp = 1;
        end 
        6'b000101: begin// 'bne' 指令操作码: 000101
            regDst = 0;  aluSrc = 0; memToReg = 0;
            regWrite = 0; memRead = 0; memWrite = 0; branch = 1; aluop = 4'b0110; jmp = 0; ExtOp = 1;
        end 
        6'b001000: begin// 'addi' 指令操作码: 001000
            regDst = 0;  aluSrc = 1; memToReg = 0;
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0011; jmp = 0;ExtOp = 0;
        end 
        6'b001001: // 'addiu' 指令操作码: 001001
        begin
            regDst = 0; aluSrc = 1; memToReg = 0; 
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0011; jmp = 0; ExtOp = 0;
        end
        6'b001100: begin// 'andi' 指令操作码: 001100
            regDst = 0;  aluSrc = 1; memToReg = 0;
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0001; jmp = 0; ExtOp = 0;
        end 
        6'b001101: begin// 'ori' 指令操作码: 001101
            regDst = 0;  aluSrc = 1; memToReg = 0;
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0010; jmp = 0; ExtOp = 0;
        end 
        6'b001110: begin// 'xori' 指令操作码: 001110
            regDst = 0;  aluSrc = 1; memToReg = 0;
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b1000; jmp = 0; ExtOp = 0;
        end
        6'b001010: begin// 'slti' 指令操作码: 001 010
            regDst = 0;  aluSrc = 1; memToReg = 0;
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0100; jmp = 0; ExtOp = 1;
        end 
        6'b001011: begin// 'sltiu' 指令操作码: 001011
            regDst = 0;  aluSrc = 1; memToReg = 0;
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0100; jmp = 0; ExtOp = 0;
        end 
        6'b001111: begin// 'lui' 指令操作码: 001111
            regDst = 0;  aluSrc = 1; memToReg = 0;
            regWrite = 1; memRead = 0; memWrite = 0; branch = 0; aluop = 4'b0111; jmp = 0; ExtOp = 0;
        end 
        default: begin// 默认设置
            regDst = 0;  aluSrc = 0; memToReg = 0;
            regWrite = 0; memRead = 0; memWrite = 0; branch = 0; aluop = 3'b0xxx; jmp = 0; ExtOp = 0;
        end 
    endcase end
endmodule

