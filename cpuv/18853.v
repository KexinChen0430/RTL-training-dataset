module main ();
  reg error;
  reg [2:0] val1,val2;
  reg [2:0] result ;
  always @( val1 )
    casez (val1)
      5'b0000z: result = 0;
      5'b001z0: result = 1 ;
      5'b01zz0: result = 2;
      default:  result = 4;
    endcase
  initial
    begin
      error = 0;
      val1 = 5'b0000z ;
      if(result !=0)
        begin
          $display("FAILED casez 3.10D - case (expr) lab1: ");
          error = 1;
        end
      val1 = 5'b001z0;
      if(result !=1)
        begin
          $display("FAILED casez 3.10D - case (expr) lab2: ");
          error = 1;
        end
      val1 = 5'b1zzzz;	
      if(result !=4)
        begin
          $display("FAILED casez 3.10D - case (expr) lab1: ");
          error = 1;
        end
      if(error == 0)
        $display("PASSED");
    end
endmodule