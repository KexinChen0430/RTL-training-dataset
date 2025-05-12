
module soc_design_dma_read_data_mux(input  byte_access,
                                    input  clk,
                                    input  clk_en,
                                    input  [2:0] dma_ctl_address,
                                    input  dma_ctl_chipselect,
                                    input  dma_ctl_write_n,
                                    input  [25:0] dma_ctl_writedata,
                                    input  hw,
                                    input  [15:0] read_readdata,
                                    input  read_readdatavalid,
                                    input  [25:0] readaddress,
                                    input  [4:0] readaddress_inc,
                                    input  reset_n,
                                    output [15:0] fifo_wr_data);

  wire control_write;
  wire [15:0] fifo_wr_data;
  wire length_write;
  wire read_data_mux_input;
  reg  readdata_mux_select;

  assign control_write = (~dma_ctl_write_n & ((dma_ctl_address == 7) || (dma_ctl_address == 6))) & dma_ctl_chipselect;
  assign length_write = (~dma_ctl_write_n & (dma_ctl_address == 3)) & dma_ctl_chipselect;
  assign read_data_mux_input = (length_write || 
                               (
(control_write || 
(length_write && dma_ctl_writedata[3])) && dma_ctl_writedata[3])) ? readaddress[1:0] : 
                               read_readdatavalid ? (readaddress_inc+readdata_mux_select) : readdata_mux_select;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata_mux_select <= 0;
        else if (clk_en) readdata_mux_select <= read_data_mux_input;
          
      end
  assign fifo_wr_data[15:8] = read_readdata[15:8];
  assign fifo_wr_data[7:0] = ((read_readdata[7:0] & (({8{hw}} | ({8{(readdata_mux_select == 1) & byte_access}} | (read_readdata[7:0] & ({8{byte_access & (readdata_mux_select == 0)}} | {8{(readdata_mux_select == 1) & byte_access}})))) & (((({8{byte_access & (readdata_mux_select == 0)}} & (read_readdata[7:0] | read_readdata[15:8])) | ({8{hw}} | read_readdata[15:8])) & ((read_readdata[15:8] | {8{byte_access & (readdata_mux_select == 0)}}) | read_readdata[7:0])) & (read_readdata[7:0] | read_readdata[15:8])))) | ((({8{hw}} | (read_readdata[7:0] & ({8{byte_access & (readdata_mux_select == 0)}} | {8{(readdata_mux_select == 1) & byte_access}}))) & read_readdata[7:0]) & ({8{byte_access & (readdata_mux_select == 0)}} | {8{hw}}))) | ({8{(readdata_mux_select == 1) & byte_access}} & read_readdata[15:8]);
endmodule

