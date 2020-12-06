`timescale 1ns / 1ps//寄存器堆模块
module RegFile(
input Clk,//写入时钟信号
input Clr,//清零信号
input Write_Reg,//写控制信号
input mfhi,
input mflo,
input mult,
input div,
input [31:0]W_data_hi,
input [31:0]W_data_lo,
input [4:0]R_Addr_A,//A端口读寄存器地址
input [4:0]R_Addr_B,//B端口读寄存器地址
input [4:0]W_Addr,//写寄存器地址
input [31:0]W_Data,//写入数据
output [31:0]R_Data_A,//A端口读出数据
output [31:0]R_Data_B//B端口读出数据
);
reg [31:0]REG_Files[0:31];//寄存器堆本体
reg [31:0]hi;//hi寄存器
reg [31:0]lo;//lo寄存器
integer i;//用于遍历NUMB个寄存器
initial//初始化NUMB个寄存器，全为0
    for(i=0;i<32;i=i+1)
        REG_Files[i]<=0;
always@(posedge Clk or posedge Clr)//时钟信号或清零信号上升沿
begin
    if(Clr)begin//清零
        for(i=0;i<32;i=i+1)
            REG_Files[i]<=0;
        lo<=0;
        hi<=0;
    end

    else//不清零,检测写控制, 高电平则写入寄存器
        if(Write_Reg)begin
            if(mfhi)//移动hi
                REG_Files[W_Addr]=hi;
            else if(mflo)//移动lo
                REG_Files[W_Addr]=lo;
            else if(mult || div)begin//乘除法结果写入lo,hi寄存器
                hi=W_data_hi;
                lo=W_data_lo;    
            end
            else
                REG_Files[W_Addr]<=W_Data;//其他正常写入寄存器
            
        end
end        //读操作没有使能或时钟信号控制, 使用数据流建模(组合逻辑电路,读不需要时钟控制)
assign R_Data_A=REG_Files[R_Addr_A];
assign R_Data_B=REG_Files[R_Addr_B];
endmodule
