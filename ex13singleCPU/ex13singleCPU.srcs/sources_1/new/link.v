module link(
    input jal,
    input bgezal,
    input bltzal,
    input ZF,
    input PF,
    input [4:0]reg_W_Addr,
    output [4:0]W_Addr
);
    assign W_Addr=(jal | (bgezal & (PF | ZF) | (bltzal & (~PF & ~ZF))))?5'b11111:reg_W_Addr;
endmodule