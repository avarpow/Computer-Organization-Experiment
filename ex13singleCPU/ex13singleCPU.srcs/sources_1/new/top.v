`timescale 1ns / 1ps
module top(
           input clkin,
           input reset,
           output [6:0] sm_duan,//����
           output [3:0] sm_wei,//�ĸ������
           output [31:0] PC,
           output [31:0] aluRes,
           output [31:0] instruction
       );
// �������ź���

//���ݴ洢��
wire[31:0] memreaddata;
// ָ��洢��
//wire [31:0] instruction;
reg[7:0] Addr;
// CPU �����ź���
wire reg_dst,memread, memwrite, memtoreg,alu_src,alu_zeroinput,ExtOp;
wire[3:0] aluop;
wire regwrite;
wire jmp,jal,jr,bne,beq,bgez,bgezal,blez,bltz,bltzal;
wire mult,div,mflo,mfhi,PCWrite,syscall,noop,halt;
wire [1:0]storemux;
// ALU �����ź���
wire ZF,OF,CF,PF; //alu�����־
wire[31:0] hi,lo; //alu������
// ALU�����ź���
wire[4:0] aluCtr;//����aluop��ָ���6λ ѡ��alu��������
//
wire[31:0] input2;
wire [15:0]data;
//link
wire [4:0] linkaddr;
//PCctr
wire [31:0] CPCadd4;
// �Ĵ����ź���
wire[31:0] RsData, RtData;
wire[31:0] expand; wire[4:0] shamt;
wire [4:0]regWriteAddr;
wire[31:0]regWriteData;
//link
wire [4:0]muxlinkaddr;
assign shamt=instruction[10:6];
assign regWriteAddr = reg_dst ? instruction[15:11] : instruction[20:16];//д�Ĵ�����Ŀ��Ĵ�������rt��rd
assign data=aluRes[15:0];
//assign regWriteData = memtoreg ? memreaddata : aluRes; //д��Ĵ�������������ALU�����ݼĴ���
//assign input2 = alu_src ? expand : RtData; //ALU�ĵڶ������������ԼĴ����������ָ���16λ�ķ�����չ
// ����ָ��洢��

rom_top trom(
            .Clk(clkin),
            .Rst(1'b0),
            .PC(PC),
            .data(instruction)
        );
// ʵ����������ģ��
ctr mainctr(
        .opCode(instruction[31:26]),
        .funct(instruction[5:0]),
        .rt(instruction[20:16]),
        .regDst(reg_dst),
        .aluSrc(alu_src),
        .aluZeroinput(alu_zeroinput),
        .memToReg(memtoreg),
        .regWrite(regwrite),
        .memRead(memread),
        .memWrite(memwrite),
        .ExtOp(ExtOp),
        .aluop(aluop),
        .jmp(jmp),
        .jal(jal),
        .jr(jr),
        .bne(bne),
        .beq(beq),
        .bgez(bgez),
        .bgezal(bgezal),
        .blez(blez),
        .bltz(bltz),
        .bltzal(bltzal),
        .mult(mult),
        .div(div),
        .mflo(mflo),
        .mfhi(mfhi),
        .PCWrite(PCWrite),
        .syscall(syscall),
        .noop(noop),
        .halt(halt),
        .storemux(storemux)
    );
aluinput2 aluinput2_i(
              .ext_data(expand),
              .rt_data(RtData),
              .aluSrc(alu_src),
              .aluZeroinput(alu_zeroinput),
              .alu_input2(input2)
          );
//  ʵ���� ALU ����ģ��
aluctr aluctr1(
           .ALUOp(aluop),
           .funct(instruction[5:0]),
           .ALUCtr(aluCtr)
       );
//link
link link1(
         .jal(jal),
         .bgezal(bgezal),
         .bltzal(bltzal),
         .ZF(ZF),
         .PF(PF),
         .reg_W_Addr(regWriteAddr),
         .W_Addr(muxlinkaddr)
     );
PCctr PCctr1(
          .clkin(clkin),
          .reset(reset),
          .PCWrite(PCWrite),
          .target(instruction[25:0]),
          .imm_16(instruction[15:0]),
          .R_Data_A(RsData),
          .jmp(jmp),
          .jal(jal),
          .jr(jr),
          .bne(bne),
          .beq(beq),
          .bgez(bgez),
          .bgezal(bgezal),
          .blez(blez),
          .bltz(bltz),
          .bltzal(bltzal),
          .ZF(ZF),
          .PF(PF),
          .PC(PC),
          .CPCadd4(CPCadd4)
      );
dataToReg dataToReg1(
              .memToReg(memtoreg),
              .jal(jal),
              .bgezal(bgezal),
              .bltzal(bltzal),
              .ZF(ZF),
              .PF(PF),
              .PCAdd4(CPCAdd4),
              .alures(aluRes),
              .mem_data(memreaddata),
              .w_data(regWriteData)
          );
// ��������������������������������������������������ʵ�����Ĵ���ģ��
RegFile regfile(
            .Clk(!clkin),
            .Clr(reset),
            .Write_Reg(regwrite),
            .R_Addr_A(instruction[25:21]),
            .R_Addr_B(instruction[20:16]),
            .W_Addr(muxlinkaddr),
            .W_Data(regWriteData),
            .mfhi(mfhi),
            .mflo(mflo),
            .mult(mult),
            .div(div),
            .W_data_hi(hi),
            .W_data_lo(lo),
            .R_Data_A(RsData),
            .R_Data_B(RtData)
        );
// ��������������������������������������������ʵ����ALUģ��
alu alu(
        .shamt(shamt),
        .input1(RsData), //д��alu�ĵ�һ������������Rs
        .input2(input2),
        .aluCtr(aluCtr),
        .ZF(ZF),
        .OF(OF),
        .CF(CF),
        .PF(PF),
        .hi(hi),
        .lo(lo),
        .aluRes(aluRes)
    );
//ʵ����������չģ��
signext signext(
            .inst(instruction[15:0]),
            .ExtOp(ExtOp),
            .data(expand)
        );
//ʵ�������ݴ洢��
dram dm(
         .clk(clkin),
         .memwrite(memwrite),
         .reset(reset),
         .flag(storemux),
         .addr(aluRes[7:0]),
         .write_data(RtData),
         .read_data(memreaddata)
     );
//...............................ʵ�����������ʾģ��
display Smg(.clk(clkin),.sm_wei(sm_wei),.data(data),.sm_duan(sm_duan));

endmodule
