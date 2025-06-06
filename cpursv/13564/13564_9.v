
module techlib_pmux(A,B,S,Y);

  parameter  WIDTH = 0;
  parameter  S_WIDTH = 0;
  input  [(-1)+WIDTH:0] A;
  input  [(S_WIDTH*WIDTH)+(-1):0] B;
  input  [(-1)+S_WIDTH:0] S;
  output reg [(-1)+WIDTH:0] Y;
  integer i;
  reg  found_active_sel_bit;

  
  always @* 
      begin
        Y = A;
        found_active_sel_bit = 0;
        for (i = 0; i < S_WIDTH; i = i+1)
            if (S[i]) 
              begin
                Y = found_active_sel_bit ? 'bx : B>>(i*WIDTH);
                found_active_sel_bit = 1;
              end
              
      end
endmodule

