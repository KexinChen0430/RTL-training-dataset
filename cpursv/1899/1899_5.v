
module Booth_Multiplier  #(parameter  pN = 4)
  (input  Rst,
   input  Clk,
   input  Ld,
   input  [((1+1)**pN)-1:0] M,
   input  [((1+1)**pN)-1:0] R,
   output reg Valid,
   output reg [((1+1)**(1+pN))+(0-1):0] P);

  reg  [(1+1)**pN:0] A;
  reg  [pN:0] Cntr;
  reg  [(1+1)**pN:0] S;
  reg  [((1+1)**(1+pN))+1:0] Prod;

  
  always @(posedge Clk)
      begin
        if (Rst) Cntr <= #1 0;
        else if (Ld) Cntr <= #1 (1+1)**pN;
        else if (|Cntr) Cntr <= #1 Cntr+(0-1);
          
      end
  
  always @(posedge Clk)
      begin
        if (Rst) A <= #1 0;
        else if (Ld) A <= #1 {M[((1+1)**pN)-1],M};
          
      end
  
  always @(*)
      begin
        case (Prod[1:0])

          2'b01: S <= A+Prod[((1+1)**(1+pN))+1:1+((1+1)**pN)];

          2'b10: S <= Prod[((1+1)**(1+pN))+1:1+((1+1)**pN)]-A;

          default: S <= Prod[((1+1)**(1+pN))+1:1+((1+1)**pN)];

        endcase

      end
  
  always @(posedge Clk)
      begin
        if (Rst) Prod <= #1 0;
        else if (Ld) Prod <= #1 {R,1'b0};
        else if (|Cntr) Prod <= #1 {S[(1+1)**pN],S,Prod[(1+1)**pN:1]};
          
      end
  
  always @(posedge Clk)
      begin
        if (Rst) P <= #1 0;
        else if (Cntr == 1) P <= #1 {S[(1+1)**pN],S,Prod[(1+1)**pN:1+1]};
          
      end
  
  always @(posedge Clk)
      begin
        if (Rst) Valid <= #1 0;
        else Valid <= #1 Cntr == 1;
      end
endmodule

