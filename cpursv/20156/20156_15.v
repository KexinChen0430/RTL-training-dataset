
module SmallLpf2nd  #(parameter  K0_SHIFT = 8, K1_SHIFT = 8, WIDTH = 16, CLAMP = 1)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [WIDTH-1:0] dataIn,
   output signed  [WIDTH-1:0] dataOut);

  reg  signed  [K0_SHIFT+(WIDTH-1):0] acc0;
  reg  signed  [(WIDTH-1)+K1_SHIFT:0] acc1;
  reg  signed  [WIDTH+1:0] forwardIn;
  wire signed  [WIDTH-1:0] acc0Out;
  wire signed  [K0_SHIFT+WIDTH:0] acc0In;
  wire signed  [WIDTH+K1_SHIFT:0] acc1In;

  assign acc0In = acc0+forwardIn;
  assign acc1In = acc0Out+acc1;
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            forwardIn <= 'd0;
            acc0 <= 'd0;
            acc1 <= 'd0;
          end
        else if (en) 
          begin
            forwardIn <= ((-dataOut)+(0-acc0Out))+dataIn;
            if (CLAMP) 
              begin
                acc0 <= ^acc0In[K0_SHIFT+WIDTH -: 2] ? {acc0In[K0_SHIFT+WIDTH],{K0_SHIFT+(WIDTH-1){acc0In[K0_SHIFT+(WIDTH-1)]}}} : acc0In;
                acc1 <= ^acc1In[WIDTH+K1_SHIFT -: 2] ? {acc1In[WIDTH+K1_SHIFT],{(WIDTH-1)+K1_SHIFT{acc1In[(WIDTH-1)+K1_SHIFT]}}} : acc1In;
              end
            else 
              begin
                acc0 <= acc0In;
                acc1 <= acc1In;
              end
          end
          
      end
  assign acc0Out = acc0>>>K0_SHIFT;
  assign dataOut = acc1>>>K1_SHIFT;
endmodule

