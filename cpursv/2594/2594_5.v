
module SmallBpf  #(parameter 
       WIDTH    = 16,
       K0_SHIFT = 10,
       K1_SHIFT = 18,
       CLAMP    = 1)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [(-1)+WIDTH:0] dataIn,
   output signed  [(-1)+WIDTH:0] dataOut);

  reg  signed  [K0_SHIFT+((-1)+WIDTH):0] acc0;
  reg  signed  [(-1)+(K1_SHIFT+WIDTH):0] acc1;
  reg  signed  [WIDTH+1:0] forwardIn;
  wire signed  [(-1)+WIDTH:0] feedbackOut;
  wire signed  [WIDTH+K0_SHIFT:0] acc0In;
  wire signed  [K1_SHIFT+WIDTH:0] acc1In;

  assign acc0In = forwardIn+acc0;
  assign acc1In = dataOut+acc1;
  
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
            forwardIn <= (-dataOut)+(dataIn+(0-feedbackOut));
            if (CLAMP) 
              begin
                acc0 <= ^acc0In[WIDTH+K0_SHIFT -: 2] ? {acc0In[WIDTH+K0_SHIFT],{K0_SHIFT+((-1)+WIDTH){acc0In[K0_SHIFT+((-1)+WIDTH)]}}} : acc0In;
                acc1 <= ^acc1In[K1_SHIFT+WIDTH -: 2] ? {acc1In[K1_SHIFT+WIDTH],{(-1)+(K1_SHIFT+WIDTH){acc1In[(-1)+(K1_SHIFT+WIDTH)]}}} : acc1In;
              end
            else 
              begin
                acc0 <= acc0In;
                acc1 <= acc1In;
              end
          end
          
      end
  assign dataOut = acc0>>>K0_SHIFT;
  assign feedbackOut = acc1>>>K1_SHIFT;
endmodule

