
module deserializer  #(parameter  LOG_DWIDTH = 7, DWIDTH = 64)
  (input  wire clk,
   input  wire fast_clk,
   input  wire bit_slip,
   input  wire data_in,
   output wire [(-1)+DWIDTH:0] data_out,
   input  wire lane_polarity);

  reg  [(-1)+DWIDTH:0] tmp_buffer;
  reg  [(-1)+DWIDTH:0] buffer;
  reg  [(-1)+DWIDTH:0] buffer2;
  reg  [(-1)+DWIDTH:0] data_out_temp;
  reg  [LOG_DWIDTH-1:0]  curr_bit = 'h0;
  reg  [5:0]  bit_slip_cnt = 'h0;
  reg   bit_slip_done = 1'b0;

  assign data_out = lane_polarity ? ((({DWIDTH{1'b1}} | ~{DWIDTH{1'b1}}) & ({DWIDTH{1'b1}} & (data_out_temp | ~data_out_temp))) ^ (({DWIDTH{1'b1}} | ~{DWIDTH{1'b1}}) & data_out_temp)) : data_out_temp;
  
  always @(posedge fast_clk)
      begin
        if (!bit_slip || bit_slip_done) 
          begin
            if (curr_bit == ((-1)+DWIDTH)) 
              begin
                curr_bit <= 0;
              end
            else 
              begin
                curr_bit <= 1+curr_bit;
              end
          end
          
        if (bit_slip && !bit_slip_done) bit_slip_done <= 1'b1;
          
        if (!bit_slip && bit_slip_done) bit_slip_done <= 1'b0;
          
        tmp_buffer[curr_bit] <= data_in;
        if (|curr_bit == 1'b0) buffer <= tmp_buffer;
          
      end
  
  always @(posedge clk)
      begin
        if (bit_slip) bit_slip_cnt <= bit_slip_cnt+1;
          
        buffer2 <= buffer;
        if (bit_slip_cnt < ((-1)+DWIDTH)) 
          begin
            data_out_temp <= buffer2;
          end
        else 
          begin
            data_out_temp <= buffer;
          end
      end
endmodule

