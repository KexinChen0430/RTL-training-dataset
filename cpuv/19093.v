module main ;
reg [3:0] a,b;
reg c;
reg error;
always @(c or b)
   a[b] = c;
initial
  begin
    #1 ;
    a = 4'b1111;
    error = 0;
    b = 1'b0;
    c = 1'b0;
    #1 ;
    if(a != 4'b1110)
      begin
        $display("FAILED - var index -  a = %b, [b] = %d, c=%b",a,b,c);
        error = 1;
      end
    #1 ;
    b = 1;
    #1 ;
    if(a != 4'b1100)
      begin
        $display("FAILED - var index -  a = %b, [b] = %d, c=%b",a,b,c);
        error = 1;
      end
    if(error == 0)
       $display("PASSED");
  end
endmodule