module dual_port_ram(addr1, addr2, data1, data2, we1, we2, out1, out2, clock);
   parameter addr1_width = 0; 
   parameter data1_width = 0; 
   parameter addr2_width = 0; 
   parameter data2_width = 0; 
   parameter mem_depth1 = 1 << addr1_width; 
   parameter mem_depth2 = 1 << addr2_width; 
   input clock; 
   input [addr1_width-1:0] addr1; 
   input [data1_width-1:0] data1; 
   input we1; 
   output reg [data1_width-1:0] out1; 
   input [addr2_width-1:0] addr2; 
   input [data2_width-1:0] data2; 
   input we2; 
   output reg [data2_width-1:0] out2; 
   reg [data1_width-1:0] Mem1[0:mem_depth1-1]; 
   reg [data2_width-1:0] Mem2[0:mem_depth2-1]; 
   specify
       (clock => out1) = ""; 
       (clock => out2) = ""; 
   endspecify
   always @(posedge clock)
     begin
        if (we1) 
          Mem1[addr1] = data1; 
     end
   always @(posedge clock)
      begin
        if (we2) 
          Mem2[addr2] = data2; 
     end
   always @(posedge clock)
     begin
        out1 = Mem1[addr1]; 
     end
   always @(posedge clock)
     begin
        out2 = Mem2[addr2]; 
     end
endmodule