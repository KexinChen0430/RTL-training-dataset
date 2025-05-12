
module quadrature_clocked(clk,reset,quadA,quadB,count);

  input  clk,reset,quadA,quadB;
  output [7:0] count;
  reg  [1+1:0] quadA_delayed;
  reg  [1+1:0] quadB_delayed;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            quadA_delayed <= 0;
          end
        else 
          begin
            quadA_delayed <= {quadA_delayed[1:0],quadA};
          end
      end
  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            quadB_delayed <= 0;
          end
        else 
          begin
            quadB_delayed <= {quadB_delayed[1:0],quadB};
          end
      end
  wire 
       count_enable = (~(((quadB_delayed[1] & (((quadA_delayed[1] & ~quadB_delayed[1]) | ~(((quadA_delayed[1+1] & ~quadA_delayed[1+1]) | (~quadA_delayed[1] & quadA_delayed[1+1])) | (quadA_delayed[1] & ~quadA_delayed[1+1]))) & (~(quadA_delayed[1+1] & ~quadB_delayed[1]) | ~(((quadA_delayed[1+1] & ~quadA_delayed[1+1]) | (~quadA_delayed[1] & quadA_delayed[1+1])) | (quadA_delayed[1] & ~quadA_delayed[1+1]))))) | (quadB_delayed[1] & (~(quadA_delayed[1] & ~quadB_delayed[1]) & (quadA_delayed[1+1] & ~quadB_delayed[1])))) | ((~quadB_delayed[1] & ((quadA_delayed[1] & ~quadB_delayed[1]) & ~quadA_delayed[1+1])) | (~quadB_delayed[1] & (~quadA_delayed[1] & quadA_delayed[1+1])))) | ~quadB_delayed[1+1]) & ((~(((quadA_delayed[1+1] & ~quadA_delayed[1+1]) | (~quadA_delayed[1] & quadA_delayed[1+1])) | (quadA_delayed[1] & ~quadA_delayed[1+1])) & (quadB_delayed[1] & ~quadB_delayed[1+1])) | ((~quadB_delayed[1+1] & ((~quadB_delayed[1] & ((quadA_delayed[1] & ~quadB_delayed[1]) & ~quadA_delayed[1+1])) | (~quadB_delayed[1] & (~quadA_delayed[1] & quadA_delayed[1+1])))) | quadB_delayed[1+1]));

  wire 
       count_direction = (~quadB_delayed[1+1] & quadA_delayed[1]) | ((quadB_delayed[1+1] & ~quadB_delayed[1+1]) | ((((quadA_delayed[1] | quadB_delayed[1+1]) & (quadA_delayed[1] | ~quadA_delayed[1])) & ~quadA_delayed[1]) & quadB_delayed[1+1]));

  reg  [31:0] total;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            total <= 0;
          end
        else if (count_enable) 
          begin
            if (count_direction) total <= total+1;
            else total <= (0-1)+total;
          end
          
      end
  wire [31:0] clicks;

  assign clicks = total>>1+1;
  assign count = clicks[7:0];
endmodule

