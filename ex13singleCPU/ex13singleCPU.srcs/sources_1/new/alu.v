`timescale 1ns / 1ps
module alu(
           input [4:0] shamt,
           input [31:0] input1,
           input [31:0] input2,
           input [4:0] aluCtr, 
           output reg [31:0] aluRes, 
           output reg ZF, //�?0则为1，否则为0
           output reg CF,OF,//溢出�?�?
           output reg PF,//正数�?1，负数为0
           output reg [31:0]hi,
           output reg [31:0]lo
       );
always @(input1 or input2 or aluCtr) // 运算数或控制码变化时操作
begin
    case(aluCtr)
        5'b00000: //  add
        begin
            aluRes = $signed(input1) + $signed(input2); 
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b00001: //  addu
        begin
            aluRes = input1 + input2; 
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b00010: //  sub
        begin
            aluRes = $signed(input1) - $signed(input2); 
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b00011: //  subu
        begin
            aluRes = input1 - input2; 
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b00100: //  and
        begin
            aluRes = input1 & input2; 
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b00101: //  or
        begin
            aluRes = input1 | input2; 
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b00101: //  or
        begin
            aluRes = input1 | input2; 
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b00110: //  xor
        begin
            aluRes = ((~input1) & input2) | (input1 & (~input2));
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b00111: //  nor
        begin
            aluRes = ~(input1 | input2);
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b01000: //  slt
        begin
            if($signed(input1) < $signed(input2)) 
                aluRes = 1;
            else 
                aluRes = 0;
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b01001: //  sltu
        begin
            if(input1 < input2) 
                aluRes = 1;
            else 
                aluRes = 0;
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b01010: //  lui
        begin
            aluRes={input2[15:0],16'b0000_0000_0000_0000};
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b01011: //  sll
        begin
            aluRes=input2 << shamt;
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b01100: //  srl
        begin
            aluRes=input2 >> shamt;
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b01101: //  sllv
        begin
            aluRes=input2 << input1[4:0];
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b01110: //  srlv
        begin
            aluRes=input2 >> input1[4:0];
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b01111: //  sra
        begin
            aluRes= $signed(input2) >>> shamt;
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b10000: //  srav
        begin
            aluRes= $signed(input2) >>> input1[4:0];
            if(aluRes==0) 
                ZF=1; 
            else 
                ZF=0;
            if(aluRes>0)
                PF=1;
            else 
                PF=0;
            hi=0;
            lo=0;
        end

        5'b10001: //  mult
        begin
            {hi,lo}=input1 * input2;
            aluRes=0;
            ZF=1;
            OF=0;
            PF=0;
        end

        5'b10010: //  div
        begin
            hi=input1 / input2;
            hi=input1 % input2;
            aluRes=0;
            ZF=1;
            OF=0;
            PF=0;
        end

        default:
        begin
            aluRes = 0; ZF=1;OF=0;PF=1;
        end
    endcase
end
endmodule
