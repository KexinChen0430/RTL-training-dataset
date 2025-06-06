
module techlib_adff(CLK,ARST,D,Q);

  parameter  WIDTH = 0;
  parameter  CLK_POLARITY = 1'b1;
  parameter  ARST_POLARITY = 1'b1;
  parameter  ARST_VALUE = 0;
  input  CLK,ARST;
  input  [(0-1)+WIDTH:0] D;
  output reg [(0-1)+WIDTH:0] Q;
  wire  pos_clk = CLK == CLK_POLARITY;
  wire  pos_arst = ARST == ARST_POLARITY;

  
  always @(posedge pos_clk or posedge pos_arst)
      begin
        if (pos_arst) Q <= ARST_VALUE;
        else Q <= D;
      end
endmodule

