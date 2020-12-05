`timescale 1ns / 1ps
module NPC
(
	input Branch, Jump, Clk,
	input Z,	//for blez
	input [31:0] CPC,
	input [15:0] imm_16,
	input [25:0] target,
	output [31:0] NPC
);

	wire[31:0] tmp1,tmp2,tmp3,tmp4,extimm,nextPC;
	wire tmp;
	assign tmp=Branch&Z;
	assign tmp1=CPC+4;
	assign extimm={{14{imm_16[15]}},imm_16[15:0], {2{1'b0}}};
	assign tmp2=extimm+CPC;
	assign tmp3=(tmp)?tmp2:tmp1;
	assign tmp4={CPC[31:28],target, {2{1'b0}}};
	assign nextPC=(Jump)?tmp4:tmp3;
	PCCount pcc(nextPC, Clk, NPC);
endmodule 
module PCCount
(
	input[31:0] NPC,
	input Clk,
	output reg[31:0] PC
);
    always @(negedge Clk)
	  begin
			PC<=NPC;
	  end
	  
endmodule
