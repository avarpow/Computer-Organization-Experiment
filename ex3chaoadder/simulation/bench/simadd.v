`timescale 1ns/10ps
module addsub_test();
    reg [7:0] a,b;
    wire [7:0] sum;
    reg sub;
    wire cf,ovf,sf,zf;
    reg clk;
    addsub u0(
        .a(a),
        .b(b),
        .sub(sub),
        .sum(sum),
        .cf(cf),
        .ovf(ovf),
        .sf(sf),
        .zf(zf)
        );
    initial begin
        $dumpfile("testaddsub.vcd");
        $dumpvars;
        #200 sub = 1;
        #200 a = 8'h7f; b = 8'h2; sub = 0;
        $monitor ("%0t a=%8b b=%8b sub=%1b sum=%8b cf=%1b ovf=%1b sf=%1b zf=%1b", $time, a, b, sub,sum,cf,ovf,sf,zf);
        #200 a = 8'hff; b = 8'h2; sub = 0; 
        $monitor ("%0t a=%8b b=%8b sub=%1b sum=%8b cf=%1b ovf=%1b sf=%1b zf=%1b", $time, a, b, sub,sum,cf,ovf,sf,zf);
        #200 a = 8'h16; b = 8'h17; sub = 1;
        $monitor ("%0t a=%8b b=%8b sub=%1b sum=%8b cf=%1b ovf=%1b sf=%1b zf=%1b", $time, a, b, sub,sum,cf,ovf,sf,zf);
        #200 a = 8'hfe; b = 8'hff; sub = 1; 
        $monitor ("%0t a=%8b b=%8b sub=%1b sum=%8b cf=%1b ovf=%1b sf=%1b zf=%1b", $time, a, b, sub,sum,cf,ovf,sf,zf);
        #200;
    end
    
endmodule