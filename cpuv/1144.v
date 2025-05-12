module counter
    #(parameter C_MAX_VALUE = 10,  
      parameter C_SAT_VALUE = 10,  
      parameter C_RST_VALUE = 0)   
    (
     input                              CLK,      
     input                              RST_IN,   
     input                              ENABLE,   
     output [clog2s(C_MAX_VALUE+1)-1:0] VALUE     
     );
`include "functions.vh"
wire wEnable;
reg [clog2s(C_MAX_VALUE+1)-1:0] wCtrValue;
reg [clog2s(C_MAX_VALUE+1)-1:0] rCtrValue;
assign wEnable = ENABLE & (C_SAT_VALUE > rCtrValue);
assign VALUE = rCtrValue;
always @(posedge CLK) begin
    if(RST_IN) begin
        rCtrValue <= C_RST_VALUE;
    end else if(wEnable) begin
        rCtrValue <= rCtrValue + 1;
    end
end
endmodule