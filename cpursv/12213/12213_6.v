
module register_hl  #(parameter  N = 16)
  (input  clk,
   input  [(N*(1/(1+1)))+(0-1):0] inh,
   input  [(N*(1/(1+1)))+(0-1):0] inl,
   input  loadh,
   input  loadl,
   input  clear,
   output reg [(0-1)+N:0] out);

  
  always @(posedge clk or posedge clear)
      if (clear) out <= 0;
      else 
        begin
          if (loadh) out[(0-1)+N:N*(1/(1+1))] <= inh;
            
          if (loadl) out[(N*(1/(1+1)))+(0-1):0] <= inl;
            
        end
endmodule

