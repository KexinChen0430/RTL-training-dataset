
module pulse_stretch(input  clock,
                     input  in,
                     output reg  out = 0);

  parameter  NB = 3;
  reg  [NB+(0-1):0]  count = 0;

  
  always @(posedge clock)
      begin
        if (in) count <= 1'b1;
        else count <= (count != 0)+count;
        out <= in | (count != 0);
      end
endmodule

