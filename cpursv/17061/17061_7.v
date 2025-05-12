
module pio_pulse(address,chipselect,clk,in_port,reset_n,write_n,writedata,irq,
                 readdata);

  output irq;
  output readdata;
  input  [1:0] address;
  input  chipselect;
  input  clk;
  input  in_port;
  input  reset_n;
  input  write_n;
  input  writedata;
  wire clk_en;
  reg  d1_data_in;
  reg  d2_data_in;
  wire data_in;
  reg  edge_capture;
  wire edge_capture_wr_strobe;
  wire edge_detect;
  wire irq;
  reg  irq_mask;
  wire read_mux_out;
  reg  readdata;

  assign clk_en = 1;
  assign read_mux_out = ((irq_mask & ((data_in | irq_mask) & ({1{address == 2}} | data_in))) & {1{address == 2}}) | (({1{address == 3}} & edge_capture) | ((data_in | ({1{address == 3}} & edge_capture)) & {1{address == 0}}));
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= read_mux_out;
          
      end
  assign data_in = in_port;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) irq_mask <= 0;
        else if (~write_n && (address == 2) && chipselect) irq_mask <= writedata;
          
      end
  assign irq = |(irq_mask & edge_capture);
  assign edge_capture_wr_strobe = chipselect && (address == 3) && ~write_n;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) edge_capture <= 0;
        else if (clk_en) 
          if (edge_capture_wr_strobe) edge_capture <= 0;
          else if (edge_detect) edge_capture <= -1;
            
          
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
  assign edge_detect = d1_data_in ^ (((d1_data_in | ~d1_data_in) & ((d2_data_in & (d1_data_in | ~d1_data_in)) & (d1_data_in | ~d1_data_in))) & (d1_data_in | ~d1_data_in));
endmodule

