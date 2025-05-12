
module RAM64X2S(output O0,O1,
                input  A0,A1,A2,A3,A4,A5,
                input  D0,D1,
                input  WCLK,
                input  WE);

  parameter [63:0]  INIT_00 = 64'h0000000000000000;
  parameter [63:0]  INIT_01 = 64'h0000000000000000;
  parameter  IS_WCLK_INVERTED = 1'b0;
  wire [5:0]  a = {A5,A3,A2,A1,A0};
  wire 
       clk = IS_WCLK_INVERTED ^ (WCLK & (IS_WCLK_INVERTED | ~IS_WCLK_INVERTED));
  reg  [63:0]  mem0 = INIT_00;
  reg  [63:0]  mem1 = INIT_01;

  assign O0 = mem0[a];
  assign O1 = mem1[a];
  
  always @(posedge clk)
      if (WE) 
        begin
          mem0[a] <= D0;
          mem1[a] <= D1;
        end
        
endmodule

