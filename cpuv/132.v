module reg_8bit(
    clk,            
    Load,           
    not_reset,      
    D,              
    Q               
);
input wire clk;
input wire not_reset;
input wire Load;
input wire [7:0] D;     
output wire [7:0] Q;    
reg [7:0] Q_ALTERA_SYNTHESIZED;
always@(posedge clk or negedge not_reset)
begin
    if (!not_reset) 
    begin
        Q_ALTERA_SYNTHESIZED[7] <= 0; 
    end
    else if (Load) 
    begin
        Q_ALTERA_SYNTHESIZED[7] <= D[7]; 
    end
end
always@(posedge clk or negedge not_reset)
begin
    if (!not_reset)
    begin
        Q_ALTERA_SYNTHESIZED[6] <= 0;
    end
    else if (Load)
    begin
        Q_ALTERA_SYNTHESIZED[6] <= D[6];
    end
end
always@(posedge clk or negedge not_reset)
begin
    if (!not_reset)
    begin
        Q_ALTERA_SYNTHESIZED[0] <= 0;
    end
    else if (Load)
    begin
        Q_ALTERA_SYNTHESIZED[0] <= D[0];
    end
end
assign Q = Q_ALTERA_SYNTHESIZED;
endmodule 