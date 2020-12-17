`timescale 1ns / 1ps
module im(
    input [7:0] Addr,		//
    output reg [31:0]  instruction );// 
    reg [31:0] regs [0:63]; // 
initial
begin
regs[0]=32'h24010008;
regs[1]=32'h34020002;
regs[2]=32'h00411820;
regs[3]=32'h00622822;
regs[4]=32'h00a22024;
regs[5]=32'h00824025;
regs[6]=32'h00084040;
regs[7]=32'h1501fffe;
regs[8]=32'h28460004;
regs[9]=32'h28c70000;
regs[10]=32'h24e70008;
regs[11]=32'h10e1fffe;
regs[12]=32'hac220004;
regs[13]=32'h8c290004;
regs[14]=32'h240afffe;
regs[15]=32'h254a0001;
regs[16]=32'h0540fffe;
regs[17]=32'h304b0002;
regs[18]=32'h08000014;
regs[19]=32'h00824025;
regs[20]=32'h00000000;
regs[21]=32'h3c0a000a;
regs[22]=32'h01660018;
regs[23]=32'h00006010;
regs[24]=32'h00006012;
regs[25]=32'h0166001a;
regs[26]=32'h0c00001b;
regs[27]=32'h0590fffe;
regs[28]=32'h1980fffd;
regs[29]=32'h00cc6804;
regs[30]=32'h200e0084;
regs[31]=32'h01c00008;
regs[32]=32'h00000000;
regs[33]=32'h000c6043;
regs[34]=32'h1d80fffe;
regs[35]=32'h200fffff;
regs[36]=32'h05e1fffc;
regs[37]=32'ha22f0000;
regs[38]=32'ha62f0002;
regs[39]=32'h82300000;
regs[40]=32'h86300002;
regs[41]=32'h01e0802a;
regs[42]=32'h2df0fffb;
regs[43]=32'h01e0802b;
regs[44]=32'h20080008;
regs[45]=32'h00084042;
regs[46]=32'h02084006;
regs[47]=32'h05110000;
regs[48]=32'h010d4821;
regs[49]=32'h010d4823;
regs[50]=32'h010d4827;
regs[51]=32'h010d4826;
regs[52]=32'h01a84807;
regs[53]=32'h390dffff;
regs[54]=32'h0000000c;
regs[55]=32'hfc000000;

end
always @(Addr) // ????????????
    instruction=regs[Addr] ; //  ????
endmodule
