module fabric2_decoder #(
	parameter PORTNO_WIDTH = 11 
)
(
	i_addr,    
	o_addr,    
	o_portno   
);
localparam PORT_BITS = PORTNO_WIDTH + 1;
input wire [`ADDR_WIDTH-1:0]		i_addr;      
output wire [`ADDR_WIDTH-1:0]		o_addr;      
output wire [PORTNO_WIDTH-1:0]		o_portno;    
assign o_addr = (!i_addr[`ADDR_WIDTH-1] ? 
		{ 1'b0, i_addr[`ADDR_WIDTH-2:0] } : 
		{ {(PORT_BITS){1'b0}}, i_addr[`ADDR_WIDTH-PORT_BITS-1:0] }); 
assign o_portno = (i_addr[`ADDR_WIDTH-1] ? 
		i_addr[`ADDR_WIDTH-2:`ADDR_WIDTH-PORT_BITS] + 1'b1 : 
		{(PORT_BITS-1){1'b0}}); 
endmodule