
module SmallBpf  #(parameter 
       WIDTH    = 16,
       K0_SHIFT = 10,
       K1_SHIFT = 18,
       CLAMP    = 1)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [(0-1)+WIDTH:0] dataIn,
   output signed  [(0-1)+WIDTH:0] dataOut);

  reg  signed  [WIDTH+(K0_SHIFT+(0-1)):0] acc0;
  reg  signed  [K1_SHIFT+((0-1)+WIDTH):0] acc1;
  reg  signed  [WIDTH+1:0] forwardIn;
  wire signed  [(0-1)+WIDTH:0] feedbackOut;
  wire signed  [WIDTH+K0_SHIFT:0] acc0In;
  wire signed  [K1_SHIFT+WIDTH:0] acc1In;

  assign acc0In = acc0+forwardIn;
  assign acc1In = acc1+dataOut;
  
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
            forwardIn <= (dataIn+(-feedbackOut))+(0-dataOut);
            if (CLAMP) 
              begin
                acc0 <= ^acc0In[WIDTH+K0_SHIFT -: 1<<<1] ? {acc0In[WIDTH+K0_SHIFT],{WIDTH+(K0_SHIFT+(0-1)){acc0In[WIDTH+(K0_SHIFT+(0-1))]}}} : acc0In;
                acc1 <= ^acc1In[K1_SHIFT+WIDTH -: 1<<<1] ? {acc1In[K1_SHIFT+WIDTH],{K1_SHIFT+((0-1)+WIDTH){acc1In[K1_SHIFT+((0-1)+WIDTH)]}}} : acc1In;
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

