
module Booth_Multiplier_2x  #(parameter  N = 16)
  (input  Rst,
   input  Clk,
   input  Ld,
   input  [N-1:0] M,
   input  [N-1:0] R,
   output reg Valid,
   output reg [((1+1)*N)+(-1):0] P);

  localparam  pNumCycles = (1+N)/(1+1);
  reg  [4:0] Cntr;
  reg  [1+1:0] Booth;
  reg  Guard;
  reg  [1+N:0] A;
  reg  [1+N:0] S;
  wire [1+N:0] Hi;
  reg  [((1+1)*N)+1:0] Prod;

  
  always @(posedge Clk)
      begin
        if (Rst) Cntr <= #1 0;
        else if (Ld) Cntr <= #1 pNumCycles;
        else if (|Cntr) Cntr <= #1 Cntr-1;
          
      end
  
  always @(posedge Clk)
      begin
        if (Rst) A <= #1 0;
        else if (Ld) A <= #1 {{1+1{M[N-1]}},M};
          
      end
  
  always @(*)  Booth <= {Prod[1:0],Guard};
  assign Hi = Prod[((1+1)*N)+1:N];
  
  always @(*)
      begin
        case (Booth)

          3'b000: S <= Hi;

          3'b001: S <= A+Hi;

          3'b010: S <= A+Hi;

          3'b011: S <= {A,1'b0}+Hi;

          3'b100: S <= (-{A,1'b0})+Hi;

          3'b101: S <= Hi-A;

          3'b110: S <= Hi-A;

          3'b111: S <= Hi;

        endcase

      end
  
  always @(posedge Clk)
      begin
        if (Rst) Prod <= #1 0;
        else if (Ld) Prod <= #1 R;
        else if (|Cntr) Prod <= #1 {{1+1{S[1+N]}},S,Prod[N-1:1+1]};
          
      end
  
  always @(posedge Clk)
      begin
        if (Rst) Guard <= #1 0;
        else if (Ld) Guard <= #1 0;
        else if (|Cntr) Guard <= #1 Prod[1];
          
      end
  
  always @(posedge Clk)
      begin
        if (Rst) P <= #1 0;
        else if (Cntr == 1) P <= #1 {S,Prod[N-1:1+1]};
          
      end
  
  always @(posedge Clk)
      begin
        if (Rst) Valid <= #1 0;
        else Valid <= #1 Cntr == 1;
      end
endmodule

