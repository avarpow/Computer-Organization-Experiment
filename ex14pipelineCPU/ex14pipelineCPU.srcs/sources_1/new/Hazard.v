`include "ctrl_encode_def.v"
module Hazard ( pc, npc, EXEMEM_DMRd, EXEMEM_rd, rs,
                //output
                IFID_stall, IFID_flush, IDEXE_stall, PC_stall, jump );


    input   [31:0]  pc;
    input   [31:0]  npc;
    input   [3:0]   EXEMEM_DMRd;
    input   [4:0]   EXEMEM_rd;
    input   [4:0]   rs;

    output reg      IFID_stall;
    output reg      IFID_flush;
    output reg      IDEXE_stall;
    output reg      PC_stall;
    output reg      jump;


initial
begin
    IFID_stall  <= 1'b0;
    IFID_flush  <= 1'b0;
    IDEXE_stall <= 1'b0; 
    PC_stall    <= 1'b0;
    jump        <= 1'b0;
end

always @(*)
    begin
        //lw指令 和 其他指令的冲突 暂停一个周期
        if( EXEMEM_DMRd != `DMRd_NOP && (EXEMEM_rd == rs) ) 
            begin
                PC_stall    <= 1'b1;
                IFID_stall  <= 1'b1;
                IDEXE_stall <= 1'b1;
            end
        //直接通过判断npc和pc的对比来判断是否需要进行跳转指令，因为前文已经统一了跳转指令在ID-EXE阶段
        //判断，这里只需要统一flush一条指令。
        else if( npc != pc + 4 && npc != pc)
                    begin
                        PC_stall    <= 1'b0;
                        jump        <= 1'b1;  
                        IFID_stall  <= 1'b0;
                        IFID_flush  <= 1'b1;  
                    end
        else if (npc==pc)
            begin
            PC_stall    <= 1'b0;
            jump        <= 1'b1;  
            IFID_stall  <= 1'b0;
            IFID_flush  <= 1'b1;
            end
        else
            begin
                IFID_stall  <= 1'b0;
                IFID_flush  <= 1'b0;
                IDEXE_stall <= 1'b0; 
                PC_stall    <= 1'b0;
                jump        <= 1'b0;
            end
    end
endmodule