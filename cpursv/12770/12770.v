
module altgxb_hssi_divide_by_two(reset,clkin,clkout);

  parameter  divide = "ON";
  input  reset;
  input  clkin;
  output clkout;
  reg  clktmp;
  tri0 reset;

  
  initial  
  begin
    clktmp = 1'b0;
  end
  
  always @(clkin or posedge reset)
      begin
        if (divide == "OFF") clktmp <= clkin;
        else if (reset === 1'b1) clktmp <= 1'b0;
        else if (clkin == 1'b1) clktmp <= ~clktmp;
          
      end
  assign clkout = clktmp;
endmodule

