module PCctr 
(
    input clkin,
    input reset,
    //input [31:0] CPC,
    input PCWrite,
    input [25:0] target,
    input [15:0] imm_16,
    input [31:0] R_Data_A,
    input jmp,
    input jal,
    input jr,
    input bne,
    input beq,
    input bgez,
    input bgezal,
    input bgtz,
    input blez,
    input bltz,
    input bltzal,
    input ZF,
    input PF,
    output reg [31:0] PC,
    output [31:0]CPCadd4
);
wire[31:0] NPC,jumpAddr,branchAddr,jrAddr,extimm,nextPC,muxjump,muxbranch,muxjr,muxPCWrite;
assign NPC=PC;
assign CPCadd4=PC+4;
assign extimm = {{14{imm_16[15]}},imm_16[15:0], {2{1'b0}}};//branch偏移量
assign jumpAddr={PC[31:28],target, {2{1'b0}}};//jump 地址target<<2
assign branchAddr = CPCadd4+extimm;//branch跳转地址
assign jrAddr=R_Data_A;
assign muxjump=(jmp | jal)?jumpAddr:CPCadd4;
assign muxbranch=((bne & (~ZF))|(beq & ZF)|((bgez|bgezal) & (PF | ZF)) | (blez & (~PF))| (bgtz & PF) | ((bltz | bltzal) & (~PF & ~ZF)))?branchAddr:muxjump;
assign muxjr = jr?jrAddr:muxbranch;
assign muxPCWrite = PCWrite?muxjr:NPC;
assign nextPC = muxPCWrite;
initial begin
    PC=32'h00000000;
end

always @(negedge clkin ,posedge reset)
	begin
        if(~reset)
			PC<=nextPC;
        else
            PC<=32'h00000000;
	end
endmodule  //PCctr