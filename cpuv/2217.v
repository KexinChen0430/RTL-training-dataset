module IndexRegister(
   input         clock,    
   input         write,    
   input         reset,    
   input [15:0]  address,  
   input [15:0]  writeData,
   output [15:0] data);    
   reg [15:0]    index [0:65535];
   integer       i;        
   initial begin
      for (i = 0; i < 65536; i = i + 1)
        index[i] = 16'b0;  
   end
   always @ (posedge clock) begin
      if (reset) begin
        for (i = 0; i < 65536; i = i + 1)
          index[i] = 16'b0; 
      end else if (write) begin
        index[address] = writeData;
      end
   end
   assign data = index[address];
endmodule