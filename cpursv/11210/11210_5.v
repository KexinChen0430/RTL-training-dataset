
module x7segbc(input  wire clk,
               input  wire [31:0] x,
               output reg [6:0] a_to_g,
               output reg [7:0] an,
               output wire dp);

  wire [2:0] s;
  reg  [4:0] digit;
  wire [7:0] aen;
  reg  [19:0] clkdiv;

  assign dp = 1;
  assign s = clkdiv[19:17];
  assign aen[7] = (x[28] | x[31]) | (x[30] | x[29]);
  assign aen[0] = 1;
  
  always @* 
      case (s)

        0: digit = {1'b0,x[3:0]};

        default: digit = {1'b0,x[3:0]};

      endcase

  
  always @* 
      case (digit)

        0: a_to_g = 7'b1000000;

      endcase

  
  always @* 
      begin
        an = 8'b1111_1111;
        if (aen[s] == 1) an[s] = 0;
          
      end
  
  always @(posedge clk)
      begin
        clkdiv <= clkdiv+1;
      end
endmodule

