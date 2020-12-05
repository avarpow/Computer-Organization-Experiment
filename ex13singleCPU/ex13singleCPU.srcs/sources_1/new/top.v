`timescale 1ns / 1ps
module top(
input clkin,
input reset,
input [7:0]PC,
output [6:0] sm_duan,//����
output [3:0] sm_wei,//�ĸ������
output [31:0]aluRes,
output [31:0]instruction
);
// �������ź���
//wire[31:0] expand2, mux4, mux5, address, jmpaddr;
//���ݴ洢��
wire[31:0] memreaddata;
// ָ��洢�� 
//wire [31:0] instruction; 
reg[7:0] Addr;
// CPU �����ź���
wire reg_dst,jmp,branch, memread, memwrite, memtoreg,alu_src,ExtOp; 
wire[3:0] aluop;
wire regwrite;
// ALU �����ź���
wire ZF,OF,CF; //alu����Ϊ���־ 
wire[31:0] aluRes; //alu������
// ALU�����ź���
wire[3:0] aluCtr;//����aluop��ָ���6λ ѡ��alu��������
//wire[31:0] aluRes; //alu������
wire[31:0] input2;
wire [15:0]data;
// �Ĵ����ź���
wire[31:0] RsData, RtData;
wire[31:0] expand; wire[4:0] shamt;
wire [4:0]regWriteAddr;
wire[31:0]regWriteData;
assign shamt=instruction[10:6];
assign regWriteAddr = reg_dst ? instruction[15:11] : instruction[20:16];//д�Ĵ�����Ŀ��Ĵ�������rt��rd
assign data=aluRes[15:0];
assign regWriteData = memtoreg ? memreaddata : aluRes; //д��Ĵ�������������ALU�����ݼĴ��� 
assign input2 = alu_src ? expand : RtData; //ALU�ĵڶ������������ԼĴ����������ָ���16λ�ķ�����չ
// ����ָ��洢��

rom_top trom(
    .Clk(clkin),
    .Rst(1b'1),
    .addr(PC[7:0]),
    .data()
)
// ʵ����������ģ��
ctr mainctr(
.opCode(instruction[31:26]),
.regDst(reg_dst),
.aluSrc(alu_src),
.memToReg(memtoreg),
.regWrite(regwrite),
.memRead(memread),
.memWrite(memwrite),
.branch(branch),
.ExtOp(ExtOp),
.aluop(aluop),
.jmp(jmp));
//  ʵ���� ALU ����ģ��
aluctr aluctr1(
.ALUOp(aluop),
.funct(instruction[5:0]),
.ALUCtr(aluCtr));
// ��������������������������������������������������ʵ�����Ĵ���ģ��
RegFile regfile(
.RsAddr(instruction[25:21]),
.RtAddr(instruction[20:16]),
.clk(!clkin),
.reset(reset),
.regWriteAddr(regWriteAddr),
.regWriteData(regWriteData),
.regWriteEn(regwrite),
.RsData(RsData),
.RtData(RtData)
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
.aluRes(aluRes));
//ʵ����������չģ��
signext signext(.inst(instruction[15:0]),.ExtOp(ExtOp), .data(expand));
//ʵ�������ݴ洢��
 DM_unit dm(.clk(clkin), .Wr(memwrite),
            .reset(reset),           
             .DMAdr(aluRes), 
             .wd(RtData),
             .rd( memreaddata));
//...............................ʵ�����������ʾģ��
display Smg(.clk(clkin),.sm_wei(sm_wei),.data(data),.sm_duan(sm_duan)); 

endmodule
