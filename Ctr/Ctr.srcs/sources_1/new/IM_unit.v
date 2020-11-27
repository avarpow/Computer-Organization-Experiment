`timescale 1ns / 1ps
module IM_unit( input clk,
                input [3:0] Addr,		//指令存储器地址编码
                output reg [31:0]  instruction );// 寄存器的值
//寄存器地址都是 4 位二进制数，因为寄存器只有 16 个，4 位就能表示所有寄存器
reg [31:0] regs [0:15]; // 寄存器组
initial
begin
    regs[0]  = 32'h20110003;// addi $s1,$0,3 #alures=3
    regs[1]  = 32'h20120005;// addi $s2,$0,5 #alures=5
    //regs[2]原始的有错误原来第四位为2，应该为3,已经修改
    regs[2]  = 32'h20130003;// addi $s3,$0,3  #alures=3
    regs[3]  = 32'h2324820;// add $t1,$s1,$s2 #t1=3+5=8, alures=8
    regs[4]  = 32'h02515022;// sub $t2,$s2,$s1	#t2=5-3=2, alures=2
    regs[5]  = 32'h20111535;// addi $s1,$0,0x00001535 #aluRes=1535
    regs[6]  = 32'h2324824;// and $t1,$s1,$s2 #011&101=001, alures=1
    //regs[7]的指令注释有错误，应该为addi $s2,$0,2446
    regs[7]  = 32'h20122446;//add $t2,$t2,$0（错误）
    //regs[8]的指令注释有错误，应该为sw   mem(0),$17(s1),0
    regs[8]  = 32'hac110000;// lw（错误）
    //regs[9]的指令注释有错误，应该为sw   mem(0),$18(s2),4
    regs[9]  = 32'hac120004;// sw（错误）
    //regs[10]的指令注释有错误，应该为add  $4,$4,$3
    regs[10]  = 32'h00832020;//add $4,$2,$3
    regs[11]  = 32'h00831022;//sub $2,$4,$3
    //regs[12]的指令注释有部分错误，应该为lui  $7,4099
    regs[12]  = 32'h3c471003;// lui（不完整）
    //regs[13]的指令注释有部分错误，应该为slitu $1,$2,6186
    regs[13]  = 32'b00101100001000100001100000101010;// addi（错误）
    regs[14]  = 32'h00831025;//or $2,$4,$3
    regs[15]  = 32'h00831024;//and $2,$4,$3
end
always @( posedge clk ) // 时钟上升沿操作
    instruction=regs[Addr] ; //  取指令
endmodule
