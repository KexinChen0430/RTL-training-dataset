
module jt12_sh_rst  #(parameter  width = 5, stages = 32, rstval = 1'b0)
  (input  rst,
   input  clk,
   input  clk_en,
   input  [(0-1)+width:0] din,
   output [(0-1)+width:0] drop);

  reg  [stages+(0-1):0] bits[(0-1)+width:0];

  genvar i;
  integer k;

  
  generate
      
      initial        for (k = 0; k < width; k = k+1)
          begin
            bits[k] = {stages{rstval}};
          end
  endgenerate

  
  generate
      for (i = 0; i < width; i = 1+i)
          begin : bit_shifter
            
            always @(posedge clk or posedge rst)
                if (rst) 
                  begin
                    bits[i] <= {stages{rstval}};
                  end
                else if (clk_en) 
                  begin
                    bits[i] <= {bits[i][(-1<<<1)+stages:0],din[i]};
                  end
                  
            assign drop[i] = bits[i][stages+(0-1)];
          end
  endgenerate

endmodule

