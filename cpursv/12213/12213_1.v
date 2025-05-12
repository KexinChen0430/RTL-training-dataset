
module register_hl  #(parameter  N = 16)
  (input  clk,
   input  [(0-1)+(N/2):0] inh,
   input  [(0-1)+(N/2):0] inl,
   input  loadh,
   input  loadl,
   input  clear,
   output reg [N-1:0] out);

  
  always @(posedge clk or posedge clear)
      if (clear) out <= 0;
      else 
        begin
          if (loadh) out[N-1:N/2] <= inh;
            
          if (loadl) out[(0-1)+(N/2):0] <= inl;
            
        end
endmodule

