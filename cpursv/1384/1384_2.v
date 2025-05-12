
module clk_gen(input  wire clk100MHz,
               input  wire rst,
               output reg clk1MHz,
               output reg clk5KHz,
               output reg clk200Hz);

  integer count;
  integer ledmux;
  integer highspeed;

  
  always @(posedge clk100MHz or posedge rst)
      begin
        if (rst) 
          begin
            count = 0;
            highspeed = 0;
            ledmux = 0;
            clk1MHz = 0;
            clk5KHz = 0;
            clk200Hz = 0;
          end
        else 
          begin
            if (count == 250000) 
              begin
                clk200Hz = ~clk200Hz;
                count = 0;
              end
              
            if (ledmux == 5000) 
              begin
                clk5KHz = ~clk5KHz;
                ledmux = 0;
              end
              
            if (highspeed == 50) 
              begin
                clk1MHz = ~clk1MHz;
                highspeed = 0;
              end
              
            count = 1+count;
            highspeed = 1+highspeed;
            ledmux = ledmux+1;
          end
      end
endmodule

