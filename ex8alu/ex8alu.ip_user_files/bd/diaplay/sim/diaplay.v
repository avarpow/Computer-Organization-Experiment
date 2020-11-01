//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
//Date        : Fri Oct 23 15:54:39 2020
//Host        : DESKTOP-CCVBI4S running 64-bit major release  (build 9200)
//Command     : generate_target diaplay.bd
//Design      : diaplay
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "diaplay,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=diaplay,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "diaplay.hwdef" *) 
module diaplay
   (clk_0,
    data_0,
    sm_duan_0,
    sm_wei_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN diaplay_clk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  input [15:0]data_0;
  output [6:0]sm_duan_0;
  output [3:0]sm_wei_0;

  wire clk_0_1;
  wire [15:0]data_0_1;
  wire [6:0]display_0_sm_duan;
  wire [3:0]display_0_sm_wei;

  assign clk_0_1 = clk_0;
  assign data_0_1 = data_0[15:0];
  assign sm_duan_0[6:0] = display_0_sm_duan;
  assign sm_wei_0[3:0] = display_0_sm_wei;
  diaplay_display_0_0 display_0
       (.clk(clk_0_1),
        .data(data_0_1),
        .sm_duan(display_0_sm_duan),
        .sm_wei(display_0_sm_wei));
endmodule
