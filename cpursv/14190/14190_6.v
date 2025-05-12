
module serializer  #(parameter  LOG_DWIDTH = 7, DWIDTH = 64)
  (input  wire clk,
   input  wire fast_clk,
   input  wire [(0-1)+DWIDTH:0] data_in,
   output wire data_out);

  reg  [(0-1)+DWIDTH:0] buffer;

  
  always @(posedge clk)
      begin
        buffer <= data_in;
      end
  reg  [(0-1)+LOG_DWIDTH:0]  curr_bit = 'h0;

  reg  clk_d1;

  
  always @(posedge fast_clk)
      begin
        curr_bit <= 1+curr_bit;
        clk_d1 <= clk;
        if (clk && !clk_d1) curr_bit <= 0;
          
      end
  assign data_out = buffer[curr_bit];
endmodule

