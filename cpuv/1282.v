module or1200_sb_fifo(
    clk_i,   
    rst_i,   
    dat_i,   
    wr_i,    
    rd_i,    
    dat_o,   
    full_o,  
    empty_o  
);
parameter dw = 68;             
parameter fw = `OR1200_SB_LOG; 
parameter fl = `OR1200_SB_ENTRIES; 
input           clk_i;         
input           rst_i;         
input  [dw-1:0] dat_i;         
input           wr_i;          
input           rd_i;          
output [dw-1:0] dat_o;         
output          full_o;        
output          empty_o;       
reg [dw-1:0]    mem [fl-1:0];  
reg [dw-1:0]    dat_o;         
reg [fw+1:0]    cntr;          
reg [fw-1:0]    wr_pntr;       
reg [fw-1:0]    rd_pntr;       
reg             empty_o;       
reg             full_o;        
always @(posedge clk_i or posedge rst_i)
    if (rst_i) begin
        full_o <= #1 1'b0;
        empty_o <= #1 1'b1;
        wr_pntr <= #1 {fw{1'b0}};
        rd_pntr <= #1 {fw{1'b0}};
        cntr <= #1 {fw+2{1'b0}};
        dat_o <= #1 {dw{1'b0}};
    end
    else if (wr_i && rd_i) begin 
        mem[wr_pntr] <= #1 dat_i;
        if (wr_pntr >= fl-1)
            wr_pntr <= #1 {fw{1'b0}};
        else
            wr_pntr <= #1 wr_pntr + 1'b1;
        if (empty_o) begin
            dat_o <= #1 dat_i;
        end
        else begin
            dat_o <= #1 mem[rd_pntr];
        end
        if (rd_pntr >= fl-1)
            rd_pntr <= #1 {fw{1'b0}};
        else
            rd_pntr <= #1 rd_pntr + 1'b1;
    end
    else if (wr_i && !full_o) begin 
        mem[wr_pntr] <= #1 dat_i;
        cntr <= #1 cntr + 1'b1;
        empty_o <= #1 1'b0;
        if (cntr >= (fl-1)) begin
            full_o <= #1 1'b1;
            cntr <= #1 fl;
        end
        if (wr_pntr >= fl-1)
            wr_pntr <= #1 {fw{1'b0}};
        else
            wr_pntr <= #1 wr_pntr + 1'b1;
    end
    else if (rd_i && !empty_o) begin 
        dat_o <= #1 mem[rd_pntr];
        cntr <= #1 cntr - 1'b1;
        full_o <= #1 1'b0;
        if (cntr <= 1) begin
            empty_o <= #1 1'b1;
            cntr <= #1 {fw+2{1'b0}};
        end
        if (rd_pntr >= fl-1)
            rd_pntr <= #1 {fw{1'b0}};
        else
            rd_pntr <= #1 rd_pntr + 1'b1;
    end
endmodule