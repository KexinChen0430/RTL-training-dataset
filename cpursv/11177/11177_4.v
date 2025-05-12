
module sinc3Filter  #(parameter  OSR = 16)
  (input  clk,
   input  en,
   input  in,
   output reg signed  [$clog2(OSR)*3:0] out);

  localparam  ACC_UP = $clog2(OSR)-1;
  wire signed  [3:0] diff;
  reg  [(OSR*3)+(-1):0] shift;
  reg  signed  [3+ACC_UP:0]  acc1 = 'd0;
  reg  signed  [ACC_UP<<<1+3:0]  acc2 = 'd0;
  integer i;

  
  initial  
  begin
    shift[0] = 1'b1;
    for (i = 1; i < (OSR*3); i = i+1)
        shift[i] = ~shift[(-1)+i];
    out = 'd0;
  end
  assign diff = (0-shift[(OSR*3)+(-1)])+((3*shift[(2*OSR)+(-1)])+(in+(0-(3*shift[(-1)+OSR]))));
  
  always @(posedge clk)
      begin
        if (en) 
          begin
            shift <= {shift[(OSR*3)+(-2):0],in};
            acc1 <= diff+acc1;
            acc2 <= acc2+acc1;
            out <= acc2+out;
          end
          
      end
endmodule

