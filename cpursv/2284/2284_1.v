
module BaseRegister(input  clock,
                    input  write,
                    input  reset,
                    input  [15:0] address,
                    input  [15:0] writeData,
                    output [15:0] data);

  reg  [15:0] base[0:65535];
  integer i;

  
  initial  
  begin
    for (i = 0; i < 65536; i = i+1)
        base[i] = 16'b0;
  end
  
  always @(posedge clock)
      begin
        if (reset) 
          for (i = 0; i < 65536; i = i+1)
              base[i] = 16'b0;
        else if (write) base[address] = writeData;
          
      end
  assign data = base[address];
endmodule

