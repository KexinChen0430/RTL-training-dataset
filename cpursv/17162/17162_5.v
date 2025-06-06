
module TimeHoldOver_Qsys_pps_interrupt(input  [1:0] address,
                                       input  chipselect,
                                       input  clk,
                                       input  in_port,
                                       input  reset_n,
                                       input  write_n,
                                       input  [31:0] writedata,
                                       output irq,
                                       output [31:0] readdata);

  wire clk_en;
  reg  d1_data_in;
  reg  d2_data_in;
  wire data_in;
  reg  edge_capture;
  wire edge_capture_wr_strobe;
  wire edge_detect;
  reg  irq_mask;
  wire read_mux_out;
  reg  [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = (({1{address == 0}} | ({1{address == 3}} & edge_capture)) & data_in) | (((irq_mask & {1{address == 2}}) | (data_in & ({1{address == 0}} & irq_mask))) | ({1{address == 3}} & edge_capture));
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= {read_mux_out | 32'b0};
          
      end
  assign data_in = in_port;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) irq_mask <= 0;
        else if ((address == 2) && (~write_n && chipselect)) irq_mask <= writedata;
          
      end
  assign irq = |(edge_capture & irq_mask);
  assign edge_capture_wr_strobe = (address == 3) && (~write_n && chipselect);
  
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
  assign edge_detect = d1_data_in & ~d2_data_in;
endmodule

