module cpu( clk, rst );
    input           clk;
    input           rst;
    wire    IFID_stall;
    wire    IFID_flush;
    wire    [31:0]   IFID_ins;
    wire    [31:0]   IFID_pc;
    IF_ID    IF_ID( .clk(clk), .rst(rst), .IFID_stall(IFID_stall), .IFID_flush(IFID_flush),  
                    .pc(pc),   .ins(ins),                                                    
                    .IFID_pc(IFID_pc),    .IFID_ins(IFID_ins));       

    wire    [31:0]  npc;
    wire            PC_stall;
    wire    [31:0]  pc;
    wire            jump;
    PC      PC      ( .clk(clk), .rst(rst), .PC_stall(PC_stall), .jump(jump), .npc(npc), .pc(pc) );
    wire    [31:0] ins;
    IM      IM      ( .pc(pc), .ins(ins) );

    wire    [2:0]   NPCOp;
    NPC     NPC     ( .clk(clk),   .pc(IFID_pc),    .NPCOp(NPCOp),   .IMM(IFID_ins[25:0]), .Rt(IFID_ins[20:16]), 
                      .RD1(NPC_1),   .RD2(NPC_2),       .npc(npc) );
    //NPC forward
    wire    [31:0]  NPC_1;
    wire    [31:0]  NPC_2;
    wire    [31:0]  ALUout;
    wire    [31:0]  EXEMEM_ALUout;
    mux2    NPC1  ( .d0(RD1), .d1(ALUout), .s(NPC_F1), .y(NPC_1) ); 
    mux2    NPC2  ( .d0(RD2), .d1(ALUout), .s(NPC_F2), .y(NPC_2) ); 

    wire [31:0]     RD1;
    wire [31:0]     RD2;
    wire            MEMWB_RFWr; 
    wire [4:0]      MEMWB_rd;   
    wire [31:0]     WD;         

    RF      RF      ( .clk(clk), .rst(rst), 
                      .RFWr(MEMWB_RFWr), .A1(IFID_ins[25:21]), .A2(IFID_ins[20:16]), .A3(MEMWB_rd), .WD(WD),   
                      .RD1(RD1), .RD2(RD2) );

    wire    [1:0]   EXTOp;
    wire    [31:0]  Imm32;
    EXT     EXT     ( .Imm16(IFID_ins[15:0]), .EXTOp(EXTOp), .Imm32(Imm32) );

    wire    [4:0]   rd;
    wire    [1:0]   RegDst;    
    mux4    RDmux  ( .d0(IFID_ins[20:16]), .d1(IFID_ins[15:11]), .d2(31), .d3(0), .s(RegDst), .y(rd) );    
    //SW  forward
    wire    [1:0]   SW_ctrl;

    wire    [31:0]  RD2final;
    wire    [31:0]  DMout;
    mux4    sw_foward   ( .d0(RD2),  .d1(EXEMEM_ALUout), .d2(DMout),  .d3(0), .s(SW_ctrl), .y(RD2final) ); 


    //IDEXE
    wire    [31:0]  IDEXE_RD2;
    wire    [31:0]  IDEXE_RD1;
    wire    [1:0]   IDEXE_DMWr;      
    wire    [31:0]  IDEXE_ins;
    wire    [4:0]   IDEXE_rd;
    wire    [31:0]  IDEXE_Imm32;
    wire            IDEXE_ALUSrc2;
    wire    [3:0]   IDEXE_DMRd;      
    wire    [2:0]   IDEXE_NPCOp;     
    wire            IDEXE_RFWr;
    wire            IDEXE_ALUSrc1;
    wire    [31:0]  IDEXE_pc;
    wire    [1:0]   IDEXE_RegDst;    
    wire    [1:0]   IDEXE_toReg;     
    wire    [3:0]   IDEXE_ALUOp;     

    //ctrl_unit
    wire    [3:0]   ALUOp;
    wire    [1:0]   DMWr;
    wire    [3:0]   DMRd;
    wire    [1:0]   toReg;
    wire            ALUSrc1;
    wire            ALUSrc2;
    ctrl_unit ctrl_unit( .opcode(IFID_ins[31:26]), .func(IFID_ins[5:0]), 
                         .RegDst(RegDst),     .NPCOp(NPCOp),    .DMRd(DMRd), .toReg(toReg), 
                         .ALUOp(ALUOp),       .DMWr(DMWr),      .ALUSrc1(ALUSrc1), 
                         .ALUSrc2(ALUSrc2),   .RFWr(RFWr),      .EXTOp(EXTOp) );

    ID_EXE  ID_EXE( .clk(clk), .rst(rst), .IDEXE_stall(IDEXE_stall),
                    .RD1(RD1), .RD2(RD2final), .rd(rd),  
                    .Imm32(Imm32),                 
                    .ins(IFID_ins), .pc(IFID_pc), .RegDst(RegDst), .NPCOp(NPCOp), .DMRd(DMRd), .toReg(toReg), .ALUOp(ALUOp), 
                    .DMWr(DMWr), .ALUSrc1(ALUSrc1), .ALUSrc2(ALUSrc2), .RFWr(RFWr),
                    .IDEXE_RD1(IDEXE_RD1), .IDEXE_RD2(IDEXE_RD2), .IDEXE_Imm32(IDEXE_Imm32),   .IDEXE_rd(IDEXE_rd),
                    .IDEXE_ins(IDEXE_ins), .IDEXE_pc(IDEXE_pc),   .IDEXE_RegDst(IDEXE_RegDst), .IDEXE_NPCOp(IDEXE_NPCOp), .IDEXE_DMRd(IDEXE_DMRd), 
                    .IDEXE_toReg(IDEXE_toReg), .IDEXE_ALUOp(IDEXE_ALUOp), .IDEXE_DMWr(IDEXE_DMWr),
                    .IDEXE_ALUSrc1(IDEXE_ALUSrc1), .IDEXE_ALUSrc2(IDEXE_ALUSrc2), .IDEXE_RFWr(IDEXE_RFWr) );
    wire    [31:0] ALUSrcAout;
    mux4    ALU_A_f   ( .d0(ALUSrcAout), .d1(EXEMEM_ALUout),.d2(WD), .d3(0),
                            .s(ALU_A),.y(A) );
    mux2    ALU_A1      ( .d0(IDEXE_RD1), .d1({27'b0,IDEXE_ins[10:6]}), 
                            .s(IDEXE_ALUSrc1), .y(ALUSrcAout) );
    wire    [1:0]  ALU_A;
    wire    [31:0] A;               

    wire    [31:0] ALUSrcBout;
    mux4    ALU_B_f   ( .d0(ALUSrcBout), .d1(EXEMEM_ALUout), .d2(WD), .d3(0), 
                            .s(ALU_B),.y(B) );
    mux2    ALU_B1      ( .d0(IDEXE_RD2), .d1(IDEXE_Imm32), 
                            .s(IDEXE_ALUSrc2), .y(ALUSrcBout) );
    wire    [1:0]  ALU_B;
    wire    [31:0] B;                
    alu      alu    ( .A(A), .B(B), .ALUOp(IDEXE_ALUOp), .C(ALUout), .Zero(Zero) );
    wire            Zero;
   
   

    wire    [31:0]  EXEMEM_ins;
    wire    [1:0]   EXEMEM_toReg;     
    wire    [31:0]  EXEMEM_DMdata;      
    wire    [31:0]  EXEMEM_pc;     

    EXE_MEM EXE_MEM( .clk(clk), .rst(rst),
                     .ins(IDEXE_ins), .pc(IDEXE_pc), .rd(IDEXE_rd), .toReg(IDEXE_toReg), 
                     .DMRd(IDEXE_DMRd), .DMWr(IDEXE_DMWr), .RFWr(IDEXE_RFWr), .DMdata(IDEXE_RD2), .ALUout(ALUout),
                     .EXEMEM_ins(EXEMEM_ins), .EXEMEM_pc(EXEMEM_pc), .EXEMEM_rd(EXEMEM_rd), .EXEMEM_toReg(EXEMEM_toReg), 
                     .EXEMEM_DMRd(EXEMEM_DMRd), .EXEMEM_DMWr(EXEMEM_DMWr), .EXEMEM_RFWr(EXEMEM_RFWr), 
                     .EXEMEM_DMdata(EXEMEM_DMdata), .EXEMEM_ALUout(EXEMEM_ALUout) );
    wire    [31:0]  DMdata;

    DM      DM      ( .clk(clk), .DMWr(EXEMEM_DMWr), .DMRd(EXEMEM_DMRd), 
                      .DMaddr(EXEMEM_ALUout), .DMdata(DMdata), .DMout(DMout) );
    mux2    Dd_mux ( .d0(EXEMEM_DMdata), .d1(WD), .s(DMdata_ctrl), .y(DMdata) );

    wire    [1:0]   MEMWB_toReg;
    wire    [31:0]  MEMWB_DMout;
    wire    [31:0]  MEMWB_pc;
    wire    [31:0]  MEMWB_ins;
    wire    [31:0]  MEMWB_ALUout;
    mux4 Rdmux( .d0(MEMWB_ALUout), .d1(MEMWB_DMout), .d2(MEMWB_pc + 4), .d3(0),  
                   .s(MEMWB_toReg),   .y (WD));
    MEM_WB  MEM_WB ( .clk(clk), .rst(rst),
                     .ins(EXEMEM_ins), .pc(EXEMEM_pc), .rd(EXEMEM_rd), .toReg(EXEMEM_toReg), 
                     .RFWr(EXEMEM_RFWr), .DMRd(EXEMEM_DMRd), .DMWr(EXEMEM_DMWr), .DMout(DMout), .ALUout(EXEMEM_ALUout),
                     .MEMWB_ins(MEMWB_ins), .MEMWB_pc(MEMWB_pc), .MEMWB_rd(MEMWB_rd), .MEMWB_toReg(MEMWB_toReg), 
                     .MEMWB_DMRd(MEMWB_DMRd), .MEMWB_DMWr(MEMWB_DMWr),
                     .MEMWB_RFWr(MEMWB_RFWr), .MEMWB_DMout(MEMWB_DMout), .MEMWB_ALUout(MEMWB_ALUout) );
    //Hazard
    wire    [3:0]   EXEMEM_DMRd;
    wire    [4:0]   EXEMEM_rd;
    Hazard Hazard  ( .pc(IFID_pc), .npc(npc), .EXEMEM_DMRd(EXEMEM_DMRd), .EXEMEM_rd(EXEMEM_rd), .rs(IFID_ins[25:21]),
                     .IFID_stall(IFID_stall), .IFID_flush(IFID_flush), .IDEXE_stall(IDEXE_stall), 
                     .PC_stall(PC_stall),     .jump(jump) );
    //Forward
    wire    EXEMEM_RFWr;
    wire    [1:0] EXEMEM_DMWr;
    wire    [3:0] MEMWB_DMRd;
    wire    DMdata_ctrl;
    wire    [1:0] MEMWB_DMWr;

    ForwardingUnit ForwardingUnit( .EXEMEM_RFWr(EXEMEM_RFWr),   .EXEMEM_rd(EXEMEM_rd),     .IDEXE_rs(IDEXE_ins[25:21]), .IDEXE_rt(IDEXE_ins[20:16]), 
                                   .MEMWB_RFWr(MEMWB_RFWr),     .MEMWB_rd(MEMWB_rd),       .IDEXE_rd(IDEXE_rd),         .IDEXE_RFWr(IDEXE_RFWr),
                                   .NPC_F1(NPC_F1),             .NPC_F2(NPC_F2),           .IFID_rs(IFID_ins[25:21]),   .IFID_rt(IFID_ins[20:16]),
                                   .ALU_A(ALU_A),.ALU_B(ALU_B), .DMdata_ctrl(DMdata_ctrl), .IDEXE_DMWr(IDEXE_DMWr),     .IFID_DMWr(DMWr),
                                   .MEMWB_DMWr(MEMWB_DMWr),     .EXEMEM_DMWr(EXEMEM_DMWr), .SW_ctrl(SW_ctrl),           .MEMWB_DMRd(MEMWB_DMRd),
                                   .ALUSrc1(ALUSrc1),           .ALUSrc2(IDEXE_ALUSrc2),   .EXEMEM_DMRd(EXEMEM_DMRd));
endmodule