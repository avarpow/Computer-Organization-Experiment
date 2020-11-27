`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/25 09:18:15
// Design Name:
// Module Name: ctrsim
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


module ctrsim;
// Inputs
reg [5:0] opCode;
// Outputs
wire regDst;
wire aluSrc;
wire memToReg;
wire regWrite;
wire memRead;
wire memWrite;
wire branch;
wire [3:0] aluop;
wire jmp;
// Instantiate the Unit Under Test (UUT)
ctr uut (
    .opCode(opCode),
    .regDst(regDst),
    .aluSrc(aluSrc),
    .memToReg(memToReg),
    .regWrite(regWrite),
    .memRead(memRead),
    .memWrite(memWrite),
    .branch(branch),
    .aluop(aluop),
    .jmp(jmp)
);
initial begin
    $timeformat(-9, 0, " ns");
    opCode = 6'b000000;
    $display ("%0t opCode=%6b regDst=%1b aluSrc=%1b memToReg=%1b regWrite=%1b memRead=%1b memWrite=%1b branch=%1b aluop=%4b jmp=%1b",
    $time, opCode,regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluop,jmp);
    #100;
    opCode = 6'b000010;
    $display ("%0t opCode=%6b regDst=%1b aluSrc=%1b memToReg=%1b regWrite=%1b memRead=%1b memWrite=%1b branch=%1b aluop=%4b jmp=%1b",
    $time, opCode,regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluop,jmp);
    #100;
    opCode = 6'b110000;//不存在的指令
    $display ("%0t opCode=%6b regDst=%1b aluSrc=%1b memToReg=%1b regWrite=%1b memRead=%1b memWrite=%1b branch=%1b aluop=%4b jmp=%1b",
    $time, opCode,regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluop,jmp);
    #100;
    opCode = 6'b100011;
    $display ("%0t opCode=%6b regDst=%1b aluSrc=%1b memToReg=%1b regWrite=%1b memRead=%1b memWrite=%1b branch=%1b aluop=%4b jmp=%1b",
    $time, opCode,regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluop,jmp);
    #100;
    opCode = 6'b000100;
    $display ("%0t opCode=%6b regDst=%1b aluSrc=%1b memToReg=%1b regWrite=%1b memRead=%1b memWrite=%1b branch=%1b aluop=%4b jmp=%1b",
    $time, opCode,regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluop,jmp);
    #100;
    opCode = 6'b001000;
    $display ("%0t opCode=%6b regDst=%1b aluSrc=%1b memToReg=%1b regWrite=%1b memRead=%1b memWrite=%1b branch=%1b aluop=%4b jmp=%1b",
    $time, opCode,regDst,aluSrc,memToReg,regWrite,memRead,memWrite,branch,aluop,jmp);
end
endmodule

