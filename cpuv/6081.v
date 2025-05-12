module clock_divider_sim #(
    parameter DIVISOR = 2 
) (
    input wire CLK,        
    output reg CLOCK       
);
integer cnt;              
initial cnt = 0;          
wire [31:0] DIV;          
assign DIV = DIVISOR;     
always @(posedge CLK)
    if(cnt == DIVISOR -1) 
        cnt <= 0;
    else                  
        cnt <= cnt + 1;
initial CLOCK = 0;        
always @(posedge CLK or negedge CLK) begin
    if(cnt == DIVISOR-1 && CLK == 1'b1) 
        CLOCK <= 1;                     
    else if (cnt == DIVISOR/2-1 && DIV[0] == 0 && CLK == 1'b1) 
        CLOCK <= 0;                                             
    else if (cnt == DIVISOR/2 && DIV[0] == 1 && CLK == 1'b0)    
        CLOCK <= 0;                                             
end
endmodule 