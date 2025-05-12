
module stimulus(output reg A,B);

  
  initial  
  begin
    {A,B} = 2'b00;
    #10 {A,B} = 2'b01;
    #10 {A,B} = 2'b10;
    #10 {A,B} = 2'b11;
  end
endmodule

