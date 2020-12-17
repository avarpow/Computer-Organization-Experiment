`timescale 1ns / 1ps
module top(
        input clkin,
        input clkdisplay,
        input reset,
        input high_low_choose,
        input pc_npc_choose,
        output [6:0] sm_duan,//段码
        output [3:0] sm_wei,//哪个数码管
        output  syscall,
        output [7:0] lPC

        //output [31:0] aluRes,
        //output [31:0] instruction
       );
wire [31:0] aluRes;
wire [31:0] PC;
wire [31:0] instruction;
assign lPC=PC[9:2];

//数据存储器
wire[31:0] memreaddata;
// 指令存储器
//wire [31:0] instruction;
reg[7:0] Addr;
// CPU 控制信号线
wire reg_dst,memread, memwrite, memtoreg,alu_src,alu_zeroinput,ExtOp;
wire[3:0] aluop;
wire regwrite;
wire jmp,jal,jr,bne,beq,bgez,bgezal,bgtz,blez,bltz,bltzal;
wire mult,div,mflo,mfhi,PCWrite,noop,halt;
wire [1:0]storemux;
// ALU 控制信号线
wire ZF,OF,CF,PF; //alu运算标志
wire[31:0] hi,lo; //alu运算结果
// ALU控制信号线
wire[4:0] aluCtr;//根据aluop和指令后6位 选择alu运算类型
//
wire[31:0] input2;
wire[31:0] nextPC;
wire [15:0]data;
//link
wire [4:0] linkaddr;
//datatoreg
wire link_reg_write;
 
//PCctr
wire [31:0] CPCadd4;
// 寄存器信号线
wire[31:0] RsData, RtData;
wire[31:0] expand; wire[4:0] shamt;
wire [4:0]regWriteAddr;
wire[31:0]regWriteData;
//link
wire [4:0]muxlinkaddr;
assign shamt=instruction[10:6];
assign regWriteAddr = reg_dst ? instruction[15:11] : instruction[20:16];//写寄存器的目标寄存器来自rt或rd
assign data=aluRes[15:0];
//assign regWriteData = memtoreg ? memreaddata : aluRes; //写入寄存器的数据来自ALU或数据寄存器
//assign input2 = alu_src ? expand : RtData; //ALU的第二个操作数来自寄存器堆输出或指令低16位的符号扩展
// 例化指令存储器

// rom_top trom(
//             .Clk(clkin),
//             .Rst(1'b0),
//             .PC(PC),
//             .data(instruction)
//         );
im trom(
    .Addr(PC[9:2]),
    .instruction(instruction)
);
// 实例化控制器模块
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
//  实例化 ALU 控制模块
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
          .bgtz(bgtz),
          .blez(blez),
          .bltz(bltz),
          .bltzal(bltzal),
          .ZF(ZF),
          .PF(PF),
          .PC(PC),
          .CPCadd4(CPCadd4),
          .nextPC(nextPC)
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
// 。。。。。。。。。。。。。。。。。。。。。。。。。实例化寄存器模块
RegFile regfile(
            .Clk(clkin),
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
// 。。。。。。。。。。。。。。。。。。。。。。实例化ALU模块
alu alu(
        .shamt(shamt),
        .input1(RsData), //写入alu的第一个操作数必是Rs
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
//实例化符号扩展模块
signext signext(
            .inst(instruction[15:0]),
            .ExtOp(ExtOp),
            .data(expand)
        );
//实例化数据存储器
dram dm(
         .clk(clkin),
         .memwrite(memwrite),
         .reset(reset),
         .flag(storemux),
         .addr(aluRes[7:0]),
         .write_data(RtData),
         .read_data(memreaddata)
     );
//...............................实例化数码管显示模块
display Smg(
    .clk(clkdisplay),
    .high_low_choose(high_low_choose),
    .pc_npc_choose(pc_npc_choose),
    .alures(aluRes),
    .pc(PC),
    .npc(nextPC),
    .sm_wei(sm_wei),
    .sm_duan(sm_duan)
);

endmodule
