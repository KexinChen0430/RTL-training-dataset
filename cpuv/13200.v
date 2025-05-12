module infer_selectram #(parameter 
`endif
	d_width=32, 
	addr_width=5, 
	initialized=-1 
) (
   output [d_width - 1:0]   o, 
   input                    we, 
   input                    clk, 
   input [d_width - 1:0]    d, 
   input [addr_width - 1:0] raddr, 
   input [addr_width - 1:0] waddr 
   );
`ifdef ALTERA 
   (* ramstyle = "MLAB" *) reg [d_width - 1:0]  mem [(1 << addr_width) - 1:0]; 
`else 
   (* ram_style = "distributed" *) reg [d_width - 1:0]  mem [(1 << addr_width) - 1:0] ; 
`endif
   always @(posedge clk) 
     if (we) 
       mem[waddr] <= d; 
   assign o = mem[raddr]; 
integer clear_addr; 
initial begin 
	for (clear_addr=0;clear_addr< (1 << addr_width);clear_addr=clear_addr+1) begin 
		case (initialized) 
			 0: mem[clear_addr] = 'b0; 
			 1: mem[clear_addr] = -1; 
			 2: mem[clear_addr] = $random; 
		endcase
	end
end
endmodule 