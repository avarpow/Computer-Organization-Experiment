`timescale 1ns / 1ps
module ctrsim;

// Inputs
reg [5:0] opCode;

// Outputs 
wire regDst; wire aluSrc;
wire memToReg; wire regWrite; wire memRead; wire memWrite; wire branch; wire [1:0] aluop; wire jmp;

// Instantiate the Unit Under Test (UUT) 
ctr uut (
.opCode(opCode),
.regDst(regDst),
.aluSrc(aluSrc),
.memToReg(memToReg),
.regWrite(regWrite),
.memRead(memRead),
.memWrite(memWrite),
#100;
opCode = 6'b001000; end

endmodule
