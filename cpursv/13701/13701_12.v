
module SmallBsf  #(parameter 
       WIDTH    = 16,
       K0_SHIFT = 10,
       K1_SHIFT = 18,
       CLAMP    = 1)
  (input  clk,
   input  rst,
   input  en,
   input  signed  [(0-1)+WIDTH:0] dataIn,
   output signed  [(0-1)+WIDTH:0] dataOut);

  reg  signed  [(K0_SHIFT+WIDTH)-1:0] acc0;
  reg  signed  [(K1_SHIFT+WIDTH)-1:0] acc1;
  reg  signed  [(0-1)+WIDTH:0] forwardPath;
  wire signed  [(0-1)+WIDTH:0] acc0Out;
  wire signed  [(0-1)+WIDTH:0] acc1Out;
  wire signed  [K0_SHIFT+WIDTH:0] acc0In;
  wire signed  [K1_SHIFT+WIDTH:0] acc1In;

  assign acc0In = (-acc1Out)+(acc0+forwardPath);
  assign acc1In = acc1+acc0Out;
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            forwardPath <= 'd0;
            acc0 <= 'd0;
            acc1 <= 'd0;
          end
        else if (en) 
          begin
            forwardPath <= (0-acc0Out)+dataIn;
            if (CLAMP) 
              begin
                acc0 <= ^acc0In[K0_SHIFT+WIDTH -: 1<<<1] ? {acc0In[K0_SHIFT+WIDTH],{(K0_SHIFT+WIDTH)-1{acc0In[(K0_SHIFT+WIDTH)-1]}}} : acc0In;
                acc1 <= ^acc1In[K1_SHIFT+WIDTH -: 1<<<1] ? {acc1In[K1_SHIFT+WIDTH],{(K1_SHIFT+WIDTH)-1{acc1In[(K1_SHIFT+WIDTH)-1]}}} : acc1In;
              end
            else 
              begin
                acc0 <= acc0In;
                acc1 <= acc1In;
              end
          end
          
      end
  assign dataOut = forwardPath;
  assign acc0Out = acc0>>>K0_SHIFT;
  assign acc1Out = acc1>>>K1_SHIFT;
  reg  clamp0;

  reg  clamp1;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            clamp0 <= 1'b0;
            clamp1 <= 1'b0;
          end
        else 
          begin
            clamp0 <= clamp0 | ^acc0In[K0_SHIFT+WIDTH -: 1<<<1];
            clamp1 <= ^acc1In[K1_SHIFT+WIDTH -: 1<<<1] | clamp1;
          end
      end
endmodule

