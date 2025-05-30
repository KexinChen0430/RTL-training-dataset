module Memory(
    clk_i,          
    we_i,           
    if_cnt_i,       
    w_cnt_i,        
    w_dat_i,        
    w_adr_i,        
    inst_adr_i,     
    if_adr_i,       
    ea_adr_i,       
    rd_adr_i,       
    stl_o,          
    inst_o,         
    if_dat_o,       
    ea_dat_o,       
    rd_dat_o,       
`ifdef DEBUG
    debug_o,        
`endif
);
input wire clk_i;                             
input wire we_i;                              
input wire [1:0] if_cnt_i;                    
input wire [1:0] w_cnt_i;                     
input wire [3 * `DAT_WIDTH - 1:0] w_dat_i;    
input wire [`ADR_WIDTH - 1:0] w_adr_i;        
input wire [`ADR_WIDTH - 1:0] inst_adr_i;     
input wire [`ADR_WIDTH - 1:0] if_adr_i;       
input wire [`ADR_WIDTH - 1:0] ea_adr_i;       
input wire [`ADR_WIDTH - 1:0] rd_adr_i;       
output reg stl_o;                             
output wire [1 * `DAT_WIDTH - 1:0] inst_o;    
output wire [3 * `DAT_WIDTH - 1:0] if_dat_o;  
output wire [2 * `DAT_WIDTH - 1:0] ea_dat_o;  
output wire [1 * `DAT_WIDTH - 1:0] rd_dat_o;  
`ifdef DEBUG
output wire [`MEM_DBG_WIDTH - 1:0] debug_o;   
`endif
reg [1:0] w_cnt;                             
reg [`ADR_WIDTH - 1:0] w_adr;                
reg [3 * `DAT_WIDTH - 1:0] w_dat;            
reg [`MEM_WIDTH - 1:0] MEM[0:`MEM_DEPTH - 1]; 
assign inst_o = MEM[inst_adr_i];             
assign if_dat_o =                             
    (if_cnt_i == 2'h1) ? {16'hFFFF, MEM[if_adr_i]} : 
    (if_cnt_i == 2'h2) ? {8'hFF, MEM[if_adr_i + 1], MEM[if_adr_i]} : 
    (if_cnt_i == 2'h3) ? {MEM[if_adr_i + 2], MEM[if_adr_i + 1], MEM[if_adr_i]} : 
    if_dat_o; 
assign ea_dat_o = {MEM[ea_adr_i + 1], MEM[ea_adr_i]}; 
assign rd_dat_o = MEM[rd_adr_i];             
`ifdef DEBUG
assign debug_o = {8'h0, MEM[inst_adr_i]};    
`endif
initial
begin
    MEM[65532] = 8'h2E;
    MEM[65533] = 8'h80;
    MEM[32832] = 8'hF6;
end
always @(posedge clk_i)
begin
    if(we_i || stl_o) 
    begin
        if(w_cnt_i > 2'h1 || stl_o == 1'h1) 
        begin
            if(stl_o == 1'h0) 
            begin
                stl_o <= 1'h1; 
                w_cnt <= w_cnt_i; 
                w_dat <= w_dat_i; 
                w_adr <= w_adr_i; 
            end
            else if(w_cnt > 2'h1 && stl_o == 1'h1) 
            begin
                w_cnt <= w_cnt - 2'h1; 
                w_dat <= w_dat >> 4'h8; 
                MEM[w_adr + w_cnt - 2'h1] <= w_dat[7:0]; 
            end
            else 
            begin
                stl_o <= 1'h0; 
                MEM[w_adr + w_cnt - 2'h1] <= w_dat[7:0]; 
            end
        end
        else 
        begin
            stl_o <= 1'h0; 
            MEM[w_adr_i] <= w_dat_i; 
        end
    end
end
endmodule