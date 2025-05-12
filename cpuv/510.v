module sdr_data_path(
        CLK,        
        RESET_N,    
        DATAIN,     
        DM,         
        DQOUT,      
        DQM         
        );
input                           CLK;        
input                           RESET_N;    
input   [`DSIZE-1:0]            DATAIN;     
input   [`DSIZE/8-1:0]          DM;         
output  [`DSIZE-1:0]            DQOUT;      
output  [`DSIZE/8-1:0]          DQM;        
reg     [`DSIZE/8-1:0]          DQM;
reg     [`DSIZE-1:0]            DIN1;       
reg     [`DSIZE-1:0]            DIN2;       
reg     [`DSIZE/8-1:0]          DM1;        
always @(posedge CLK or negedge RESET_N)
begin
        if (RESET_N == 0)
        begin
                DIN1    <= 0;    
                DIN2    <= 0;    
                DM1     <= 0;    
        end
        else 
        begin
                DIN1    <= DATAIN;   
                DIN2    <= DIN1;     
 				DQM     <= DM;       
        end
end
assign DQOUT = DIN2; 
endmodule