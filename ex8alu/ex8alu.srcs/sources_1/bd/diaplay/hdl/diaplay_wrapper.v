//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
//Date        : Fri Oct 23 15:54:39 2020
//Host        : DESKTOP-CCVBI4S running 64-bit major release  (build 9200)
//Command     : generate_target diaplay_wrapper.bd
//Design      : diaplay_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module diaplay_wrapper
   (clk_0,
    data_0,
    sm_duan_0,
    sm_wei_0);
  input clk_0;
  input [15:0]data_0;
  output [6:0]sm_duan_0;
  output [3:0]sm_wei_0;

  wire clk_0;
  wire [15:0]data_0;
  wire [6:0]sm_duan_0;
  wire [3:0]sm_wei_0;

  diaplay diaplay_i
       (.clk_0(clk_0),
        .data_0(data_0),
        .sm_duan_0(sm_duan_0),
        .sm_wei_0(sm_wei_0));
endmodule
