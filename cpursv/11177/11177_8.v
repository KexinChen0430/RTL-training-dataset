
module sinc3Filter  #(parameter  OSR = 16)
  (input  clk,
   input  en,
   input  in,
   output reg signed  [$clog2(OSR)*3:0] out);

  localparam  ACC_UP = (0-1)+$clog2(OSR);
  wire signed  [3:0] diff;
  reg  [(OSR*3)+(0-1):0] shift;
  reg  signed  [3+ACC_UP:0]  acc1 = 'd0;
  reg  signed  [3+ACC_UP<<1:0]  acc2 = 'd0;
  integer i;

  
  initial  
  begin
    shift[0] = 1'b1;
    for (i = 1; i < (OSR*3); i = 1+i)
        shift[i] = ~shift[i+(0-1)];
    out = 'd0;
  end
  assign diff = (((0-(shift[OSR+(0-1)]*3))+(shift[OSR<<<1-1]*3))+in)+(0-shift[(OSR*3)+(0-1)]);
  
  always @(posedge clk)
      begin
        if (en) 
          begin
            shift <= {shift[(OSR*3)-(1+1):0],in};
            acc1 <= acc1+diff;
            acc2 <= acc1+acc2;
            out <= acc2+out;
          end
          
      end
endmodule

