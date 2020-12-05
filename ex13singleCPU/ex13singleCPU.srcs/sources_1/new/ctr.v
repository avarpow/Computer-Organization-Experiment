`timescale 1ns / 1ps
module ctr(
           input [5:0] opCode,
           input [5:0] funct,
           input [4:0] rt,
           output reg regDst,  //0:rt,1:rd
           output reg aluSrc, //1:imme立即数
           output reg aluZeroinput, //1:alu输入2为0 bltz bgez bltzal bgezal 使用
           output reg memToReg, //从内存写入寄存器
           output reg regWrite, //写寄存器使能
           output reg memRead, //读取内存使能
           output reg memWrite, //写入内存使能
           output reg ExtOp, //符号扩展方式，1 为 sign-extend，0 为 zero-extend
           output reg[3:0] aluop, // 经过 ALU 控制译码决定 ALU 功能
           output reg jmp,//jump指令:无条件跳转
           output reg jal,//jal指令:跳转和链接
           output reg jr,//jr指令:从寄存器跳转
           output reg bne,//bne指令:不相等时跳转
           output reg beq,//beq指令:相等时跳转
           output reg bgez,//bgtz指令:大于等于0时跳转
           output reg bgezal,//bgezal指令:大于等于0时跳转并且链接
           output reg blez,//blez指令:小于等于0时跳转
           output reg bltz,//bltz指令:小于0时跳转
           output reg bltzal,//bltzal指令:小于0时跳转并且链接
           output reg mult,//mult指令:乘指令
           output reg div,//div指令:除法指令
           output reg mflo,//mflo指令:从lo寄存器设置寄存器值
           output reg mfhi,//mfhi指令:从hi寄存器设置寄存器值
           output reg PCWrite,//1:CPU继续运行，0:停机
           output reg syscall,//系统调用指令
           output reg noop,//不做操作指令
           output reg halt,//停机指令
           output reg [1:0]storemux//00:字节,01半字,11全字,load指令和store指令的方式
       );

always@(opCode) begin
    // 操作码改变时改变控制信号
    case(opCode)
        // 'R 型' 指令操作码
        // 算术指令，syscall,mult,div,mufi,mflo,jr
        6'b000000: begin
            regDst = 1;
            aluSrc = 0;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0000;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
            if(funct==6'b011000)
                mult=1;
            else if(funct==6'b011010)
                div=1;
            else if(funct==6'b010000)//muhi
            begin
                mfhi=1;
                regWrite=0;
            end
            else if(funct==6'b011000)//mflo
            begin
                mflo=1;
                regWrite=0;
            end
            else if(funct==6'b001000)
            begin
                jr=1;
                regWrite=0;
            end
            else if(funct==6'b001100)
            begin
                syscall=1;
                regWrite=0;
            end
            else if(funct==6'b000000)
            begin
                noop=1;
                regWrite=0;
            end
        end

        // 'J 型' 指令操作码
        // 'j' 指令操作码: 000010
        6'b000010: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0111;
            jmp =1;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end

        // 'jal' 指令操作码: 000011
        6'b000010: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;//56t4r
            aluop = 4'b0111;
            jmp =0;
            jal=1;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 


        //'I'型指令操作码
        //addi 操作码 001000
        6'b001000: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0001;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 
        //addiu 操作码001001
        6'b001001: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0010;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 
        //slti 操作码001010
        6'b001010: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0111;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //sltiu 操作码001011
        6'b001011: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b1000;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //andi 操作码001100
        6'b001100: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0100;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //ori 操作码001101
        6'b001101: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0101;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //xori 操作码001110
        6'b001110: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0110;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //lui 操作码001111
        6'b001111: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b1001;
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //lb 操作码100000
        6'b100000: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0001;//加法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //lh 操作码100001
        6'b100001: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0001;//加法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //lw 操作码100011
        6'b100011: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0001;//加法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //sb 操作码101000
        6'b101000: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            ExtOp = 1;
            aluop = 4'b0001;//加法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //sh 操作码101001
        6'b101001: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            ExtOp = 1;
            aluop = 4'b0001;//加法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //sw 操作码101011
        6'b101011: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            ExtOp = 1;
            aluop = 4'b0001;//加法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

    //B指令
        //bltz bgez bltzal bgezal 操作码000001
        6'b000001: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//减法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
            if(rt == 5'b00000) 
                begin //bltz
                        bltz=1;
                end
            else if(rt== 5'b00001) 
                begin //bgez
                    bgez=1;
                end
            else if(rt== 5'b10000)  
                begin //bltzal
                    bltzal=1;
                end
            else if(rt== 5'b10001) 
                begin //bgezal
                    bgezal=1;
                end
        end

        //beq 操作码000100
        6'b000100: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//减法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=1;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //bne 操作码000101
        6'b000101: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//减法
            jmp =0;
            jal=0;
            jr=0;
            bne=1;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //blez 操作码000110
        6'b000110: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//减法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=1;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=1;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        //halt 操作码111111
        6'b111111: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//减法
            jmp =0;
            jal=0;
            jr=0;
            bne=0;
            beq=0;
            bgez=0;
            bgezal=0;
            blez=0;
            bltz=0;
            bltzal=0;
            mult=0;
            div=0;
            mflo=0;
            mfhi=0;
            PCWrite=0;
            syscall=0;
            noop=0;
            halt=0;
            storemux=opCode[1:0];
        end 

        default: begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            aluop = 3'b0xxx;
            jmp = 0;
            ExtOp = 0;
        end // 默认设置
    endcase
    end
endmodule
