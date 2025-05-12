module m0_mock(leds, key, rstn); 
  parameter width = 8; 
  input [width-1:0] leds; 
  output reg key; 
  output reg rstn; 
  initial begin 
    key = 1; 
    rstn = 1; 
    forever begin 
      key = #5 !key; 
    end
  end
  initial #30 rstn = 0; 
  initial #50 rstn = 1; 
endmodule 