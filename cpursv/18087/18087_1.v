
module alpha(clk,toggle);

  input  clk;
  input  toggle;

  
  always @(posedge clk)
      begin
        if (toggle) 
          begin
            $write("");
          end
          
        if (toggle) 
          begin
            $write("");
          end
          
      end
endmodule

