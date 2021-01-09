module ctrl_unit( opcode, func, 
                  RegDst, NPCOp, DMRd, toReg, ALUOp, DMWr, ALUSrc1, ALUSrc2, RFWr, EXTOp );
    
   input      [5:0] opcode;       
   input      [5:0] func;      

   output reg ALUSrc1;             // reg shamt imm
   output reg ALUSrc2;
   output reg RFWr;
   
   output reg [1:0] RegDst;    //Rt Rd R31
   output reg [2:0] NPCOp;     
   output reg [3:0] DMRd;      //lw lh lb
   output reg [1:0] toReg;     //PC2Reg Mem2Reg 2'b00
   output reg [3:0] ALUOp;     
   output reg [1:0] DMWr;      //sw sh sb
   output reg [1:0] EXTOp;     //2'b00 zero lui

   
   always @(*) begin
      NPCOp = 3'b000;
      RegDst = 2'b01;
      ALUSrc1 = 1'b0;
      ALUSrc2 = 1'b0;
      toReg = 2'b00;
      RFWr = 1'b0;
      DMRd = 3'b000;
      DMWr = 3'b000;
      ALUOp = 4'b0000;
      EXTOp = 2'b00; 

      case (opcode)
          6'b000000: begin
              NPCOp = 3'b000;
              RegDst = 2'b01;
              toReg = 2'b00;
              RFWr = 1'b1;
              DMRd = 3'b000;
              DMWr = 3'b000;

              // ALU control signal
              case (func)

                  6'b100000: begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0001;//ADD
                  end

                  6'b100010: begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0010;//SUB
                  end

                  6'b100100: begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0011;//AND
                  end

                  6'b100101 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0100;//OR
                  end

                  6'b101010: begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0101;//SLT
                  end

                  6'b101011 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0110;//SLT
                  end

                  6'b100001 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0001;//ADD
                  end

                  6'b100011 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0010;//SUB
                  end

                  6'b100110 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b0111;//XOR
                  end

                  6'b100111 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b1000;//NOR
                  end

                  6'b000000 : begin
                      ALUSrc1 = 1'b1;//SHAMT
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b1001;//SLL
                  end

                  6'b000011 : begin
                      ALUSrc1 = 1'b1;//SHAMT
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b1011;//SRA
                  end

                 6'b000111 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b1011;//SRA
                  end

                  6'b000010 : begin
                      ALUSrc1 = 1'b1;//SHAMT
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b1010;//SRL
                  end

                  6'b000100 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b1001;//SLL
                  end

                  6'b000110 : begin
                      ALUSrc1 = 1'b0;
                      ALUSrc2 = 1'b0;
                      ALUOp   = 4'b1010;//SRL
                  end

                  6'b001000 : begin
                      ALUOp   = 4'b0000;
                      RFWr    = 1'b0; 
                      NPCOp   = 3'b011;//JR
                  end

                  6'b001001 : begin
                      NPCOp   = 3'b011;//JR
                      ALUOp   = 4'b0000;
                      toReg   = 2'b10;//PC->REG
                      RegDst  = 2'b10;//$31
                  end
              endcase
          end

          6'b001000: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b001101:  begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0100;//OR
              EXTOp   = 2'b01;//zero-exten
          end

          6'b001110: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0111;//XOR
              EXTOp   = 2'b01;//zero-exten
          end

          6'b001001:  begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b001100: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0011;//AND
              EXTOp   = 2'b01;//zero-exten
          end

          6'b001111:  begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b1100;//LUI
              EXTOp   = 2'b10;//lui-extren
          end

          6'b001010: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0101;//SLT
              EXTOp   = 2'b00;
          end

          6'b001011: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0110;//SLT
              EXTOp   = 2'b00;
          end

          6'b100011: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b01;//mem->reg
              RFWr    =  1'b1;
              DMRd    = 3'b001;//lw
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b101011: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b01;//mem->reg
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b001;//sw
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b000100: begin
              NPCOp   = 3'b001;//beq
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b0;
              ALUOp   = 4'b0010;//SUB
              EXTOp   = 2'b00;
          end

          6'b000101: begin
              NPCOp   = 3'b010;//bne
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b0;
              ALUOp   = 4'b0010;//SUB
              EXTOp   = 2'b00;
          end

          6'b000010: begin
              NPCOp   = 3'b111;//jump
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b0;
              ALUOp   = 4'b0000;
              EXTOp   = 2'b00;
          end

          6'b000011: begin
              NPCOp   = 3'b111;//jump
              RegDst  = 2'b10;//$31
              toReg   = 2'b10;//PC->REG
              RFWr    =  1'b1;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b0;
              ALUOp   = 4'b0000;
              EXTOp   = 2'b00;
          end

          6'b100000: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b01;//mem->reg
              RFWr    =  1'b1;
              DMRd    = 3'b011;//lb
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b100100: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b01;//mem->reg
              RFWr    =  1'b1;
              DMRd    = 3'b101;//lbu
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b100001: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b01;//mem->reg
              RFWr    =  1'b1;
              DMRd    = 3'b010;//lh
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b100101: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b01;//mem->reg
              RFWr    =  1'b1;
              DMRd    = 3'b100;//lhu
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b101000: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b011;//sb
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b101001: begin
              NPCOp   = 3'b000;
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b010;//sh
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b1;//imme
              ALUOp   = 4'b0001;//ADD
              EXTOp   = 2'b00;
          end

          6'b000110: begin
              NPCOp   = 3'b100;//BLEZ
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b0;
              ALUOp   = 4'b0000;
              EXTOp   = 2'b00;
          end

          6'b000111: begin
              NPCOp   = 3'b101;//BGTZ
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b0;
              ALUOp   = 4'b0000;
              EXTOp   = 2'b00;
          end

          6'b000001: begin//BGEZ
              NPCOp   = 3'b110;//BGEZ
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b0;
              ALUOp   = 4'b0000;
              EXTOp   = 2'b00;
          end
          6'b111111: begin//BGEZ
              NPCOp   = 3'bxxx;//BGEZ
              RegDst  = 2'b00;//rt
              toReg   = 2'b00;
              RFWr    =  1'b0;
              DMRd    = 3'b000;
              DMWr    = 3'b000;
              ALUSrc1 = 1'b0;
              ALUSrc2 = 1'b0;
              ALUOp   = 4'b0000;
              EXTOp   = 2'b00;
          end
              
      endcase
   end // end always
   
endmodule