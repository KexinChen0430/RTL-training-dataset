module counter (
    clk,    
    nrst,   
    e       
);
input wire clk;            
input wire nrst;           
output wire e;             
reg [7:0] count;           
assign e = |count;         
always @(posedge clk or negedge nrst) begin
    if (nrst == 1'b0)      
        count <= 8'd`KEYMSB; 
    else                   
        count <= count - 1'b1; 
end
endmodule 