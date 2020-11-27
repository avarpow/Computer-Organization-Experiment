`timescale 1ns / 1ps
module alu(
input [4:0] shamt,
input [31:0] input1,
input [31:0] input2,
input [3:0] aluCtr, output reg[31:0] aluRes, output reg ZF, output reg CF,OF
);
always @(input1 or input2 or aluCtr) // 运算数或控制码变化时操作
begin
case(aluCtr) 4'b0000: //  与 and
begin
aluRes = input1 & input2; if(aluRes==0) ZF=1; else ZF=0;
end
4'b0001: // 或 or 
begin
aluRes = input1 | input2; if(aluRes==0) ZF=1; else ZF=0;
end
4'b0010: // 加addi add lw sw 
begin
{CF,aluRes} = input1 + input2; if(aluRes==0) ZF=1; else ZF=0;
OF = input1[31]^input2[31]^aluRes[31]^CF;//溢出标志公式
end
4'b0110: // 减sub 
begin
{CF,aluRes} = input1 - input2; if(aluRes == 0)
ZF = 1; else ZF = 0;
OF = input1[31]^input2[31]^aluRes[31]^CF;//溢出标志公式
end
4'b0101: // 或非nor 
begin
aluRes = ~(input1 | input2); if(aluRes==0) ZF=1;
else ZF=0;
end

4'b0111: // 小于设置slt 
begin
if(input1<input2) aluRes = 1;
else aluRes=0; if(aluRes==0) ZF=1; else ZF=0;
end

4'b1000://sll 
begin
aluRes=input2<<shamt; if(aluRes==0) ZF=1; else ZF=0;
end 4'b1001://srl 
begin
aluRes=input2>>shamt; if(aluRes==0) ZF=1; else ZF=0;
end
 4'b0011://bne 
begin
aluRes=input1-input2;
if(aluRes==0) ZF=0;//这里的zero是指不为0，不相等
 else ZF=1;
end
4'b0100://xor 
begin
aluRes=(~input1&input2)|(input1&~input2); if(aluRes==0) ZF=1;
else ZF=0;
end 
4'b0001://andi 
begin
aluRes=input1&input2; if(aluRes==0) ZF=1; else ZF=0;
end 
4'b0010://ori 
begin
aluRes=input1|input2; if(aluRes==0) ZF=1; else ZF=0;
end 
4'b1101://lui 
begin
aluRes={input2[15:0],16'b0000_0000_0000_0000};
end 
default: 
begin
aluRes = 0; ZF=0;OF=0;
 end 
endcase
 end
endmodule
