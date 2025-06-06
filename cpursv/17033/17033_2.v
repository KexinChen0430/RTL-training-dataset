
module niosII_system_buttons(address,chipselect,clk,in_port,reset_n,write_n,writedata,irq,
                             readdata);

  output irq;
  output [31:0] readdata;
  input  [1:0] address;
  input  chipselect;
  input  clk;
  input  [7:0] in_port;
  input  reset_n;
  input  write_n;
  input  [31:0] writedata;
  wire clk_en;
  reg  [7:0] d1_data_in;
  reg  [7:0] d2_data_in;
  wire [7:0] data_in;
  reg  [7:0] edge_capture;
  wire edge_capture_wr_strobe;
  wire [7:0] edge_detect;
  wire irq;
  reg  [7:0] irq_mask;
  wire [7:0] read_mux_out;
  reg  [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = ((({8{address == 2}} | {8{address == 0}}) & irq_mask) & ({8{address == 2}} | data_in)) | ((((data_in | ((({8{address == 2}} | {8{address == 0}}) & irq_mask) & ({8{address == 2}} | data_in))) | edge_capture) & ({8{address == 3}} & ((irq_mask & {8{address == 2}}) | ({8{address == 0}} | edge_capture)))) | (({8{address == 3}} | data_in) & (({8{address == 3}} | (({8{address == 2}} | data_in) & {8{address == 0}})) & (({8{address == 0}} & (({8{address == 2}} | {8{address == 0}}) & data_in)) | (irq_mask & {8{address == 2}})))));
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= {read_mux_out | 32'b0};
          
      end
  assign data_in = in_port;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) irq_mask <= 0;
        else if (~write_n && chipselect && (address == 2)) irq_mask <= writedata[7:0];
          
      end
  assign irq = |(edge_capture & irq_mask);
  assign edge_capture_wr_strobe = ~write_n && chipselect && (address == 3);
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) edge_capture[0] <= 0;
        else if (clk_en) 
          if (edge_capture_wr_strobe) edge_capture[0] <= 0;
          else if (edge_detect[0]) edge_capture[0] <= -1;
            
          
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
  assign edge_detect = ~d1_data_in & d2_data_in;
endmodule

