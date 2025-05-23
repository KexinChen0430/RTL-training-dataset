module mmc3_eth_core(
    input wire RESET_N,                
    input wire BUS_CLK,                
    input wire CLK125TX,               
    input wire CLK125TX90,             
    input wire CLK125RX,               
    input wire PLL_LOCKED,             
    input wire          BUS_RST,       
    input wire  [31:0]  BUS_ADD,       
    inout wire  [31:0]  BUS_DATA,      
    input wire          BUS_RD,        
    input wire          BUS_WR,        
    output wire         BUS_BYTE_ACCESS,
    input wire          fifo_empty,    
    input wire          fifo_full,     
    input wire          FIFO_NEXT,     
    output wire         FIFO_WRITE,    
    output wire [31:0]  FIFO_DATA,     
    output wire [7:0]   GPIO           
);
localparam GPIO_BASEADDR = 32'h1000;
localparam GPIO_HIGHADDR = 32'h101f;
gpio #(
    .BASEADDR(GPIO_BASEADDR),
    .HIGHADDR(GPIO_HIGHADDR),
    .ABUSWIDTH(32),
    .IO_WIDTH(8),
    .IO_DIRECTION(8'hff)
) i_gpio_rx (
    .BUS_CLK(BUS_CLK),
    .BUS_RST(BUS_RST),
    .BUS_ADD(BUS_ADD),
    .BUS_DATA(BUS_DATA[7:0]), 
    .BUS_RD(BUS_RD),
    .BUS_WR(BUS_WR),
    .IO(GPIO)                 
);
reg [31:0] datasource;        
reg fifo_write;               
assign FIFO_WRITE = fifo_write; 
reg [31:0] fifo_data_out;     
assign FIFO_DATA = fifo_data_out; 
always@ (posedge BUS_CLK)
    begin
    if(FIFO_NEXT) begin 
        if(!fifo_full) begin 
            fifo_data_out <= datasource; 
            datasource <= datasource + 1; 
            fifo_write <= 1'b1; 
        end
        else
            fifo_write <= 1'b0; 
    end
    else begin 
        datasource <= 'd0; 
        fifo_write <= 1'b0; 
    end
end
endmodule