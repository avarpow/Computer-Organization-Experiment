`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/11/13 15:03:01
// Design Name:
// Module Name: Test
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


module Test();
reg  Clk, Clr, Write_Reg;
reg Write_Select;
reg [4:0] R_Addr_A ,R_Addr_B, W_Addr;
reg [31:0]  Input_Data;
reg [3:0] OP;
wire [31:0] R_Data_A, R_Data_B, ALU_F;
wire ZF,CF,OF,SF,PF;
wire [31:0]  W_Data;

initial begin
    $timeformat(-9, 0, " ns");
    Clr=1;
    Clk=0;#50;//清零
    Clk=1;#50; //寄存器清零
    Clr=0; Write_Select=1'b0;R_Addr_A=5'b00000;R_Addr_B=5'b00000;OP=4'b0000;W_Addr=5'b00000;//加法
    Clk=0;#50;
    Clk=1;#50;                
    Write_Select=1'b1;Input_Data=32'h00000007; W_Addr=5'b00001;//寄存器1写入7
    Clk=0;#50;
    Clk=1;#50;
    Write_Select=1'b1;Input_Data=32'h00000004; W_Addr=5'b00010;//寄存器1写入4
    Clk=0;#50;
    Clk=1;#50;
    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0100;W_Addr=5'b00011;//加法
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%d R_Data_B=%d OP=+ ALU_F=%d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);

    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0101;W_Addr=5'b00100;//减法
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%d R_Data_B=%d OP=- ALU_F=%d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);
    
    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0001;W_Addr=5'b00101;//或
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%d R_Data_B=%d OP=or ALU_F=%d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);
    
    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0010;W_Addr=5'b00110;//异或
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%d R_Data_B=%d OP=xor ALU_F=%d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);
    
    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0111;W_Addr=5'b00111;//左移
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%d R_Data_B=%d OP=<< ALU_F=%d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);
    
end        //实例化寄存器堆模块
RF_ALU RF_Test(
           .Clk(Clk),
           .Clr(Clr),
           .Write_Reg(Write_Reg),
           .Write_Select(Write_Select),
           .R_Addr_A(R_Addr_A),
           .R_Addr_B(R_Addr_B),
           .W_Addr(W_Addr),
           .Input_Data(Input_Data),
           .R_Data_A(R_Data_A),
           .R_Data_B(R_Data_B),
           .OP(OP),
           .ZF(ZF),
           .CF(CF),
           .OF(OF),
           .SF(SF),
           .PF(PF),
           .ALU_F(ALU_F),
           .W_Data(W_Data)
       );

endmodule

