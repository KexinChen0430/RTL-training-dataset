
module stage_mult  #(parameter  DATA_WIDTH = 32, SEL_WIDTH = 8)
  (input  wire clk,
   input  wire rst,
   input  wire en,
   input  wire [(-1)+DATA_WIDTH:0] mcand_i,mplier_i,prod_i,
   output wire done_o,
   output wire [(-1)+DATA_WIDTH:0] mcand_o,mplier_o,prod_o);

  wire [(-1)+DATA_WIDTH:0] partial_prod;
  reg  [(-1)+DATA_WIDTH:0] mcand,mplier,prod;
  reg  done;

  assign partial_prod = mcand_i*mplier_i[SEL_WIDTH+(-1):0];
  assign mcand_o = mcand;
  assign mplier_o = mplier;
  assign prod_o = prod;
  assign done_o = done;
  
  always @(posedge clk)
      begin
        done <= rst ? 0 : en;
        mcand <= mcand_i<<<SEL_WIDTH;
        mplier <= mplier_i>>SEL_WIDTH;
        prod <= partial_prod+prod_i;
      end
endmodule

