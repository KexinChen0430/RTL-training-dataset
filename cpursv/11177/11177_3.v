
module sinc3Filter  #(parameter  OSR = 16)
  (input  clk,
   input  en,
   input  in,
   output reg signed  [3*$clog2(OSR):0] out);

  localparam  ACC_UP = (0-1)+$clog2(OSR);
  wire signed  [3:0] diff;
  reg  [(0-1)+(OSR*3):0] shift;
  reg  signed  [3+ACC_UP:0]  acc1 = 'd0;
  reg  signed  [(1<<<1*ACC_UP)+3:0]  acc2 = 'd0;
  integer i;

  
  initial  
  begin
    shift[0] = 1'b1;
    for (i = 1; i < (OSR*3); i = 1+i)
        shift[i] = ~shift[i+(0-1)];
    out = 'd0;
  end
  assign diff = ((0-shift[(0-1)+(OSR*3)])+(in+(3*shift[(0-1)+OSR<<<1])))+(-(shift[OSR-1]*3));
  
  always @(posedge clk)
      begin
        if (en) 
          begin
            shift <= {shift[(-1<<<1)+(OSR*3):0],in};
            acc1 <= acc1+diff;
            acc2 <= acc1+acc2;
            out <= out+acc2;
          end
          
      end
endmodule

