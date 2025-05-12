module oh_memory_ram  # (
    parameter DW    = 104,           
    parameter DEPTH = 32,            
    parameter AW    = $clog2(DEPTH), 
    parameter PLATFORM = `CFG_PLATFORM 
)
(
    input               rd_clk,   
    input               rd_en,    
    input [AW-1:0]      rd_addr,  
    output reg [DW-1:0] rd_dout,  
    input               wr_clk,   
    input               wr_en,    
    input [AW-1:0]      wr_addr,  
    input [DW-1:0]      wr_wem,   
    input [DW-1:0]      wr_din    
);
generate
    if(PLATFORM == "ZYNQ") 
    begin : xilinx
        integer             i; 
        (* ram_style = "distributed" *)
        reg [DW-1:0]        ram[DEPTH-1:0]; 
        always @ (posedge rd_clk) 
            if(rd_en) 
                rd_dout[DW-1:0] <= ram[rd_addr[AW-1:0]]; 
        always @(posedge wr_clk) 
            for (i=0; i<DW; i=i+1) 
                if (wr_en & wr_wem[i]) 
                    ram[wr_addr[AW-1:0]][i] <= wr_din[i]; 
    end 
    else 
    begin : generic
        integer             i; 
        reg [DW-1:0]        ram[DEPTH-1:0]; 
        always @ (posedge rd_clk) 
            if(rd_en) 
                rd_dout[DW-1:0] <= ram[rd_addr[AW-1:0]]; 
        always @(posedge wr_clk) 
            for (i=0; i<DW; i=i+1) 
                if (wr_en & wr_wem[i]) 
                    ram[wr_addr[AW-1:0]][i] <= wr_din[i]; 
    end 
endgenerate
endmodule 