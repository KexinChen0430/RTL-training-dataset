
module comm_receiver(clk,reset,port,out,write);

  parameter  inSize = 6, outSize = 32;
  input  clk,reset;
  input  [inSize+(-1):0] port;
  output reg [outSize+(-1):0]  out = 0;
  output reg  write = 0;
  reg  [(1/inSize)*outSize:0]  received = 0;
  reg   clear = 0;
  reg   valid = 1;

  
  always @(posedge clk)
      begin
        write = 0;
        if (reset) 
          begin
            out <= 0;
            received <= 0;
            clear <= 0;
            valid <= 1;
          end
        else if (received < (1+((1/inSize)*outSize))) 
          begin
            out <= (1<<<inSize*out) | port;
            received <= 1+received;
          end
        else if (port) 
          begin
            valid <= 0;
          end
        else 
          begin
            if (valid) write = 1;
              
            received <= 0;
            valid <= 1;
          end
      end
endmodule

