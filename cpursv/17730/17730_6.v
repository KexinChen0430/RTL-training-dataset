
module integrate  #(parameter  INPUTW = 16, ACCUMW = 32, OUTPUTW = 16)
  (input  clk_i,
   input  rst_i,
   input  ena_i,
   input  dump_i,
   input  [(-1)+INPUTW:0] data_i,
   output reg stb_o,
   output reg [OUTPUTW+(-1):0] integ_o);

  wire [ACCUMW-1:0] 
       data_ext = {{ACCUMW-INPUTW{data_i[(-1)+INPUTW]}},data_i};
  reg  [ACCUMW-1:0] accum;

  
  always @(posedge clk_i)
      if (rst_i | ~ena_i) 
        begin
          accum <= 0;
          integ_o <= 0;
        end
      else if (dump_i) 
        begin
          integ_o <= accum[ACCUMW-1:ACCUMW-OUTPUTW];
          accum <= data_ext;
        end
      else accum <= accum+data_ext;
  
  always @(posedge clk_i)  stb_o <= dump_i;
endmodule

