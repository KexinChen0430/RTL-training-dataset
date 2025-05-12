
module button_pio(address,chipselect,clk,in_port,reset_n,write_n,writedata,irq,
                  readdata);

  output irq;
  output [31:0] readdata;
  input  [1:0] address;
  input  chipselect;
  input  clk;
  input  [3:0] in_port;
  input  reset_n;
  input  write_n;
  input  [31:0] writedata;
  wire clk_en;
  reg  [3:0] d1_data_in;
  reg  [3:0] d2_data_in;
  wire [3:0] data_in;
  reg  [3:0] edge_capture;
  wire edge_capture_wr_strobe;
  wire [3:0] edge_detect;
  wire irq;
  reg  [3:0] irq_mask;
  wire [3:0] read_mux_out;
  reg  [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = (((irq_mask & ({4{address == 1<<<1}} & ((data_in | {4{address == 1<<<1}}) & (irq_mask | data_in)))) & edge_capture) | ((({4{address == 0}} & (data_in & ({4{address == 1<<<1}} | {4{address == 0}}))) | {4{address == 3}}) & (({4{address == 3}} | (data_in | {4{address == 1<<<1}})) & (edge_capture & (({4{address == 1<<<1}} | {4{address == 0}}) | {4{address == 3}}))))) | ((((irq_mask & (data_in | {4{address == 1<<<1}})) & ({4{address == 1<<<1}} | {4{address == 0}})) | {4{address == 0}}) & ((data_in & ({4{address == 1<<<1}} | {4{address == 0}})) | ((irq_mask & (data_in | {4{address == 1<<<1}})) & ({4{address == 1<<<1}} | {4{address == 0}}))));
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= {{{32-4}{1'b0}},read_mux_out};
          
      end
  assign data_in = in_port;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) irq_mask <= 0;
        else if (chipselect && (~write_n && (address == 1<<<1))) irq_mask <= writedata[3:0];
          
      end
  assign irq = |(irq_mask & edge_capture);
  assign edge_capture_wr_strobe = chipselect && (address == 3) && ~write_n;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) edge_capture[0] <= 0;
        else if (clk_en) 
          if (edge_capture_wr_strobe) edge_capture[0] <= 0;
          else if (edge_detect[0]) edge_capture[0] <= -1;
            
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) edge_capture[1] <= 0;
        else if (clk_en) 
          if (edge_capture_wr_strobe) edge_capture[1] <= 0;
          else if (edge_detect[1]) edge_capture[1] <= -1;
            
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) edge_capture[1<<<1] <= 0;
        else if (clk_en) 
          if (edge_capture_wr_strobe) edge_capture[1<<<1] <= 0;
          else if (edge_detect[1<<<1]) edge_capture[1<<<1] <= -1;
            
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) edge_capture[3] <= 0;
        else if (clk_en) 
          if (edge_capture_wr_strobe) edge_capture[3] <= 0;
          else if (edge_detect[3]) edge_capture[3] <= -1;
            
          
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
  assign edge_detect = d2_data_in & ~d1_data_in;
endmodule

