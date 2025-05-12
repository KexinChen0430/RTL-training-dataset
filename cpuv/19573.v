module test;
integer I0,I1;
reg [15:0] R0,R1;
reg [3:0] error;
initial
  begin
    R0 = -4'd12;
    R1 = -16'd12;
    error = 0;
    if(R0 !== 16'hfff4)
      begin
         $display("FAILED - negative decimal assignment failed. R0 s/b fff4, is %h",
                R0);
         error = 1;
      end
    if(R1 !== 16'hfff4)
      begin
         $display("FAILED - negative decimal assignment failed. R1 s/b fff4, is %h",
                R1);
         error = 1;
      end
    if(error === 0)
      $display("PASSED");
  end
endmodule