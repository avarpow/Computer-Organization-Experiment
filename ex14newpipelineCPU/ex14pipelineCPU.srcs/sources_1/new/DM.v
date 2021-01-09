module DM( clk, DMWr, DMRd, DMaddr, DMdata, DMout );
    input                clk;
    input       [1:0]    DMWr;
    input       [3:0]    DMRd;
    input       [31:0]   DMaddr;
    input       [31:0]   DMdata;
    output reg  [31:0]   DMout;

    reg[7:0] RAM [31:0];
	
  integer i;
	initial
	begin
		for (i = 0; i <= 31; i = i + 1)
        	RAM[i] <= 0;
    DMout <= 32'b0;
	end

//LOAD
always@(*) begin
    if( DMRd != 3'b000 ) begin
	    case(DMRd)
  	        3'b001:   
			  DMout <= { RAM[DMaddr+3], RAM[DMaddr+2], RAM[DMaddr+1], RAM[DMaddr] };//LW
   	        3'b010:   
			   DMout <= { {16{RAM[DMaddr+1][7]}} , RAM[DMaddr+1], RAM[DMaddr] };//LH
   	        3'b100:  
			   DMout <= { 16'b0  , RAM[DMaddr+1], RAM[DMaddr] };//LHU
   	        3'b011:   
			   DMout <= { {24{RAM[DMaddr][7]}}  , RAM[DMaddr] };//LB
   	        3'b101:  
			   DMout <= { 24'b0 , RAM[DMaddr] };//LBU
   	    endcase
	end
end


//STORE
always@(posedge clk) begin
    if( DMWr != 3'b000 ) begin
	    case(DMWr)
  	        3'b001:  
			   	{ RAM[DMaddr+3], RAM[DMaddr+2], RAM[DMaddr+1], RAM[DMaddr] } <= DMdata[31:0];
   	        3'b010:  
			   { RAM[DMaddr+1], RAM[DMaddr] } <= DMdata[15:0];
   	        3'b011:   
			   { RAM[DMaddr] } <= DMdata[7:0];
   	    endcase
	end
end

endmodule
