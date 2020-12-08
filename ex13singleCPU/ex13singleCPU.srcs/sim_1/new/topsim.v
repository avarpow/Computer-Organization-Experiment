module topsim;

// Inputs 
reg clkin; 
reg reset;
// Instantiate the Unit Under Test (UUT)
top uut (
        .clkin(clkin),
        .reset(reset)
    );

initial begin
    // Initialize Inputs 
    reset=0;
    #1;
    reset = 1;
    #1;
    reset=0;
    // Wait 100 ns for global reset to finish 
    #20;
end

parameter PERIOD = 40; 
always begin
    clkin = 1'b0;
    #(PERIOD / 2) clkin = 1'b1;
    #(PERIOD / 2) ;
end

endmodule
