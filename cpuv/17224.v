module altor32_ram_sp 
#(
    parameter  [31:0]       WIDTH = 8, 
    parameter  [31:0]       SIZE = 14  
)
(
    input                   clk_i, 
    output [(WIDTH - 1):0]  dat_o, 
    input [(WIDTH - 1):0]   dat_i, 
    input [(SIZE - 1):0]    adr_i, 
    input                   wr_i   
);
reg [(WIDTH - 1):0]     ram [((2<< (SIZE-1)) - 1):0]; 
reg [(SIZE - 1):0]      rd_addr_q; 
always @ (posedge clk_i) 
begin
    if (wr_i == 1'b1) 
        ram[adr_i] <= dat_i; 
    rd_addr_q <= adr_i; 
end
assign dat_o = ram[rd_addr_q]; 
`ifdef ALTOR32_CLEAR_RAM 
    integer i;
    initial
    begin
        for (i=0;i<((2<< (SIZE-1)) - 1);i=i+1) 
        begin
            ram[i] = 0; 
        end
    end
`endif
endmodule