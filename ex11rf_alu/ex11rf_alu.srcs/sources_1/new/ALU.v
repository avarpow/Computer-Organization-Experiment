`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/13 15:00:20
// Design Name:
// Module Name: ALU
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

module ALU(OP,A,B,F,ZF,CF,OF,SF,PF);
parameter SIZE = 32;//运算位数
input [3:0] OP;//运算操作
input [SIZE:1] A;//左运算数
input [SIZE:1] B;//右运算数
output [SIZE:1] F;//运算结果
output      ZF, //0标志位, 运算结果为0(全零)则置1, 否则置0
            CF, //进借位标志位, 取最高位进位C,加法时C=1则CF=1表示有进位,减法时C=0则CF=1表示有借位
            OF, //溢出标志位，对有符号数运算有意义，溢出则OF=1，否则为0
            SF, //符号标志位，与F的最高位相同
            PF; //奇偶标志位，F有奇数个1，则PF=1，否则为0
reg [SIZE:1] F;
reg C,ZF,CF,OF,SF,PF;//C为最高位进位
always@(*)
begin
    C=0;
    case(OP)
        4'b0000:begin F=A&B; end    //按位与
        4'b0001:begin F=A|B; end    //按位或
        4'b0010:begin F=A^B; end    //按位异或
        4'b0011:begin F=~(A|B); end //按位或非
        4'b0100:begin {C,F}=A+B; end //加法
        4'b0101:begin {C,F}=A-B; end //减法
        4'b0110:begin F=A<B; end//A<B则F=1，否则F=0
        4'b0111:begin F=B<<A; end   //将B左移A位
    endcase
    ZF = F==0;//F全为0，则ZF=1
    CF = C; //进位借位标志
    OF = A[SIZE]^B[SIZE]^F[SIZE]^C;//溢出标志公式
    SF = F[SIZE];//符号标志,取F的最高位
    PF = ^F;//奇偶标志，F有奇数个1，则F=1；偶数个1，则F=0
end
endmodule
