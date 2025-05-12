module sdr_data_path(
    CLK,
    RESET_N,
    DATAIN,
    DM,
    DQOUT,
    DQM
);
`include "Sdram_Params.h" 
input CLK;                    
input RESET_N;                
input [`DSIZE-1:0] DATAIN;    
input [`DSIZE/8-1:0] DM;      
output [`DSIZE-1:0] DQOUT;    
output [`DSIZE/8-1:0] DQM;    
reg [`DSIZE/8-1:0] DQM;       
always @(posedge CLK or negedge RESET_N)
begin
    if (RESET_N == 0)          
        DQM <= `DSIZE/8-1'hF;  
    else                       
        DQM <= DM;             
end
assign DQOUT = DATAIN;         
endmodule 