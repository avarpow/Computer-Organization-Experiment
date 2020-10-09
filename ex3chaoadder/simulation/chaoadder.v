module chaoadder(
    input [3:0]A,
    input [3:0]B,
    input C0,
    output C4,
    output [3:0] F);

    wire[3:0] A,B;
    reg[3:0] F,P,G;
    reg y;
    reg [4:0] C;
    assign C4=C[4];
    always @(*) begin
        //G 表示不考虑后面的进位，这里是否有进位
        G[0]=A[0]&B[0];
        G[1]=A[1]&B[1];
        G[2]=A[2]&B[2];
        G[3]=A[3]&B[3];
        //P 表示a或b在这一位上至少有一个
        P[0]=A[0]|B[0];
        P[1]=A[1]|B[1];
        P[2]=A[2]|B[2];
        P[3]=A[3]|B[3];
        //C 表示该位是否向前一位进位的结果
        C[0]=C0;
        C[1]=G[0]|(P[0]&C[0]);
        C[2]=G[1]|(P[1]&C[1]);
        C[3]=G[2]|(P[2]&C[2]);
        C[4]=G[3]|(P[3]&C[3]);
        //F表示 加法最终的结果
        F[0]=A[0]^B[0]^C[0];
        F[1]=A[1]^B[1]^C[1];
        F[2]=A[2]^B[2]^C[2];
        F[3]=A[3]^B[3]^C[3];

end
endmodule 