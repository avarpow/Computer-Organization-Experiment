module ForwardingUnit( EXEMEM_RFWr, MEMWB_RFWr, MEMWB_DMWr, EXEMEM_DMWr, EXEMEM_DMRd,
                       EXEMEM_rd,   MEMWB_rd,   IFID_DMWr,  MEMWB_DMRd,
                       IFID_rs,     IFID_rt,    IDEXE_rd,   IDEXE_RFWr,  IDEXE_DMWr,
                       IDEXE_rs,    IDEXE_rt,   ALU_A,      ALU_B,       DMdata_ctrl,
                       NPC_F1,      NPC_F2,     SW_ctrl,
                       ALUSrc1,     ALUSrc2);
 
    input        EXEMEM_RFWr;
    input        MEMWB_RFWr;
    input        IDEXE_RFWr;
    input [1:0]  IFID_DMWr;
    input [1:0]  IDEXE_DMWr;
    input [1:0]  MEMWB_DMWr;
    input [3:0]  MEMWB_DMRd;
    input [3:0]  EXEMEM_DMRd;
    input [1:0]  EXEMEM_DMWr;
    input        ALUSrc1;
    input        ALUSrc2;
    input [4:0]  EXEMEM_rd;
    input [4:0]  MEMWB_rd;
    input [4:0]  IFID_rs;
    input [4:0]  IFID_rt;    
    input [4:0]  IDEXE_rs;
    input [4:0]  IDEXE_rt;
    input [4:0]  IDEXE_rd;

    output reg [1:0] ALU_A;
    output reg [1:0] ALU_B;
    output reg       NPC_F1;
    output reg       NPC_F2;
    output reg [1:0] SW_ctrl;
    output reg       DMdata_ctrl;

initial
    begin
        ALU_A       <= 2'b00;//no foward 
        ALU_B       <= 2'b00;//no foward
        NPC_F1      <= 1'b0;
        NPC_F2      <= 1'b0;
        DMdata_ctrl <= 1'b0;
        SW_ctrl     <= 2'b0;
    end

always @(*)
    begin
        ALU_A       <= 2'b00;//no foward 
        ALU_B       <= 2'b00;//no foward
        NPC_F1      <= 1'b0;
        NPC_F2      <= 1'b0;
        DMdata_ctrl <= 1'b0;
        SW_ctrl     <= 2'b0;

        //pc是否跳转的判断全部放在ID-EXE阶段就完成了，这个时候只需要flush一条指令
        if(IDEXE_RFWr && (IDEXE_rd != 0) && (IDEXE_rd != 31))
            begin
                if( (IFID_rs == IDEXE_rd) ) NPC_F1 <= 1'b1;
                if( (IFID_rt == IDEXE_rd) ) NPC_F2 <= 1'b1;
            end

        if(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31))
            begin
                if( (IDEXE_rs == EXEMEM_rd) ) ALU_A <=  2'b01;//foward from exe;
                if( (IDEXE_rt == EXEMEM_rd) && ALUSrc2 == 1'b0 && (IDEXE_DMWr == 3'b000) ) ALU_B <=  2'b01;//foward from exe;
            end


        if(MEMWB_RFWr && (MEMWB_rd != 0) && (MEMWB_rd != 31))
            begin
                if( !(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31) && (EXEMEM_rd == IDEXE_rs)) && MEMWB_DMRd == 3'b000 
                	&& (MEMWB_rd == IDEXE_rs) )
                    ALU_A <=  2'b10;//foward from mem
                
                if( !(EXEMEM_RFWr && (EXEMEM_rd != 0) && (EXEMEM_rd != 31) && (EXEMEM_rd == IDEXE_rt)) && MEMWB_DMRd == 3'b000
                    && (MEMWB_rd == IDEXE_rt) && (IDEXE_DMWr == 3'b000) )
                    ALU_B <=  2'b10;//foward from mem

            end

        //sw指令的上一条没有写回reg，需要转发
        if( EXEMEM_DMWr != 3'b000
        	&& (MEMWB_rd == EXEMEM_rd) && (MEMWB_rd != 0) && (MEMWB_rd != 31) && MEMWB_DMWr == 3'b000)
            begin
            DMdata_ctrl <= 1'b1; //MEM2MEM
            end

        //分别对应 将alu运算结果转发成为写入内存的数据和将刚从内存中读取的数据作为写入内存的数据
        if( IFID_DMWr != 3'b000 && IFID_rt == EXEMEM_rd && (EXEMEM_rd != 0) && (EXEMEM_rd != 31) 
            && EXEMEM_DMWr == 3'b000 )
                if( EXEMEM_DMRd == 3'b000 ) 
                    SW_ctrl <= 2'b01; //other, xxx, SW
                else
                    SW_ctrl <= 2'b10; //LW, xxx, SW 
    end
endmodule