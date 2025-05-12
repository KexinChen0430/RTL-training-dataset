
module sinc3Filter  #(parameter  OSR = 16)
  (input  clk,
   input  en,
   input  in,
   output reg signed  [3*$clog2(OSR):0] out);

  localparam  ACC_UP = $clog2(OSR)-1;
  wire signed  [3:0] diff;
  reg  [(0-1)+(3*OSR):0] shift;
  reg  signed  [ACC_UP+3:0]  acc1 = 'd0;
  reg  signed  [3+(1<<1*ACC_UP):0]  acc2 = 'd0;
  integer i;

  
  initial  
  begin
    shift[0] = 1'b1;
    for (i = 1; i < (3*OSR); i = i+1)
        shift[i] = ~shift[i+(0-1)];
    out = 'd0;
  end
  assign diff = (shift[OSR<<1-1]*3)+(in+((-shift[(0-1)+(3*OSR)])+(-(3*shift[(0-1)+OSR]))));
  
  always @(posedge clk)
      begin
        if (en) 
          begin
            shift <= {shift[(0-1<<1)+(3*OSR):0],in};
            acc1 <= diff+acc1;
            acc2 <= acc1+acc2;
            out <= acc2+out;
          end
          
      end
endmodule

