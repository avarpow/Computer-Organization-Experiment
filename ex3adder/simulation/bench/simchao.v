`timescale 1ns / 1ps
module simadder(
    );
    // Inputs
        reg [3:0] A;
        reg [3:0] B;
        reg C0;
    // Outputs
        wire C4;
        wire [3:0] F;
    // Instantiate the Unit Under Test (UUT)
    chaoadder uut (
        .A(A), 
        .B(B), 
        .C0(C0), 
        .C4(C4), 
        .F(F)
        );
    initial begin
        $dumpfile("testchaoadder.vcd");
        $dumpvars;
        // Initialize Inputs
        C0 = 0;
        // Wait 100 ns for global reset to finish
        #100;
        // Add stimulus here
        A = 'B1100;B='B1011;C0 = 0;
        $monitor ("%0t A=%8b B=%8b C0=%1b C4=%1b F=%4b"
        , $time, A, B, C0,C4,F);
        #100;
        $monitor ("%0t A=%8b B=%8b C0=%1b C4=%1b F=%4b"
        , $time, A, B, C0,C4,F);
        A = 'B1011;B='B0010;C0 = 1;
        #100;
        $monitor ("%0t A=%8b B=%8b C0=%1b C4=%1b F=%4b"
        , $time, A, B, C0,C4,F);
        A = 'B1011;B='B1101;C0 = 0;
        #100;
        $monitor ("%0t A=%8b B=%8b C0=%1b C4=%1b F=%4b"
        , $time, A, B, C0,C4,F);
        A = 'B1010;B='B0010;C0 = 1;
        #100;
        $monitor ("%0t A=%8b B=%8b C0=%1b C4=%1b F=%4b"
        , $time, A, B, C0,C4,F);
        A = 'B0111;B='B1000;C0= 0;
        #100;
        $monitor ("%0t A=%8b B=%8b C0=%1b C4=%1b F=%4b"
        , $time, A, B, C0,C4,F);
        A = 'B0011;B='B0100;C0 = 1;
        #100;
        $monitor ("%0t A=%8b B=%8b C0=%1b C4=%1b F=%4b"
        , $time, A, B, C0,C4,F);
        A = 'B1001;B='B0001;C0 = 0;
        #100;
        $monitor ("%0t A=%8b B=%8b C0=%1b C4=%1b F=%4b"
        , $time, A, B, C0,C4,F);
    end
endmodule
