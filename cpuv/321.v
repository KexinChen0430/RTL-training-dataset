module pipeline5(
    clk_in,      
    RST,         
    ctrl_in,     
    data,        
    addr,        
    data_out,    
    addr_out,    
    en_out       
);
`include "params_proc.v"
input clk_in, RST;
input [CTRL_WIDTH-1:0] ctrl_in; 
input signed [DATA_WIDTH-1:0] data; 
input [REG_ADDR_WIDTH-1:0] addr; 
output reg signed [DATA_WIDTH-1:0] data_out; 
output reg [REG_ADDR_WIDTH-1:0] addr_out; 
output reg en_out; 
always @(posedge clk_in) begin
    data_out <= data; 
    addr_out <= addr; 
end
always @(posedge clk_in) begin
    if (!RST) begin
        en_out <= 0;
    end else begin
        case (ctrl_in)
            LW:       en_out <= 1; 
            LW_IMM:   en_out <= 1; 
            ADD:      en_out <= 1; 
            SUB:      en_out <= 1; 
            MUL:      en_out <= 1; 
            DIV:      en_out <= 1; 
            AND:      en_out <= 1; 
            OR:       en_out <= 1; 
            NOT:      en_out <= 1; 
            default:  en_out <= 0;
        endcase
    end
end
endmodule 