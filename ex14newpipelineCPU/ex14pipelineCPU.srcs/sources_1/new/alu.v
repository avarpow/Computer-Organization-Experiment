module alu(A, B, ALUOp, C, Zero);
           
   input  signed [31:0] A, B;
   input         [3:0]  ALUOp;
   output signed [31:0] C;
   output Zero;
   
   reg [31:0] C;
   integer    i;
       
   always @( * ) begin
      case ( ALUOp )
          4'b0000:  C = A;                          // NOP
          4'b0001:  C = A + B;                      // ADD
          4'b0010:  C = A - B;                      // SUB
          4'b0011:  C = A & B;                      // AND/ANDI
          4'b0100:   C = A | B;                      // OR/ORI
          4'b0101:  C = (A < B) ? 32'd1 : 32'd0;    // SLT/SLTI
          4'b0110: C = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0;
          4'b0111:  C = A ^ B;
          4'b1000:  C = ~(A | B);
          4'b1100:  C = 0 | B;
          4'b1001:  C = B << {A[4:0]};
          4'b1010:  C = B >> {A[4:0]};
          4'b1011:  C = ($signed(B)) >>> {A[4:0]};

          default:   C = A;                          // Undefined
      endcase
   end // end always
   
   assign Zero = (C == 32'b0);

endmodule
    
