// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Fri Oct 23 15:55:29 2020
// Host        : DESKTOP-CCVBI4S running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/programme/Computer-Organization-Experiment/ex8alu/ex8alu.srcs/sources_1/bd/diaplay/ip/diaplay_display_0_0/diaplay_display_0_0_stub.v
// Design      : diaplay_display_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "display,Vivado 2019.2" *)
module diaplay_display_0_0(clk, data, sm_wei, sm_duan)
/* synthesis syn_black_box black_box_pad_pin="clk,data[15:0],sm_wei[3:0],sm_duan[6:0]" */;
  input clk;
  input [15:0]data;
  output [3:0]sm_wei;
  output [6:0]sm_duan;
endmodule
