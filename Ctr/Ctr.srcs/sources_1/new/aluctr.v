`timescale 1ns / 1ps
module aluctr(
input [3:0] ALUOp, input [5:0] funct, output reg [3:0]  ALUCtr
);

always @(ALUOp or funct) //  如果操作码或者功能码变化执行操作
casex({ALUOp, funct}) // 拼接操作码和功能码便于下一步的判断
10'b0011xxxxxx: ALUCtr = 4'b0010; // lw，sw，addi 
10'b0101xxxxxx: ALUCtr = 4'b0110; // beq 
10'b0110xxxxxx: ALUCtr = 4'b0011; // bne
10'b0000100000: ALUCtr = 4'b0010; // add 
10'b0000100010: ALUCtr = 4'b0110; // sub 
10'b0000100100: ALUCtr = 4'b0000; // and 
10'b0000100101: ALUCtr = 4'b0001; // or 
10'b0000101010: ALUCtr = 4'b0111; // slt
10'b0111xxxxxx: ALUCtr = 4'b1101;//lui

10'b0010xxxxxx: ALUCtr = 4'b0001; // ori
default:ALUCtr = 4'b1111; 
endcase 
endmodule
