module soc_system_dipsw_pio (
                               address,
                               chipselect,
                               clk,
                               in_port,
                               reset_n,
                               write_n,
                               writedata,
                               irq,
                               readdata
                            )
;
  output           irq;
  output  [ 31: 0] readdata;
  input   [  1: 0] address;
  input            chipselect;
  input            clk;
  input   [  9: 0] in_port;
  input            reset_n;
  input            write_n;
  input   [ 31: 0] writedata;
wire             clk_en;
reg     [  9: 0] d1_data_in;
reg     [  9: 0] d2_data_in;
wire    [  9: 0] data_in;
reg     [  9: 0] edge_capture;
wire             edge_capture_wr_strobe;
wire    [  9: 0] edge_detect;
wire             irq;
reg     [  9: 0] irq_mask;
wire    [  9: 0] read_mux_out;
reg     [ 31: 0] readdata;
  assign clk_en = 1;
  assign read_mux_out = ({10 {(address == 0)}} & data_in) |
    ({10 {(address == 2)}} & irq_mask) |
    ({10 {(address == 3)}} & edge_capture);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          readdata <= 0;
      else if (clk_en)
          readdata <= {32'b0 | read_mux_out};
    end
  assign data_in = in_port;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          irq_mask <= 0;
      else if (chipselect && ~write_n && (address == 2))
          irq_mask <= writedata[9 : 0];
    end
  assign irq = |(edge_capture & irq_mask);
  assign edge_capture_wr_strobe = chipselect && ~write_n && (address == 3);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[0] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[0])
              edge_capture[0] <= 0;
          else if (edge_detect[0])
              edge_capture[0] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[1] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[1])
              edge_capture[1] <= 0;
          else if (edge_detect[1])
              edge_capture[1] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[2] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[2])
              edge_capture[2] <= 0;
          else if (edge_detect[2])
              edge_capture[2] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[3] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[3])
              edge_capture[3] <= 0;
          else if (edge_detect[3])
              edge_capture[3] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[4] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[4])
              edge_capture[4] <= 0;
          else if (edge_detect[4])
              edge_capture[4] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[5] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[5])
              edge_capture[5] <= 0;
          else if (edge_detect[5])
              edge_capture[5] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[6] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[6])
              edge_capture[6] <= 0;
          else if (edge_detect[6])
              edge_capture[6] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[7] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[7])
              edge_capture[7] <= 0;
          else if (edge_detect[7])
              edge_capture[7] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[8] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[8])
              edge_capture[8] <= 0;
          else if (edge_detect[8])
              edge_capture[8] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          edge_capture[9] <= 0;
      else if (clk_en)
          if (edge_capture_wr_strobe && writedata[9])
              edge_capture[9] <= 0;
          else if (edge_detect[9])
              edge_capture[9] <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
        begin
          d1_data_in <= 0;
          d2_data_in <= 0;
        end
      else if (clk_en)
        begin
          d1_data_in <= data_in;
          d2_data_in <= d1_data_in;
        end
    end
  assign edge_detect = d1_data_in ^  d2_data_in;
endmodule