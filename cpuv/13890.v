module lsu_mem2reg(addr, lsu_op, memdata, regdata);
parameter width = `OPERAND_WIDTH;
input   [1:0]               addr;       
input   [`LSUOP_WIDTH-1:0]  lsu_op;     
input   [width-1:0]         memdata;    
output  [width-1:0]         regdata;    
reg     [width-1:0]         regdata;    
reg     [width-1:0]         aligned;    
always @(addr or memdata) begin
`ifdef pippo_ADDITIONAL_SYNOPSYS_DIRECTIVES
    case(addr) 
`else
    case(addr) 
`endif
        2'b00:
            aligned = memdata;                 
        2'b01:
            aligned = {8'b0, memdata[55:0]};   
        2'b10:
            aligned = {16'b0, memdata[47:0]};  
        2'b11:
            aligned = {24'b0, memdata[39:0]};  
        default:
            aligned = memdata;                 
    endcase
end
always @(lsu_op or aligned) begin
`ifdef pippo_ADDITIONAL_SYNOPSYS_DIRECTIVES
    case(lsu_op) 
`else
    case(lsu_op) 
`endif
        `LSUOP_LB: begin
                regdata[63:8] = {56{aligned[7]}}; 
                regdata[7:0] = aligned[7:0];      
            end
        `LSUOP_LBU: begin
                regdata[63:8] = 56'b0;            
                regdata[7:0] = aligned[7:0];      
            end
        `LSUOP_LH: begin
                regdata[63:16] = {48{aligned[15]}}; 
                regdata[15:0] = aligned[15:0];      
            end
        `LSUOP_LHU: begin
                regdata[63:16] = 48'b0;             
                regdata[15:0] = aligned[15:0];      
            end
        `LSUOP_LW: begin
                regdata[63:32] = {32{aligned[31]}}; 
                regdata[31:0]  = aligned[31:0];     
            end
        `LSUOP_LWU: begin
                regdata[63:32] = {32{1'b0}};        
                regdata[31:0] = aligned[31:0];      
            end
        `LSUOP_LD: begin
                regdata[63:0] = aligned[63:0];      
            end
        default:
                regdata[63:0] = aligned[63:0];      
    endcase
end
endmodule