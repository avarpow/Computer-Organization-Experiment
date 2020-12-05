`timescale 1ns / 1ps
module aluctr(
        input [3:0] ALUOp,
        input [5:0] funct, 
        output reg [4:0] ALUCtr
       );

always @(ALUOp or funct) //  如果操作码或者功能码变化执行操作
casex({ALUOp, funct}) // 拼接操作码和功能码便于下一步的判断
    10'b0001xxxxxx: ALUCtr = 5'b00000; // add:addi lb lh lw sb sh sw
    10'b0010xxxxxx: ALUCtr = 5'b00001; // addu:addiu
    10'b0011xxxxxx: ALUCtr = 5'b00010; // sub:beq bne bltz bgez bltzal bgezal beq bne blez
    10'b0100xxxxxx: ALUCtr = 5'b00100; // and:andi
    10'b0101xxxxxx: ALUCtr = 5'b00101; // or:ori
    10'b0110xxxxxx: ALUCtr = 5'b00110; // xor:xori
    10'b0111xxxxxx: ALUCtr = 5'b01000; // slt:slti
    10'b1000xxxxxx: ALUCtr = 5'b01001; // sltu:sltiu
    10'b1001xxxxxx: ALUCtr = 5'b01010; // //lui:lui
//R形
    10'b0000_100000: ALUCtr = 5'b00000; // add
    10'b0000_100001: ALUCtr = 5'b00001; // addu
    10'b0000_100010: ALUCtr = 5'b00010; // sub
    10'b0000_100011: ALUCtr = 5'b00011; // subu
    10'b0000_100100: ALUCtr = 5'b00100; // and
    10'b0000_100101: ALUCtr = 5'b00101; // or
    10'b0000_100110: ALUCtr = 5'b00110; // xor
    10'b0000_100111: ALUCtr = 5'b00111; // nor
    10'b0000_101010: ALUCtr = 5'b01000; // slt
    10'b0000_101011: ALUCtr = 5'b01001; // sltu
    10'b0000_000000: ALUCtr = 5'b01011; // sll
    10'b0000_000010: ALUCtr = 5'b01100; // srl
    10'b0000_000100: ALUCtr = 5'b01101; //sllv
    10'b0000_000110: ALUCtr = 5'b01110; //srlv
    10'b0000_000011: ALUCtr = 5'b01111;//sra
    10'b0000_000111: ALUCtr = 5'b10000;//srav
    10'b0000_011000: ALUCtr = 5'b10001;//mult
    10'b0000_011010: ALUCtr = 5'b10010;//div

    default:ALUCtr = 5'b11111;
endcase
endmodule
