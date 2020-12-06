`timescale 1ns / 1ps
module rom_top(
    input Clk,//ϵͳʱ��
    input Rst,//�ߵ�ƽ��λ
    input [31:0] PC,//rom��ַ
    output [31:0] data//�������
);
wire [7:0]addr;
reg clk;
assign addr[7:0] = PC[9:2];
initial begin
    clk=0;
    #1;
    clk=1;
    #1
    clk=0;
    #1;
    clk=1;
end
always @(addr)begin 
    clk=0;
    #1;
    clk=1;
    #1;
    clk=0;
    #1;
    clk=1;
end
blk_mem_gen_0 rom (
                  .clka(clk),    // input wire clka
                  .ena(1'b1),      // input wire ena�����������
                  .addra(addr),  // input wire [7 : 0] addra
                  .douta(data)  // output wire [15 : 0] douta
              );

endmodule
