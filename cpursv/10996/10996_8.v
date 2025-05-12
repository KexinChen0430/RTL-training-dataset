
module serializer  #(parameter  DWIDTH = 64)
  (input  wire clk,
   input  wire fast_clk,
   input  wire res_n,
   input  wire [(0-1)+DWIDTH:0] data_in,
   output wire data_out);

  reg  [7:0]  curr_bit = 'h0;

  
  always @(posedge fast_clk)
      begin
        if (!res_n) 
          begin
            curr_bit <= 0;
          end
        else 
          begin
            if (curr_bit == ((0-1)+DWIDTH)) curr_bit <= 0;
            else curr_bit <= curr_bit+1;
          end
      end
  assign data_out = data_in[curr_bit];
endmodule

