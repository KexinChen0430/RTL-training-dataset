module Sign_Ext_Return (
    result,
    operand,
    size,
    signage
);
    `include "definition/Definition.v" 
    output      reg     [WORD-1:0]                             result;     
    input               [WORD-1:0]                             operand;    
    input               [LOGWORDBYTE-1:0]                      size;       
    input                                                       signage;    
    reg     [WORD-1:0]                             extend      [WORDBYTE-1:0];
    genvar i; 
    generate
        for(i=0; i<WORDBYTE; i=i+1) begin 
            always @(*) begin 
                extend[i]  <= { 
                    {( (WORDBYTE-i-1)*BYTE ){signage && operand[(i+1)*BYTE-1]}}, 
                    operand[(i+1)*BYTE-1:0] 
                };
            end
        end
    endgenerate
    always @(*) begin 
        result  <= extend[size]; 
    end
endmodule