
module SmallLpf2nd  #(parameter  K0_SHIFT = 8, K1_SHIFT = 8, WIDTH = 16, CLAMP = 1)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [(0-1)+WIDTH:0] dataIn,
   output signed  [(0-1)+WIDTH:0] dataOut);

  reg  signed  [K0_SHIFT+((0-1)+WIDTH):0] acc0;
  reg  signed  [(0-1)+(WIDTH+K1_SHIFT):0] acc1;
  reg  signed  [1+WIDTH:0] forwardIn;
  wire signed  [(0-1)+WIDTH:0] acc0Out;
  wire signed  [WIDTH+K0_SHIFT:0] acc0In;
  wire signed  [WIDTH+K1_SHIFT:0] acc1In;

  assign acc0In = forwardIn+acc0;
  assign acc1In = acc1+acc0Out;
  
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
            forwardIn <= (-acc0Out)+(dataIn+(-dataOut));
            if (CLAMP) 
              begin
                acc0 <= ^acc0In[WIDTH+K0_SHIFT -: 2] ? {acc0In[WIDTH+K0_SHIFT],{K0_SHIFT+((0-1)+WIDTH){acc0In[K0_SHIFT+((0-1)+WIDTH)]}}} : acc0In;
                acc1 <= ^acc1In[WIDTH+K1_SHIFT -: 2] ? {acc1In[WIDTH+K1_SHIFT],{(0-1)+(WIDTH+K1_SHIFT){acc1In[(0-1)+(WIDTH+K1_SHIFT)]}}} : acc1In;
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

