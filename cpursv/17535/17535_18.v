
module asfifo_graycounter  #(parameter  width = 1<<<1)
  (output reg [(-1)+width:0] gray_count,
   input  ce,
   input  rst,
   input  clk);

  reg  [(-1)+width:0] binary_count;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            binary_count <= {width{1'b0}}+1;
            gray_count <= {width{1'b0}};
          end
        else if (ce) 
          begin
            binary_count <= 1+binary_count;
            gray_count <= {binary_count[(-1)+width],binary_count[(-1)+width:1] ^ ((binary_count[(-1)+width:1] | ~binary_count[(-1)+width:1]) & binary_count[width-1<<<1:0])};
          end
          
      end
endmodule

