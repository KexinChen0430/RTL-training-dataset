module counter_v2
    #(parameter C_MAX_VALUE = 10, 
      parameter C_SAT_VALUE = 10, 
      parameter C_FLR_VALUE = 0,  
      parameter C_RST_VALUE = 0)  
    (input                              CLK,     
     input                              RST_IN,  
     input                              INC,     
     input                              DEC,     
     output [clog2s(C_MAX_VALUE+1)-1:0] VALUE); 
`include "functions.vh" 
    wire                                wInc;    
    wire                                wDec;    
    reg [clog2s(C_MAX_VALUE+1)-1:0]     wCtrValue; 
    reg [clog2s(C_MAX_VALUE+1)-1:0]     rCtrValue; 
    assign wInc = INC & (C_SAT_VALUE > rCtrValue); 
    assign wDec = DEC & (C_FLR_VALUE < rCtrValue); 
    assign VALUE = rCtrValue; 
    always @(posedge CLK) begin 
        if(RST_IN) begin 
            rCtrValue <= C_RST_VALUE[clog2s(C_MAX_VALUE+1)-1:0]; 
        end else if(wInc & wDec) begin 
            rCtrValue <= rCtrValue + 0; 
        end else if(wInc) begin 
            rCtrValue <= rCtrValue + 1; 
        end else if(wDec) begin 
            rCtrValue <= rCtrValue - 1; 
        end
    end
endmodule