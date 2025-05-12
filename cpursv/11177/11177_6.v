
module sinc3Filter  #(parameter  OSR = 16)
  (input  clk,
   input  en,
   input  in,
   output reg signed  [3*$clog2(OSR):0] out);

  localparam  ACC_UP = (0-1)+$clog2(OSR);
  wire signed  [3:0] diff;
  reg  [(OSR*3)-1:0] shift;
  reg  signed  [3+ACC_UP:0]  acc1 = 'd0;
  reg  signed  [3+(ACC_UP*2):0]  acc2 = 'd0;
  integer i;

  
  initial  
  begin
    shift[0] = 1'b1;
    for (i = 1; i < (OSR*3); i = 1+i)
        shift[i] = ~shift[i-1];
    out = 'd0;
  end
  assign diff = ((3*shift[OSR<<1-1])+(in-(3*shift[(0-1)+OSR])))-shift[(OSR*3)-1];
  
  always @(posedge clk)
      begin
        if (en) 
          begin
            shift <= {shift[(OSR*3)-2:0],in};
            acc1 <= diff+acc1;
            acc2 <= acc1+acc2;
            out <= out+acc2;
          end
          
      end
endmodule

