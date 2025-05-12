
module spi_master_baud_gen  #(parameter  PSC = 1)
  (input  wire i_clk,
   input  wire i_rst,
   output wire o_udf,
   output wire o_ovf,
   output wire o_udf_div2,
   output wire o_ovf_div2,
   output wire o_period);

  localparam  PSC_TOP = PSC;
  localparam  BITS = $clog2(1+PSC_TOP);
  reg  [(-1)+BITS:0] count;
  wire  count_is_zero = count == 0;
  wire  count_is_top = count == PSC_TOP;
  reg  period;

  assign o_period = period;
  
  initial  
  begin
    count = 'd0;
    period = 'd0;
  end
  assign o_udf = i_rst & count_is_zero;
  assign o_ovf = count_is_top & i_rst;
  assign o_udf_div2 = (i_rst & !period) & count_is_zero;
  assign o_ovf_div2 = count_is_top & (period & i_rst);
  
  always @(posedge i_clk or negedge i_rst)
      begin
        if (!i_rst) 
          begin
            count <= #1 'd0;
          end
        else 
          begin
            if (count_is_top) 
              begin
                count <= #1 'd0;
              end
            else 
              begin
                count <= #1 count+'d1;
              end
          end
      end
  
  always @(posedge i_clk or negedge i_rst)
      begin
        if (!i_rst) 
          begin
            period <= #1 'd0;
          end
        else 
          begin
            if (count_is_top) 
              begin
                period <= #1 !period;
              end
            else 
              begin
                period <= #1 period;
              end
          end
      end
endmodule

