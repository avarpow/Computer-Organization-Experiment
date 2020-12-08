`timescale 1ns / 1ps
module top(
           input clkin,
           //input reset,
           output [6:0] sm_duan,//����
           output [3:0] sm_wei,//�ĸ������
           output [12:0] lPC,
           //output [31:0] aluRes
           //output [31:0] instruction
           output clk_sys_led
       );
// �������ź���
//��������ģ��
reg [28:0] div_counter =0;
reg clk_sys =0; 
reg reset;
assign clk_sys_led=clk_sys;
initial begin
    // Initialize Inputs 

    reset=0;
    #100;
    reset = 1;
    clk_sys=0;
    #1;
    clk_sys=1;
    #1
    clk_sys=0;
    #1;
    clk_sys=1;
    #100;
    reset=0;
    // Wait 100 ns for global reset to finish 
    #200;
end
always @(posedge clkin) begin
    if(div_counter >= 100000000) begin
        clk_sys<=~clk_sys;
        div_counter <=0;
    end
    else begin
        div_counter <= div_counter +1;
    end
end
wire [31:0] PC;
assign lPC[12:0]=PC[12:0];
//���ݴ洢��
wire[31:0] memreaddata;
// ָ��洢��
//wire [31:0] instruction;
//reg[7:0] Addr;
wire[31:0] instruction;
// CPU �����ź���
wire reg_dst,memread, memwrite, memtoreg,alu_src,alu_zeroinput,ExtOp;
wire[3:0] aluop;
wire regwrite;
wire jmp,jal,jr,bne,beq,bgez,bgezal,bgtz,blez,bltz,bltzal;
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
//datatoreg
wire link_reg_write;
 
//PCctr
wire [31:0] CPCadd4;
// �Ĵ����ź���
wire[31:0] RsData, RtData;
wire[31:0] expand; wire[4:0] shamt;
wire [4:0]regWriteAddr;
wire[31:0]regWriteData;
//link
wire [4:0]muxlinkaddr;
wire [31:0]aluRes;
assign shamt=instruction[10:6];
assign regWriteAddr = reg_dst ? instruction[15:11] : instruction[20:16];//д�Ĵ�����Ŀ��Ĵ�������rt��rd
assign data=aluRes[15:0];
//assign regWriteData = memtoreg ? memreaddata : aluRes; //д��Ĵ�������������ALU�����ݼĴ���
//assign input2 = alu_src ? expand : RtData; //ALU�ĵڶ������������ԼĴ����������ָ���16λ�ķ�����չ
// ����ָ��洢��

rom_top trom(
            .Clk(clk_sys),
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
        .bgtz(bgtz),
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
          .clkin(clk_sys),
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
          .bgtz(bgtz),
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
              .regWrite(regwrite),
              .bgezal(bgezal),
              .bltzal(bltzal),
              .ZF(ZF),
              .PF(PF),
              .PCAdd4(CPCadd4),
              .alures(aluRes),
              .mem_data(memreaddata),
              .w_data(regWriteData),
              .link_reg_write(link_reg_write)
          );
// ��������������������������������������������������ʵ�����Ĵ���ģ��
RegFile regfile(
            .Clk(clk_sys),
            .Clr(reset),
            .Write_Reg(link_reg_write),
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
         .clk(clk_sys),
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
