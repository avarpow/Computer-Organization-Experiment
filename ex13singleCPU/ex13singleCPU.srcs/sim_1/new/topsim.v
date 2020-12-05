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
    clkin = 0;
    reset=0;
    #10;
    reset = 1;
    #50;
    // Wait 100 ns for global reset to finish #100;
    reset = 0;
end

parameter PERIOD = 20; 
always begin
    clkin = 1'b0;
    #(PERIOD / 2) clkin = 1'b1;
    #(PERIOD / 2) ;
end

endmodule
