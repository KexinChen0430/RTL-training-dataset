module ram_sync_nolatch_2r1w #(
    parameter BRAM_ADDR_WIDTH = `ADDR_LEN,      
    parameter BRAM_DATA_WIDTH = `DATA_LEN,      
    parameter DATA_DEPTH      = 32              
)
(
    input wire clk,                            
    input wire [BRAM_ADDR_WIDTH-1:0] raddr1,   
    input wire [BRAM_ADDR_WIDTH-1:0] raddr2,   
    output wire [BRAM_DATA_WIDTH-1:0] rdata1,  
    output wire [BRAM_DATA_WIDTH-1:0] rdata2,  
    input wire [BRAM_ADDR_WIDTH-1:0] waddr,    
    input wire [BRAM_DATA_WIDTH-1:0] wdata,    
    input wire we                              
);
    reg [BRAM_DATA_WIDTH-1:0] mem [0:DATA_DEPTH-1];
    integer i;
    assign rdata1 = mem[raddr1];  
    assign rdata2 = mem[raddr2];  
    always @ (posedge clk) begin
        if (we)
            mem[waddr] <= wdata;  
    end
endmodule