
module SmallBpf  #(parameter 
       WIDTH    = 16,
       K0_SHIFT = 10,
       K1_SHIFT = 18,
       CLAMP    = 1)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [WIDTH-1:0] dataIn,
   output signed  [WIDTH-1:0] dataOut);

  reg  signed  [(K0_SHIFT+WIDTH)+(-1):0] acc0;
  reg  signed  [K1_SHIFT+(WIDTH-1):0] acc1;
  reg  signed  [1+WIDTH:0] forwardIn;
  wire signed  [WIDTH-1:0] feedbackOut;
  wire signed  [K0_SHIFT+WIDTH:0] acc0In;
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
            forwardIn <= ((-dataOut)+dataIn)-feedbackOut;
            if (CLAMP) 
              begin
                acc0 <= ^acc0In[K0_SHIFT+WIDTH -: 1+1] ? {acc0In[K0_SHIFT+WIDTH],{(K0_SHIFT+WIDTH)+(-1){acc0In[(K0_SHIFT+WIDTH)+(-1)]}}} : acc0In;
                acc1 <= ^acc1In[K1_SHIFT+WIDTH -: 1+1] ? {acc1In[K1_SHIFT+WIDTH],{K1_SHIFT+(WIDTH-1){acc1In[K1_SHIFT+(WIDTH-1)]}}} : acc1In;
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

