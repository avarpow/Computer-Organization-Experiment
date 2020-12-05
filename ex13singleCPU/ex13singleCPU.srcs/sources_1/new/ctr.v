`timescale 1ns / 1ps
module ctr(
           input [5:0] opCode,
           input [5:0] funct,
           input [4:0] rt,
           output reg regDst,  //0:rt,1:rd
           output reg aluSrc, //1:imme������
           output reg aluZeroinput, //1:alu����2Ϊ0 bltz bgez bltzal bgezal ʹ��
           output reg memToReg, //���ڴ�д��Ĵ���
           output reg regWrite, //д�Ĵ���ʹ��
           output reg memRead, //��ȡ�ڴ�ʹ��
           output reg memWrite, //д���ڴ�ʹ��
           output reg ExtOp, //������չ��ʽ��1 Ϊ sign-extend��0 Ϊ zero-extend
           output reg[3:0] aluop, // ���� ALU ����������� ALU ����
           output reg jmp,//jumpָ��:��������ת
           output reg jal,//jalָ��:��ת������
           output reg jr,//jrָ��:�ӼĴ�����ת
           output reg bne,//bneָ��:�����ʱ��ת
           output reg beq,//beqָ��:���ʱ��ת
           output reg bgez,//bgtzָ��:���ڵ���0ʱ��ת
           output reg bgezal,//bgezalָ��:���ڵ���0ʱ��ת��������
           output reg blez,//blezָ��:С�ڵ���0ʱ��ת
           output reg bltz,//bltzָ��:С��0ʱ��ת
           output reg bltzal,//bltzalָ��:С��0ʱ��ת��������
           output reg mult,//multָ��:��ָ��
           output reg div,//divָ��:����ָ��
           output reg mflo,//mfloָ��:��lo�Ĵ������üĴ���ֵ
           output reg mfhi,//mfhiָ��:��hi�Ĵ������üĴ���ֵ
           output reg PCWrite,//1:CPU�������У�0:ͣ��
           output reg syscall,//ϵͳ����ָ��
           output reg noop,//��������ָ��
           output reg halt,//ͣ��ָ��
           output reg [1:0]storemux//00:�ֽ�,01����,11ȫ��,loadָ���storeָ��ķ�ʽ
       );

always@(opCode) begin
    // ������ı�ʱ�ı�����ź�
    case(opCode)
        // 'R ��' ָ�������
        // ����ָ�syscall,mult,div,mufi,mflo,jr
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

        // 'J ��' ָ�������
        // 'j' ָ�������: 000010
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

        // 'jal' ָ�������: 000011
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


        //'I'��ָ�������
        //addi ������ 001000
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
        //addiu ������001001
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
        //slti ������001010
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

        //sltiu ������001011
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

        //andi ������001100
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

        //ori ������001101
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

        //xori ������001110
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

        //lui ������001111
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

        //lb ������100000
        6'b100000: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0001;//�ӷ�
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

        //lh ������100001
        6'b100001: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0001;//�ӷ�
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

        //lw ������100011
        6'b100011: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0001;//�ӷ�
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

        //sb ������101000
        6'b101000: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            ExtOp = 1;
            aluop = 4'b0001;//�ӷ�
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

        //sh ������101001
        6'b101001: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            ExtOp = 1;
            aluop = 4'b0001;//�ӷ�
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

        //sw ������101011
        6'b101011: begin
            regDst = 0;
            aluSrc = 1;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            ExtOp = 1;
            aluop = 4'b0001;//�ӷ�
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

    //Bָ��
        //bltz bgez bltzal bgezal ������000001
        6'b000001: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//����
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

        //beq ������000100
        6'b000100: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//����
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

        //bne ������000101
        6'b000101: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//����
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

        //blez ������000110
        6'b000110: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//����
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

        //halt ������111111
        6'b111111: begin
            regDst = 0;
            aluSrc = 0;
            aluZeroinput = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            ExtOp = 1;
            aluop = 4'b0011;//����
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
        end // Ĭ������
    endcase
    end
endmodule
