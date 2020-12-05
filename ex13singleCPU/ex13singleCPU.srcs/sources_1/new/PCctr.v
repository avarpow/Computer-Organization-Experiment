module PCctr 
(
    input clkin,
    //input [31:0] CPC,
    input [25:0] target,
    input [16:0] imme,
    input [31:0] R_Data_A,
    input jmp,
    input jal,
    input jr,
    input bne,
    input beq,
    input bgez,
    input bgezal,
    input blez,
    input bltz,
    input bltzal,
    input PCWrite,
    input ZF,
    input PF,
    output reg [31:0] PC,
    output CPCadd4
);
wire[31:0] CPCadd4,jumpAddr,branchAddr,jrAddr,extimm,nextPC,muxjump,muxbranch,muxjr;
assign CPCadd4=PC+4;
assign extimm = {{14{imm_16[15]}},imm_16[15:0], {2{1'b0}}};;//branch偏移量
assign jumpAddr={CPC[31:28],target, {2{1'b0}}};//jump 地址target<<2
assign branchAddr = CPC+extimm;//branch跳转地址
assign jrAddr=R_Data_A;
assign muxjump=(jmp | jal)?jumpAddr:CPCadd4;
assign muxbranch=((bne & (~ZF))|(beq & ZF)|((bgez|bgezal) & (PF | ZF)) | (blez & (~PF)) | ((bltz | bltzal) & (~PF & ~ZF)))?muxjump:branchAddr;
assign muxjr = jr?muxbranch:jrAddr;
assign nextPC = muxjr;
initial begin
    PC=32'h00000000;
end
always @(negedge clkin)
	  begin
			PC<=nextPC;
	  end
endmodule  //PCctr