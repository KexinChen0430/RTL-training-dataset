
module ad_dcfilter(clk,valid,data,valid_out,data_out,dcfilt_enb,dcfilt_coeff,
                   dcfilt_offset);

  input  clk;
  input  valid;
  input  [15:0] data;
  output valid_out;
  output [15:0] data_out;
  input  dcfilt_enb;
  input  [15:0] dcfilt_coeff;
  input  [15:0] dcfilt_offset;
  reg   valid_d = 'd0;
  reg  [15:0]  data_d = 'd0;
  reg   valid_2d = 'd0;
  reg  [15:0]  data_2d = 'd0;
  reg   valid_out = 'd0;
  reg  [15:0]  data_out = 'd0;

  
  always @(posedge clk)
      begin
        dc_offset <= 16'h0;
        valid_d <= valid;
        if (valid == 1'b1) 
          begin
            data_d <= dcfilt_offset+data;
          end
          
        valid_2d <= valid_d;
        data_2d <= data_d-dc_offset;
        if (dcfilt_enb == 1'b1) 
          begin
            valid_out <= valid_2d;
            data_out <= data_d;
          end
        else 
          begin
            valid_out <= valid_d;
            data_out <= data_d;
          end
      end
endmodule

