module NPC( clk, pc, NPCOp, IMM, Rt, RD1, RD2, npc );  
   input         clk;
   input  [31:0] pc;        
   input  [2:0]  NPCOp;     
   input  [25:0] IMM;       // imme
   input  [4:0]  Rt;        // bltz, bgez
   input  [31:0] RD1;       // jr
   input  [31:0] RD2;       
   output reg [31:0] npc;  
   wire [31:0] PCPLUS4;
   assign PCPLUS4 = pc + 4; // pc + 4
  initial
    begin
      npc <= 32'h0000_0004;
    end
   always @(negedge clk) begin
      case (NPCOp)
          3'b000:  npc = PCPLUS4;
          3'b001:    npc = (RD1 == RD2) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4);  
          3'b010:    npc = (RD1 == RD2) ? (PCPLUS4) : (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00});
          3'b111:   npc = {PCPLUS4[31:28], IMM[25:0], 2'b00};         
          3'b011:    npc = RD1;
          3'b100:   npc = (RD1 ==  0 || RD1[31] == 1) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4);
          3'b101:   npc = (RD1 !=  0 && RD1[31] == 0) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4);
          3'b110: begin
                case(Rt)
                    5'b00000: npc = (RD1 != 0 && RD1[31] == 1) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4);
                    5'b00001: npc = (RD1 == 0 || RD1[31] == 0) ? (PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00}) : (PCPLUS4); 
                endcase
          end
          default:     npc = pc;
      endcase
   end 
   
endmodule
