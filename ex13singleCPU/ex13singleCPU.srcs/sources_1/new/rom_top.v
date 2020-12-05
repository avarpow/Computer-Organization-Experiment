`timescale 1ns / 1ps
module rom_top(Clk,Rst,PC,data);
input Clk;//ϵͳʱ��
input Rst;//�ߵ�ƽ��λ
input reg [31:0] PC;//rom��ַ
output [31:0] data;//�������
wire [7:0]addr=PC[9:2];
blk_mem_gen_0 rom (
                  .clka(Clk),    // input wire clka
                  .ena(1'b1),      // input wire ena�����������
                  .addra(addr),  // input wire [7 : 0] addra
                  .douta(data)  // output wire [15 : 0] douta
              );

endmodule