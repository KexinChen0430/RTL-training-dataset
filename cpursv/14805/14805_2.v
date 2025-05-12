
module clkEnable_gen  #(parameter  DES_CLOCK = 1000, SYS_CLOCK = 5000000)
  (output reg enable,
   input  clock,
   input  greset);

  reg  [31:0] count;
  reg  lreset;
  wire rst;

  
  initial    count = 31'b1;
  
  initial    lreset = 1;
  
  initial    enable = 0;
  assign rst = lreset | greset;
  
  always @(posedge clock)
      begin
        if (rst) count <= 1;
        else count <= 1+count;
      end
  
  always @* 
      begin
        if (count == DES_CLOCK) 
          begin
            enable = 1;
            lreset = 1;
          end
        else 
          begin
            enable = 0;
            lreset = 0;
          end
      end
endmodule

