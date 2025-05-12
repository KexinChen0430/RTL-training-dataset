
module btn_driver(input  clk,
                  input  btn,
                  output reg  sig = 0);

  parameter  nskip = 'hfff;
  integer  counter = 0;
  wire  lock = counter ? 1 : 0;

  
  always @(posedge clk)
      begin
        if (counter) counter <= counter+(0-1);
          
        if ((sig != btn) && !lock) 
          begin
            sig <= btn;
            counter <= nskip;
          end
          
      end
endmodule

