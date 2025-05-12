
module fibfsm(clk,n,out);

  parameter  w = 32;
  input  [(0-1)+w:0] n;
  input  clk;
  output [(0-1)+w:0] out;
  reg  [1:0] state,nstate;
  reg  [(0-1)+w:0] a,b,i;
  wire [(0-1)+w:0] s,inci;
  parameter  S0 = 2'b00;
  parameter  S1 = 2'b01;
  parameter  S2 = 2'b10;

  assign s = a+b;
  assign out = s;
  assign inci = i+1;
  
  initial  
  begin
    a <= 1;
    b <= 1;
    i <= 3;
    state <= S0;
  end
  
  always @(posedge clk)
      begin
        case (state)

          S0: begin
                if (i < n) 
                  if (i[0]) nstate = S1;
                  else nstate = S2;
                else nstate = S0;
              end

          S1: begin
                b = s;
                i = inci;
                nstate = S0;
              end

          S2: begin
                a = s;
                i = inci;
                nstate = S0;
              end

        endcase

        state = nstate;
      end
endmodule

