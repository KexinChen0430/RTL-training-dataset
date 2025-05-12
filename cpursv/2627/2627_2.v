
module i2c_test(input  res,
                input  ioclk,
                output reg wreq,
                output reg dreq);

  reg  [29:0] counter;

  
  always @(ioclk)
      begin
        if (res) 
          begin
            wreq <= 0;
            dreq <= 0;
            counter <= 0;
          end
          
        counter <= 1'b1+counter;
        if (counter == 30'h100_0000) 
          begin
            dreq <= 1;
          end
          
      end
endmodule

