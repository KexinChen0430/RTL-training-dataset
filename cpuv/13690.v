module lsu_reg2mem(addr, lsu_op, regdata, memdata);
parameter width = `OPERAND_WIDTH;
input   [2:0]           addr;       
input   [`LSUOP_WIDTH-1:0]  lsu_op; 
input   [width-1:0]     regdata;    
output  [width-1:0]     memdata;    
reg [7:0]           memdata_000;     
reg [7:0]           memdata_001;     
reg [7:0]           memdata_010;     
reg [7:0]           memdata_011;     
reg [7:0]           memdata_100;     
reg [7:0]           memdata_101;     
reg [7:0]           memdata_110;     
reg [7:0]           memdata_111;     
assign memdata = {memdata_111, memdata_110, memdata_101, memdata_100, memdata_011, memdata_010, memdata_001, memdata_000};
always @(lsu_op or addr or regdata) begin
    casex({lsu_op, addr[2:0]}) 
        {`LSUOP_SB, 3'b000} : memdata_000 = regdata[7:0]; 
        {`LSUOP_SH, 3'b000} : memdata_000 = regdata[7:0]; 
        {`LSUOP_SW, 3'b000} : memdata_000 = regdata[7:0]; 
        {`LSUOP_SD, 3'b000} : memdata_000 = regdata[7:0]; 
        default : memdata_000 = regdata[7:0]; 
    endcase
end
always @(lsu_op or addr or regdata) begin
    casex({lsu_op, addr[2:0]}) 
        {`LSUOP_SB, 3'b001} : memdata_001 = regdata[7:0]; 
        {`LSUOP_SH, 3'b000} : memdata_001 = regdata[15:8]; 
        {`LSUOP_SW, 3'b000} : memdata_001 = regdata[15:8]; 
        {`LSUOP_SD, 3'b000} : memdata_001 = regdata[15:8]; 
        default : memdata_001 = regdata[15:8]; 
    endcase
end
always @(lsu_op or addr or regdata) begin
    casex({lsu_op, addr[2:0]}) 
        {`LSUOP_SB, 3'b010} : memdata_010 = regdata[7:0]; 
        {`LSUOP_SH, 3'b010} : memdata_010 = regdata[7:0]; 
        {`LSUOP_SW, 3'b000} : memdata_010 = regdata[23:16]; 
        {`LSUOP_SD, 3'b000} : memdata_010 = regdata[23:16]; 
        default : memdata_001 = regdata[23:16]; 
    endcase
end
always @(lsu_op or addr or regdata) begin
    casex({lsu_op, addr[2:0]}) 
        {`LSUOP_SB, 3'b011} : memdata_011 = regdata[7:0]; 
        {`LSUOP_SH, 3'b010} : memdata_011 = regdata[15:8]; 
        {`LSUOP_SW, 3'b000} : memdata_011 = regdata[31:24]; 
        {`LSUOP_SD, 3'b000} : memdata_011 = regdata[31:24]; 
        default : memdata_001 = regdata[31:24]; 
    endcase
end
always @(lsu_op or addr or regdata) begin
    casex({lsu_op, addr[2:0]}) 
        {`LSUOP_SB, 3'b100} : memdata_100 = regdata[7:0]; 
        {`LSUOP_SH, 3'b100} : memdata_100 = regdata[7:0]; 
        {`LSUOP_SW, 3'b100} : memdata_100 = regdata[7:0]; 
        {`LSUOP_SD, 3'b000} : memdata_100 = regdata[39:32]; 
        default : memdata_000 = regdata[7:0]; 
    endcase
end
always @(lsu_op or addr or regdata) begin
    casex({lsu_op, addr[2:0]}) 
        {`LSUOP_SB, 3'b101} : memdata_101 = regdata[7:0]; 
        {`LSUOP_SH, 3'b100} : memdata_101 = regdata[15:8]; 
        {`LSUOP_SW, 3'b100} : memdata_101 = regdata[15:8]; 
        {`LSUOP_SD, 3'b000} : memdata_101 = regdata[47:40]; 
        default : memdata_101 = regdata[47:40]; 
    endcase
end
always @(lsu_op or addr or regdata) begin
    casex({lsu_op, addr[2:0]}) 
        {`LSUOP_SB, 3'b110} : memdata_110 = regdata[7:0]; 
        {`LSUOP_SH, 3'b110} : memdata_110 = regdata[7:0]; 
        {`LSUOP_SW, 3'b100} : memdata_110 = regdata[23:16]; 
        {`LSUOP_SD, 3'b000} : memdata_110 = regdata[55:48]; 
        default : memdata_001 = regdata[55:48]; 
    endcase
end
always @(lsu_op or addr or regdata) begin
    casex({lsu_op, addr[2:0]}) 
        {`LSUOP_SB, 3'b111} : memdata_111 = regdata[7:0]; 
        {`LSUOP_SH, 3'b110} : memdata_111 = regdata[15:8]; 
        {`LSUOP_SW, 3'b100} : memdata_111 = regdata[31:24]; 
        {`LSUOP_SD, 3'b000} : memdata_111 = regdata[63:56]; 
        default : memdata_001 = regdata[63:56]; 
    endcase
end
endmodule