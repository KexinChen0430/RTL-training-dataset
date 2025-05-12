
module RegisterTest;

  Register32 r1(Bus_out,clk,reset,r_in,r_out,Bus_in);
  reg  [31:0] Bus_in;

  reg  clk,reset,r_in,r_out;

  output [31:0] Bus_out;

  
  initial  
  begin
    $display("\t\t      %5s | %5s | %5s |----| %5s | %5s |",RESET,
             RIN,ROUT,BUSIN,BOUT);
    $monitor($time,": %5d | %5d | %5d |----| %5d | %5d |",reset,r_in,
             r_out,Bus_in,Bus_out);
    reset = 1;
    clk = 1;
    #10 r_in = 0; r_out = 0; Bus_in = 32'd21; reset = 0;
    #10 r_in = 1; r_out = 0; Bus_in = 32'd21;
    #10 r_in = 0; r_out = 1; Bus_in = 32'd21;
    #10 r_in = 1; r_out = 1; Bus_in = 32'd9; $finish;
  end
  
  always 
      begin : CLOCKGEN
        #5 clk = ~clk;
      end
endmodule

