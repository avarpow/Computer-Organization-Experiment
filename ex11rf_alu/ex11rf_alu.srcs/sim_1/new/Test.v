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
    Clk=0;#50;//ÇåÁã
    Clk=1;#50; //¼Ä´æÆ÷ÇåÁã
    Clr=0; 
    Clk=0;#50;
    Clr=1;
    Clk=1;#50;    
    Clr=0;            
    Write_Reg=1;Write_Select=1'b1;Input_Data=32'h00000007; W_Addr=5'b00001;//¼Ä´æÆ÷1Ð´Èë7
    Clk=0;#50;
    Clk=1;#50;
    Write_Select=1'b1;Input_Data=32'h00000004; W_Addr=5'b00010;//¼Ä´æÆ÷1Ð´Èë4
    Clk=0;#50;
    Clk=1;#50;
    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0100;W_Addr=5'b00011;//¼Ó·¨
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%1d R_Data_B=%1d OP=+ ALU_F=%3d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);

    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0101;W_Addr=5'b00100;//¼õ·¨
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%1d R_Data_B=%1d OP=- ALU_F=%3d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);
    
    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0001;W_Addr=5'b00101;//»ò
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%1d R_Data_B=%1d OP=or ALU_F=%3d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);
    
    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0010;W_Addr=5'b00110;//Òì»ò
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%1d R_Data_B=%1d OP=xor ALU_F=%3d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);
    
    Write_Select=1'b0;R_Addr_A=5'b00001;R_Addr_B=5'b00010;OP=4'b0111;W_Addr=5'b00111;//×óÒÆ
    Clk=0;#50;
    Clk=1;#50;
    $display ("%0t R_Data_A=%1d R_Data_B=%1d OP=<< ALU_F=%3d ZF=%1b CF=%1b OF=%1b SF=%1b PF=%1b",
    $time, R_Data_A,R_Data_B,ALU_F,ZF,CF,OF,SF,PF);
    Clk=0;#50;
    Clk=1;#50;
    
end        //ÊµÀý»¯¼Ä´æÆ÷¶ÑÄ£¿é
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

