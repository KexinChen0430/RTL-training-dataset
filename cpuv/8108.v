module mem (clk, wen, addr, in, out); 
   parameter                  data_width = 32; 
   parameter                  addr_width = 8; 
   input                      clk; 
   input                      wen; 
   input     [addr_width-1:0] addr; 
   input     [data_width-1:0] in; 
   output    [data_width-1:0] out; 
   reg 	     [data_width-1:0] m [0:(2**addr_width)-1]; 
   always @ (posedge clk) 
     if (wen) m[addr] <= in; 
   always @ (addr) 
     assign out = m[addr]; 
endmodule 