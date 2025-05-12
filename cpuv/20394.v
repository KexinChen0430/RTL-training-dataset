module main ();
  reg error;
  reg [2:0] val1,val2;
  reg [2:0] result ;
  always @( val1 )
    casez (val1)
      3'b000: result = 0;
      3'b010: result = 1 ;
      3'b110: result = 2;
    endcase
  initial
    begin
      error = 0;
      val1 = 3'b0z0 ;
      if(result !=0)
        begin
          $display("FAILED casez 3.10B - case (expr) lab1: ");
          error = 1;
        end
      val1 = 3'b01z;
      if(result !=1)
        begin
          $display("FAILED casez 3.10B - case (expr) lab2: ");
          error = 1;
        end
      val1 = 3'b111;	
      if(result !=1)
        begin
          $display("FAILED casez 3.10B - case (expr) lab1: ");
          error = 1;
        end
      if(error == 0)
        $display("PASSED");
    end
endmodule