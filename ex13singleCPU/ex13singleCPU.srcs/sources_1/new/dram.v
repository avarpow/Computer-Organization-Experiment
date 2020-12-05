`timescale 1ns / 1ps
module dram (input clk, memwrite,
             input reset,
             input [1:0] flag,//00-> byte 01->half word  1x->word
             input [7:0] addr,
             input [31:0] write_data,
             output [31:0] read_data);

reg [7:0] RAM[255:0];

//read
assign read_data=flag[1]? { {RAM[addr+3]},{RAM[addr+2]},{RAM[addr+1]},{RAM[addr+0]}} : ( flag[0]?{ {16{RAM[addr+1][7]}} ,{RAM[addr+1]},{RAM[addr]} }:{ {24{RAM[addr][7]}} ,RAM[addr]} );

//write flag作为字节或字半字操作的标志
integer i;
always @ (posedge clk,posedge reset)
begin
    if(reset)begin
        for(i = 0; i < 256; i = i + 1)
            RAM[i]=0;
    end
    else if (memwrite) begin
        if(flag==2'b00)
        begin
            RAM[addr]=write_data[7:0];
        end
        else if(flag==2'b01 )
        begin
            { {RAM[addr+1]},{RAM[addr]} }=write_data[15:0];
        end
        else if(flag==2'b11 )
        begin
            { {RAM[addr+3]},{RAM[addr+2]},{RAM[addr+1]},{RAM[addr+0]}}=write_data;
        end
    end
end
endmodule
