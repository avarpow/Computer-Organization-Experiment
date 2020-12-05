`timescale 1ns / 1ps
module rom_top(
    input Clk,//系统时钟
    input Rst,//高电平复位
    input [31:0] PC,//rom地址
    output [31:0] data//输出数据
);
wire [7:0]addr;
assign addr[7:0] = PC[9:2];
blk_mem_gen_0 rom (
                  .clka(Clk),    // input wire clka
                  .ena(1'b1),      // input wire ena数据输出允许
                  .addra(addr),  // input wire [7 : 0] addra
                  .douta(data)  // output wire [15 : 0] douta
              );

endmodule
