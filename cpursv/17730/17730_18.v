
module integrate  #(parameter  INPUTW = 16, ACCUMW = 32, OUTPUTW = 16)
  (input  clk_i,
   input  rst_i,
   input  ena_i,
   input  dump_i,
   input  [INPUTW+(0-1):0] data_i,
   output reg stb_o,
   output reg [OUTPUTW+(0-1):0] integ_o);

  wire [(0-1)+ACCUMW:0] 
       data_ext = {{ACCUMW-INPUTW{data_i[INPUTW+(0-1)]}},data_i};
  reg  [(0-1)+ACCUMW:0] accum;

  
  always @(posedge clk_i)
      if (~ena_i | rst_i) 
        begin
          accum <= 0;
          integ_o <= 0;
        end
      else if (dump_i) 
        begin
          integ_o <= accum[(0-1)+ACCUMW:ACCUMW+(0-OUTPUTW)];
          accum <= data_ext;
        end
      else accum <= accum+data_ext;
  
  always @(posedge clk_i)  stb_o <= dump_i;
endmodule

