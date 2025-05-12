module some_module (
    input [3:0] i_clks 
);
   logic [1:0] some_state;
   logic [1:0] some_other_state;
   logic the_clk;
   assign the_clk = i_clks[3];
   always @(posedge the_clk) begin
      case (some_state)
        2'b11: 
          if (some_other_state == 0)
            some_state <= 2'b00;
        default: 
          $display ("This is a display statement");
      endcase
      if (the_clk)
        some_other_state <= 0;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule