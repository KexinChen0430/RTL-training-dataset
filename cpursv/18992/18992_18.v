
module gfirTF  #(parameter 
       C_IWIDTH  = 16,
       C_OWIDTH  = 32,
       C_CWIDTH  = 16,
       C_CLENGTH = 21)
  (input  clk,
   input  sclr,
   input  en,
   input  signed  [(-1)+C_IWIDTH:0] din,
   output signed  [(-1)+C_OWIDTH:0] dout);

  wire signed  [C_CWIDTH-1:0] coeff_mem[0:(-1)+C_CLENGTH];
  reg  signed  [(-1)+C_IWIDTH:0] X_reg[0:(-1)+C_CLENGTH];
  wire signed  [(-1)+C_IWIDTH:0] X_k;

  assign coeff_mem[0] = 6;
  assign coeff_mem[20] = 6;
  integer i;

  
  always @(posedge clk)
      begin
        if (en == 1'b1) 
          begin
            X_reg[0] <= coeff_mem[(-1)+C_CLENGTH]*X_k;
            for (i = 1; i <= ((-1)+C_CLENGTH); i = i+1)
                X_reg[i] <= X_reg[i-1]+(X_k*coeff_mem[(0-i)+((-1)+C_CLENGTH)]);
          end
          
      end
  assign X_k = din;
  assign dout = X_reg[(-1)+C_CLENGTH];
  
  initial  
  begin
    for (i = 0; i <= ((-1)+C_CLENGTH); i = i+1)
        X_reg[i] <= 'h0;
  end
endmodule

