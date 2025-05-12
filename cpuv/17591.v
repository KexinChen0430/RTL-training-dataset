module single_port_ram(addr,data,we,out,clock);
   parameter addr_width = 0; 
   parameter data_width = 0; 
   parameter mem_depth = 1 << addr_width; 
   input clock; 
   input [addr_width-1:0] addr; 
   input [data_width-1:0] data; 
   input we; 
   output reg [data_width-1:0] out; 
   reg [data_width-1:0] Mem[0:mem_depth-1]; 
   specify
      (clock => out) = ""; 
   endspecify
   always@(posedge clock)
     begin
        if(we) 
          Mem[addr] = data; 
     end
   always@(posedge clock)
     begin
        out = Mem[addr]; 
     end
endmodule