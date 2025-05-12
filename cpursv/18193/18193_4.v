
module uart_transmitter  #(parameter  CLK_CYCLES = 4167, CTR_WIDTH = 16)
  (input  wire clk,
   input  wire [7:0] data,
   input  wire req,
   output wire ready,
   output wire uart_tx);

  reg  [CTR_WIDTH-1:0] ctr;
  reg  [9:0]  line_data = 10'b1111111111;
  reg  [4:0] bits_left;

  
  initial  
  begin
    ctr = 0;
    bits_left = 0;
  end
   ;
  assign uart_tx = line_data[0];
  assign ready = bits_left == 0;
  
  always @(posedge clk)
      begin
        ctr <= ctr+1'b1;
        if (ctr == (CLK_CYCLES+(-1))) 
          begin
            ctr <= 0;
            line_data <= {1'b1,line_data[9:1]};
            if (bits_left != 0) bits_left <= bits_left-1'b1;
              
          end
          
        if (ready && req) 
          begin
            line_data <= {1'b1,data,1'b0};
            ctr <= 0;
            bits_left <= 4'd10;
          end
          
      end
endmodule

