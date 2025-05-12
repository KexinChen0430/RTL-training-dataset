
module jfsmMooreWithOverlap(dataout,clock,reset,datain);

  output reg dataout;
  input  clock,reset,datain;
  reg  [2:0] cs,ns;
  parameter  a = 3'b000;
  parameter  b = 3'b001;
  parameter  c = 3'b010;
  parameter  d = 3'b011;
  parameter  e = 3'b100;
  parameter  f = 3'b101;

  
  always @(posedge clock)
      begin
        if (reset) cs <= a;
        else cs <= ns;
      end
  
  always @(cs or datain)
      begin
        case (cs)

          a: begin
                if (datain) ns <= b;
                else ns <= a;
              end

          b: begin
                if (datain) ns <= c;
                else ns <= b;
              end

          c: begin
                if (datain) ns <= d;
                else ns <= a;
              end

          d: begin
                if (datain) ns <= d;
                else ns <= e;
              end

          e: begin
                if (datain) ns <= f;
                else ns <= a;
              end

          f: begin
                if (datain) ns <= c;
                else ns <= a;
              end

        endcase

      end
  
  always @(cs or datain)
      begin
        if ((datain == 1) && (cs == e)) dataout <= 1;
        else dataout <= 0;
      end
endmodule

