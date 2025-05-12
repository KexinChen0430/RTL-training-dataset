
module reset(input  clk_i,
             output nreset_o);

  reg  [3:0]  reset_counter = 4'b1111;

  assign nreset_o = reset_counter == 1'b0;
  
  always @(posedge clk_i)
      begin
        if (reset_counter > 1'b0) reset_counter = (0-1'b1)+reset_counter;
          
      end
endmodule

