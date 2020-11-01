// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Fri Oct 23 15:55:29 2020
// Host        : DESKTOP-CCVBI4S running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/programme/Computer-Organization-Experiment/ex8alu/ex8alu.srcs/sources_1/bd/diaplay/ip/diaplay_display_0_0/diaplay_display_0_0_sim_netlist.v
// Design      : diaplay_display_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "diaplay_display_0_0,display,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "display,Vivado 2019.2" *) 
(* NotValidForBitStream *)
module diaplay_display_0_0
   (clk,
    data,
    sm_wei,
    sm_duan);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN diaplay_clk_0, INSERT_VIP 0" *) input clk;
  input [15:0]data;
  output [3:0]sm_wei;
  output [6:0]sm_duan;

  wire clk;
  wire [15:0]data;
  wire [6:0]sm_duan;
  wire [3:0]sm_wei;

  diaplay_display_0_0_display inst
       (.Q(sm_wei),
        .clk(clk),
        .data(data),
        .sm_duan(sm_duan));
endmodule

(* ORIG_REF_NAME = "display" *) 
module diaplay_display_0_0_display
   (Q,
    sm_duan,
    clk,
    data);
  output [3:0]Q;
  output [6:0]sm_duan;
  input clk;
  input [15:0]data;

  wire [3:0]Q;
  wire clk;
  wire clk_400Hz;
  wire clk_400Hz_1;
  wire clk_400Hz_i_1_n_0;
  wire [31:0]clk_cnt;
  wire clk_cnt0_carry__0_n_0;
  wire clk_cnt0_carry__0_n_1;
  wire clk_cnt0_carry__0_n_2;
  wire clk_cnt0_carry__0_n_3;
  wire clk_cnt0_carry__1_n_0;
  wire clk_cnt0_carry__1_n_1;
  wire clk_cnt0_carry__1_n_2;
  wire clk_cnt0_carry__1_n_3;
  wire clk_cnt0_carry__2_n_0;
  wire clk_cnt0_carry__2_n_1;
  wire clk_cnt0_carry__2_n_2;
  wire clk_cnt0_carry__2_n_3;
  wire clk_cnt0_carry__3_n_0;
  wire clk_cnt0_carry__3_n_1;
  wire clk_cnt0_carry__3_n_2;
  wire clk_cnt0_carry__3_n_3;
  wire clk_cnt0_carry__4_n_0;
  wire clk_cnt0_carry__4_n_1;
  wire clk_cnt0_carry__4_n_2;
  wire clk_cnt0_carry__4_n_3;
  wire clk_cnt0_carry__5_n_0;
  wire clk_cnt0_carry__5_n_1;
  wire clk_cnt0_carry__5_n_2;
  wire clk_cnt0_carry__5_n_3;
  wire clk_cnt0_carry__6_n_2;
  wire clk_cnt0_carry__6_n_3;
  wire clk_cnt0_carry_n_0;
  wire clk_cnt0_carry_n_1;
  wire clk_cnt0_carry_n_2;
  wire clk_cnt0_carry_n_3;
  wire \clk_cnt[0]_i_2_n_0 ;
  wire \clk_cnt[0]_i_3_n_0 ;
  wire \clk_cnt[0]_i_4_n_0 ;
  wire \clk_cnt[0]_i_5_n_0 ;
  wire \clk_cnt[0]_i_6_n_0 ;
  wire \clk_cnt[0]_i_7_n_0 ;
  wire \clk_cnt[0]_i_8_n_0 ;
  wire \clk_cnt[0]_i_9_n_0 ;
  wire [0:0]clk_cnt_0;
  wire [15:0]data;
  wire [31:1]data0;
  wire [3:0]duan_ctrl__43;
  wire [6:0]sm_duan;
  wire \sm_duan[6]_INST_0_i_5_n_0 ;
  wire \sm_duan[6]_INST_0_i_6_n_0 ;
  wire \sm_duan[6]_INST_0_i_7_n_0 ;
  wire \sm_duan[6]_INST_0_i_8_n_0 ;
  wire [3:2]NLW_clk_cnt0_carry__6_CO_UNCONNECTED;
  wire [3:3]NLW_clk_cnt0_carry__6_O_UNCONNECTED;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFFE0001)) 
    clk_400Hz_i_1
       (.I0(clk_cnt[0]),
        .I1(\clk_cnt[0]_i_4_n_0 ),
        .I2(\clk_cnt[0]_i_3_n_0 ),
        .I3(\clk_cnt[0]_i_2_n_0 ),
        .I4(clk_400Hz),
        .O(clk_400Hz_i_1_n_0));
  FDRE clk_400Hz_reg
       (.C(clk),
        .CE(1'b1),
        .D(clk_400Hz_i_1_n_0),
        .Q(clk_400Hz),
        .R(1'b0));
  CARRY4 clk_cnt0_carry
       (.CI(1'b0),
        .CO({clk_cnt0_carry_n_0,clk_cnt0_carry_n_1,clk_cnt0_carry_n_2,clk_cnt0_carry_n_3}),
        .CYINIT(clk_cnt[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S(clk_cnt[4:1]));
  CARRY4 clk_cnt0_carry__0
       (.CI(clk_cnt0_carry_n_0),
        .CO({clk_cnt0_carry__0_n_0,clk_cnt0_carry__0_n_1,clk_cnt0_carry__0_n_2,clk_cnt0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S(clk_cnt[8:5]));
  CARRY4 clk_cnt0_carry__1
       (.CI(clk_cnt0_carry__0_n_0),
        .CO({clk_cnt0_carry__1_n_0,clk_cnt0_carry__1_n_1,clk_cnt0_carry__1_n_2,clk_cnt0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S(clk_cnt[12:9]));
  CARRY4 clk_cnt0_carry__2
       (.CI(clk_cnt0_carry__1_n_0),
        .CO({clk_cnt0_carry__2_n_0,clk_cnt0_carry__2_n_1,clk_cnt0_carry__2_n_2,clk_cnt0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S(clk_cnt[16:13]));
  CARRY4 clk_cnt0_carry__3
       (.CI(clk_cnt0_carry__2_n_0),
        .CO({clk_cnt0_carry__3_n_0,clk_cnt0_carry__3_n_1,clk_cnt0_carry__3_n_2,clk_cnt0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[20:17]),
        .S(clk_cnt[20:17]));
  CARRY4 clk_cnt0_carry__4
       (.CI(clk_cnt0_carry__3_n_0),
        .CO({clk_cnt0_carry__4_n_0,clk_cnt0_carry__4_n_1,clk_cnt0_carry__4_n_2,clk_cnt0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[24:21]),
        .S(clk_cnt[24:21]));
  CARRY4 clk_cnt0_carry__5
       (.CI(clk_cnt0_carry__4_n_0),
        .CO({clk_cnt0_carry__5_n_0,clk_cnt0_carry__5_n_1,clk_cnt0_carry__5_n_2,clk_cnt0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[28:25]),
        .S(clk_cnt[28:25]));
  CARRY4 clk_cnt0_carry__6
       (.CI(clk_cnt0_carry__5_n_0),
        .CO({NLW_clk_cnt0_carry__6_CO_UNCONNECTED[3:2],clk_cnt0_carry__6_n_2,clk_cnt0_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_clk_cnt0_carry__6_O_UNCONNECTED[3],data0[31:29]}),
        .S({1'b0,clk_cnt[31:29]}));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h00FE)) 
    \clk_cnt[0]_i_1 
       (.I0(\clk_cnt[0]_i_2_n_0 ),
        .I1(\clk_cnt[0]_i_3_n_0 ),
        .I2(\clk_cnt[0]_i_4_n_0 ),
        .I3(clk_cnt[0]),
        .O(clk_cnt_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \clk_cnt[0]_i_2 
       (.I0(\clk_cnt[0]_i_5_n_0 ),
        .I1(\clk_cnt[0]_i_6_n_0 ),
        .I2(clk_cnt[31]),
        .I3(clk_cnt[30]),
        .I4(clk_cnt[1]),
        .I5(\clk_cnt[0]_i_7_n_0 ),
        .O(\clk_cnt[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFB)) 
    \clk_cnt[0]_i_3 
       (.I0(clk_cnt[4]),
        .I1(clk_cnt[5]),
        .I2(clk_cnt[2]),
        .I3(clk_cnt[3]),
        .I4(\clk_cnt[0]_i_8_n_0 ),
        .O(\clk_cnt[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFEFF)) 
    \clk_cnt[0]_i_4 
       (.I0(clk_cnt[12]),
        .I1(clk_cnt[13]),
        .I2(clk_cnt[11]),
        .I3(clk_cnt[10]),
        .I4(\clk_cnt[0]_i_9_n_0 ),
        .O(\clk_cnt[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \clk_cnt[0]_i_5 
       (.I0(clk_cnt[23]),
        .I1(clk_cnt[22]),
        .I2(clk_cnt[25]),
        .I3(clk_cnt[24]),
        .O(\clk_cnt[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \clk_cnt[0]_i_6 
       (.I0(clk_cnt[19]),
        .I1(clk_cnt[18]),
        .I2(clk_cnt[21]),
        .I3(clk_cnt[20]),
        .O(\clk_cnt[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \clk_cnt[0]_i_7 
       (.I0(clk_cnt[27]),
        .I1(clk_cnt[26]),
        .I2(clk_cnt[29]),
        .I3(clk_cnt[28]),
        .O(\clk_cnt[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \clk_cnt[0]_i_8 
       (.I0(clk_cnt[7]),
        .I1(clk_cnt[6]),
        .I2(clk_cnt[9]),
        .I3(clk_cnt[8]),
        .O(\clk_cnt[0]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \clk_cnt[0]_i_9 
       (.I0(clk_cnt[15]),
        .I1(clk_cnt[14]),
        .I2(clk_cnt[16]),
        .I3(clk_cnt[17]),
        .O(\clk_cnt[0]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \clk_cnt[31]_i_1 
       (.I0(clk_cnt[0]),
        .I1(\clk_cnt[0]_i_4_n_0 ),
        .I2(\clk_cnt[0]_i_3_n_0 ),
        .I3(\clk_cnt[0]_i_2_n_0 ),
        .O(clk_400Hz_1));
  FDRE \clk_cnt_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(clk_cnt_0),
        .Q(clk_cnt[0]),
        .R(1'b0));
  FDRE \clk_cnt_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[10]),
        .Q(clk_cnt[10]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[11]),
        .Q(clk_cnt[11]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[12]),
        .Q(clk_cnt[12]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[13]),
        .Q(clk_cnt[13]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[14]),
        .Q(clk_cnt[14]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[15]),
        .Q(clk_cnt[15]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[16]),
        .Q(clk_cnt[16]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[17]),
        .Q(clk_cnt[17]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[18]),
        .Q(clk_cnt[18]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[19]),
        .Q(clk_cnt[19]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[1]),
        .Q(clk_cnt[1]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[20]),
        .Q(clk_cnt[20]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[21]),
        .Q(clk_cnt[21]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[22]),
        .Q(clk_cnt[22]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[23]),
        .Q(clk_cnt[23]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[24]),
        .Q(clk_cnt[24]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[25]),
        .Q(clk_cnt[25]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[26]),
        .Q(clk_cnt[26]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[27]),
        .Q(clk_cnt[27]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[28]),
        .Q(clk_cnt[28]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[29]),
        .Q(clk_cnt[29]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[2]),
        .Q(clk_cnt[2]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[30]),
        .Q(clk_cnt[30]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[31]),
        .Q(clk_cnt[31]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[3]),
        .Q(clk_cnt[3]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[4]),
        .Q(clk_cnt[4]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[5]),
        .Q(clk_cnt[5]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[6]),
        .Q(clk_cnt[6]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[7]),
        .Q(clk_cnt[7]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[8]),
        .Q(clk_cnt[8]),
        .R(clk_400Hz_1));
  FDRE \clk_cnt_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[9]),
        .Q(clk_cnt[9]),
        .R(clk_400Hz_1));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h2894)) 
    \sm_duan[0]_INST_0 
       (.I0(duan_ctrl__43[3]),
        .I1(duan_ctrl__43[2]),
        .I2(duan_ctrl__43[0]),
        .I3(duan_ctrl__43[1]),
        .O(sm_duan[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hA4C8)) 
    \sm_duan[1]_INST_0 
       (.I0(duan_ctrl__43[3]),
        .I1(duan_ctrl__43[2]),
        .I2(duan_ctrl__43[1]),
        .I3(duan_ctrl__43[0]),
        .O(sm_duan[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hA210)) 
    \sm_duan[2]_INST_0 
       (.I0(duan_ctrl__43[3]),
        .I1(duan_ctrl__43[0]),
        .I2(duan_ctrl__43[1]),
        .I3(duan_ctrl__43[2]),
        .O(sm_duan[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hC214)) 
    \sm_duan[3]_INST_0 
       (.I0(duan_ctrl__43[3]),
        .I1(duan_ctrl__43[2]),
        .I2(duan_ctrl__43[0]),
        .I3(duan_ctrl__43[1]),
        .O(sm_duan[3]));
  LUT4 #(
    .INIT(16'h5710)) 
    \sm_duan[4]_INST_0 
       (.I0(duan_ctrl__43[3]),
        .I1(duan_ctrl__43[1]),
        .I2(duan_ctrl__43[2]),
        .I3(duan_ctrl__43[0]),
        .O(sm_duan[4]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h5190)) 
    \sm_duan[5]_INST_0 
       (.I0(duan_ctrl__43[3]),
        .I1(duan_ctrl__43[2]),
        .I2(duan_ctrl__43[0]),
        .I3(duan_ctrl__43[1]),
        .O(sm_duan[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h4025)) 
    \sm_duan[6]_INST_0 
       (.I0(duan_ctrl__43[3]),
        .I1(duan_ctrl__43[0]),
        .I2(duan_ctrl__43[2]),
        .I3(duan_ctrl__43[1]),
        .O(sm_duan[6]));
  LUT5 #(
    .INIT(32'hFFFF4F45)) 
    \sm_duan[6]_INST_0_i_1 
       (.I0(Q[2]),
        .I1(data[11]),
        .I2(Q[3]),
        .I3(data[15]),
        .I4(\sm_duan[6]_INST_0_i_5_n_0 ),
        .O(duan_ctrl__43[3]));
  LUT5 #(
    .INIT(32'hFFFF4F45)) 
    \sm_duan[6]_INST_0_i_2 
       (.I0(Q[2]),
        .I1(data[8]),
        .I2(Q[3]),
        .I3(data[12]),
        .I4(\sm_duan[6]_INST_0_i_6_n_0 ),
        .O(duan_ctrl__43[0]));
  LUT5 #(
    .INIT(32'hFFFF4F45)) 
    \sm_duan[6]_INST_0_i_3 
       (.I0(Q[2]),
        .I1(data[10]),
        .I2(Q[3]),
        .I3(data[14]),
        .I4(\sm_duan[6]_INST_0_i_7_n_0 ),
        .O(duan_ctrl__43[2]));
  LUT5 #(
    .INIT(32'hFFFF4F45)) 
    \sm_duan[6]_INST_0_i_4 
       (.I0(Q[2]),
        .I1(data[9]),
        .I2(Q[3]),
        .I3(data[13]),
        .I4(\sm_duan[6]_INST_0_i_8_n_0 ),
        .O(duan_ctrl__43[1]));
  LUT6 #(
    .INIT(64'hD5D5FF7F9595FF7F)) 
    \sm_duan[6]_INST_0_i_5 
       (.I0(Q[0]),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(data[7]),
        .I4(Q[1]),
        .I5(data[3]),
        .O(\sm_duan[6]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hD5D5FF7F9595FF7F)) 
    \sm_duan[6]_INST_0_i_6 
       (.I0(Q[0]),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(data[4]),
        .I4(Q[1]),
        .I5(data[0]),
        .O(\sm_duan[6]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hD5D5FF7F9595FF7F)) 
    \sm_duan[6]_INST_0_i_7 
       (.I0(Q[0]),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(data[6]),
        .I4(Q[1]),
        .I5(data[2]),
        .O(\sm_duan[6]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hD5D5FF7F9595FF7F)) 
    \sm_duan[6]_INST_0_i_8 
       (.I0(Q[0]),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(data[5]),
        .I4(Q[1]),
        .I5(data[1]),
        .O(\sm_duan[6]_INST_0_i_8_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \wei_ctrl_reg[0] 
       (.C(clk_400Hz),
        .CE(1'b1),
        .D(Q[3]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \wei_ctrl_reg[1] 
       (.C(clk_400Hz),
        .CE(1'b1),
        .D(Q[0]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \wei_ctrl_reg[2] 
       (.C(clk_400Hz),
        .CE(1'b1),
        .D(Q[1]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \wei_ctrl_reg[3] 
       (.C(clk_400Hz),
        .CE(1'b1),
        .D(Q[2]),
        .Q(Q[3]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
