module dataToReg(
    input memToReg,
    input jal,
    input bgezal,
    input bltzal,
    input ZF,
    input PF,
    input [31:0]PCAdd4,
    input [31:0]alures,
    input [31:0]mem_data,
    output [31:0]w_data
);
wire [31:0] muxmemread,muxlink;
assign muxmemread=memToReg?mem_data:alures;
assign muxlink = (jal | (bgezal & (PF | ZF) | (bltzal & (~PF & ~ZF))))? PCAdd4:muxmemread;
assign w_data = muxlink;
endmodule