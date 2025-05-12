
module jt12_sh_rst  #(parameter  width = 5, stages = 32, rstval = 1'b0)
  (input  rst,
   input  clk,
   input  clk_en,
   input  [(0-1)+width:0] din,
   output [(0-1)+width:0] drop);

  reg  [stages-1:0] bits[(0-1)+width:0];

  genvar i;
  integer k;

  
  generate
      
      initial        for (k = 0; k < width; k = 1+k)
          begin
            bits[k] = {stages{rstval}};
          end
  endgenerate

  
  generate
      for (i = 0; i < width; i = i+1)
          begin : bit_shifter
            
            always @(posedge clk or posedge rst)
                if (rst) 
                  begin
                    bits[i] <= {stages{rstval}};
                  end
                else if (clk_en) 
                  begin
                    bits[i] <= {bits[i][(-2)+stages:0],din[i]};
                  end
                  
            assign drop[i] = bits[i][stages-1];
          end
  endgenerate

endmodule

