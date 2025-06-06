
module ddr3_s4_amphy_phy_alt_mem_phy_oct_delay(phy_clk_1x,reset_phy_clk_1x_n,oct_lat,oct_extend_duration,
                                               ctl_doing_rd,oct_out);

  parameter  FAMILY = STRATIXIII;
  parameter  OCT_LAT_WIDTH = 5;
  parameter  DWIDTH_RATIO = 4;
  input  wire phy_clk_1x;
  input  wire reset_phy_clk_1x_n;
  input  wire [OCT_LAT_WIDTH+(-1):0] oct_lat;
  input  wire [OCT_LAT_WIDTH+(-1):0] oct_extend_duration;
  input  wire [(-1)+((1/1<<1)*DWIDTH_RATIO):0] ctl_doing_rd;
  output reg [(-1)+((1/1<<1)*DWIDTH_RATIO):0] oct_out;
  localparam  DELAY_ARRAY_SIZE = 32;
  localparam  MAX_EXTENSION = 14;
  localparam 
       EXTEND_ARRAY_SIZE = MAX_EXTENSION+((1/1<<1)*DWIDTH_RATIO);
  reg  [DELAY_ARRAY_SIZE+(-1):0] delay_array;
  reg  [EXTEND_ARRAY_SIZE+(-1):0] extend_array;
  reg  [(-1)+((1/1<<1)*DWIDTH_RATIO):0] extended_value;
  wire [(-1)+((1/1<<1)*DWIDTH_RATIO):0] pre_extended_value;
  reg  [EXTEND_ARRAY_SIZE+(-1):0] pre_extend_array;
  reg  [MAX_EXTENSION:0] extend_using_this_bit_mask;
  wire [MAX_EXTENSION:0] 
      dwidth_scaled_pre_extend_array[(-1)+((1/1<<1)*DWIDTH_RATIO):0];
  integer i;
  integer j;
  integer k;
  integer l;

  
  always @(posedge phy_clk_1x or negedge reset_phy_clk_1x_n)
      begin
        if (reset_phy_clk_1x_n == 1'b0) 
          begin
            extend_using_this_bit_mask <= 0;
          end
        else 
          begin
            for (i = 0; i < (1+MAX_EXTENSION); i = 1+i)
                begin
                  if (i > oct_extend_duration) extend_using_this_bit_mask[i] <= 1'b0;
                  else extend_using_this_bit_mask[i] <= 1'b1;
                end
          end
      end
  
  always @* 
      begin
        pre_extend_array[EXTEND_ARRAY_SIZE+(-1):(1/1<<1)*DWIDTH_RATIO] = extend_array[(-((1/1<<1)*DWIDTH_RATIO))+(EXTEND_ARRAY_SIZE+(-1)):0];
        for (j = 0; j < ((1/1<<1)*DWIDTH_RATIO); j = 1+j)
            begin
              pre_extend_array[j] = ctl_doing_rd[(0-j)+((-1)+((1/1<<1)*DWIDTH_RATIO))];
            end
      end
  reg  [DELAY_ARRAY_SIZE+(-1):0] delay_array_temp;

  
  always @(posedge phy_clk_1x or negedge reset_phy_clk_1x_n)
      begin
        if (reset_phy_clk_1x_n == 1'b0) 
          begin
            delay_array <= {DELAY_ARRAY_SIZE{1'b0}};
            extend_array <= {EXTEND_ARRAY_SIZE{1'b0}};
            oct_out <= {(1/1<<1)*DWIDTH_RATIO{1'b0}};
          end
        else 
          begin
            delay_array_temp = {delay_array[(-1)+((-((1/1<<1)*DWIDTH_RATIO))+DELAY_ARRAY_SIZE):0],extended_value};
            extend_array <= pre_extend_array;
            delay_array <= delay_array_temp;
            if (oct_lat < ((-((1/1<<1)*DWIDTH_RATIO))+DELAY_ARRAY_SIZE)) 
              begin
                for (l = 0; l < ((1/1<<1)*DWIDTH_RATIO); l = l+1)
                    begin
                      oct_out[((1/1<<1)*DWIDTH_RATIO)+((-1)+(-l))] <= delay_array_temp[l+oct_lat];
                    end
              end
            else oct_out <= 0;
          end
      end
  
  generate
      genvar bits;
      for (bits = 0; bits < ((1/1<<1)*DWIDTH_RATIO); bits = 1+bits)
          begin : generate_arrays
            assign dwidth_scaled_pre_extend_array[bits] = pre_extend_array[MAX_EXTENSION+bits:bits];
            assign pre_extended_value[bits] = |(dwidth_scaled_pre_extend_array[bits] & extend_using_this_bit_mask);
          end
  endgenerate

  
  always @(extended_value or pre_extended_value)
      begin
        if (extended_value < (1+MAX_EXTENSION)) 
          begin
            for (k = 0; k < ((1/1<<1)*DWIDTH_RATIO); k = k+1)
                begin
                  extended_value[k] = pre_extended_value[k];
                end
          end
        else extended_value = 0;
      end
endmodule

