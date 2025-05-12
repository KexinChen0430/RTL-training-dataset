module new_reg_value
#(
    parameter USED = 8  
)
(
    input       [ USED - 1 : 0 ] in,    
    output reg  [ USED - 1 : 0 ] out,   
    input       [       31 : 0 ] word,  
    input       [        2 : 0 ] cmd    
);
    localparam BYTE1_SIZE  = (USED > 32) ? (USED - 32) : 0;  
    localparam BYTE1_MAX   = (BYTE1_SIZE > 0) ? (BYTE1_SIZE - 1) : 0;  
    localparam BYTE1_START = (BYTE1_SIZE > 0) ? 32 : 0;  
    localparam BYTE1_END   = (BYTE1_SIZE > 0) ? (USED - 1) : 0;  
    always @ (*) begin
        if(USED < 33)
            case(cmd)
                default     : out = in;  
                `EIC_C_CLR0 : out = { USED {1'b0} };  
                `EIC_C_CLR1 : out = in;  
                `EIC_C_SET0 : out = { USED {1'b1} };  
                `EIC_C_SET1 : out = in;  
                `EIC_C_VAL0 : out = word [ USED - 1 : 0 ];  
                `EIC_C_VAL1 : out = in;  
                `EIC_C_CLRA : out = { USED {1'b0} };  
            endcase
        else
            case(cmd)
                default     : out = in;  
                `EIC_C_CLR0 : out = { in [ BYTE1_END : BYTE1_START ],   32'b0           };  
                `EIC_C_CLR1 : out = { { BYTE1_SIZE { 1'b0 } },          in [ 31 : 0 ]   };  
                `EIC_C_SET0 : out = { in [ BYTE1_END : BYTE1_START ],   ~32'b0          };  
                `EIC_C_SET1 : out = { { BYTE1_SIZE { 1'b1 } },          in [ 31 : 0 ]   };  
                `EIC_C_VAL0 : out = { in [ BYTE1_END : BYTE1_START ],   word            };  
                `EIC_C_VAL1 : out = { word [ BYTE1_MAX : 0 ],           in [ 31 : 0 ]   };  
                `EIC_C_CLRA : out = { USED {1'b0} };  
            endcase
        end
endmodule