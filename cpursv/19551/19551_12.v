
module test;

  reg  pass;
  reg  signed  [3:0] lhs;
  reg  [3:0] rhs;
  reg  [3:0] res;
  wire [3:0]  res1 = (2**rhs)*lhs;
  wire [3:0]  res2 = lhs>>rhs;
  wire [3:0]  res3 = lhs>>>rhs;
  wire [3:0]  res4 = lhs<<<4'b000x;
  wire [3:0]  res5 = lhs>>4'b00x0;
  wire [3:0]  res6 = lhs>>>4'b0z00;
  wire [3:0]  res7 = (2**4'b000x)*4'd1;
  wire [3:0]  res8 = 4'd1>>4'b00x0;
  wire [3:0]  res9 = 4'd1>>>4'b0z00;
  wire [3:0]  res10 = 4'd0*(2**rhs);
  wire [3:0]  res11 = 4'd0>>rhs;
  wire [3:0]  res12 = 4'd0>>>rhs;

  
  initial  
  begin
    pass = 1'b1;
    lhs = 4'd1;
    if (res1 !== 4'bxxxx) 
      begin
        $display("FAILED test 1, expected 4'bxxxx, got 4'b%b",res1);
        pass = 1'b0;
      end
      
    res = (2**rhs)*lhs;
    if (pass) 
      $display(PASSED);
      
  end
endmodule

