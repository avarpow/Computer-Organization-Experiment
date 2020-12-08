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
    input regWrite,
    output [31:0]w_data,
    output link_reg_write
);
wire [31:0] muxmemread,muxlink;
assign muxmemread=memToReg?mem_data:alures;
assign muxlink = (jal | (bgezal & (PF | ZF) | (bltzal & (~PF & ~ZF))))? PCAdd4:muxmemread;
assign w_data = muxlink;
assign link_reg_write =  (jal | (bgezal & (PF | ZF) | (bltzal & (~PF & ~ZF))))?1'b1:regWrite;
endmodule