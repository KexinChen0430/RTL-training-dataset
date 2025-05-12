module outputs 
  assign Product = S_reg; 
  assign Ovfl = Ovfl_reg; 
  always @ (posedge clock) 
    begin
      if (!reset) 
        begin
        S_reg = result; 
        Ovfl_reg = overflow; 
        end
      else 
        begin
        S_reg = 32'b0; 
        Ovfl_reg = 1'b0; 
        end
    end
endmodule 