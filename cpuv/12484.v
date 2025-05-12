module ddr_interfacing(
)
  wire sys_clk;
  wire idly_clk_200;
  wire error_cmp;
  wire rst0;
  wire rst90;
  wire rstdiv0;
  wire rst200;
  wire clk0;
  wire clk90;
  wire clkdiv0;
  wire clk200;
  wire idelay_ctrl_rdy;
  wire app_wdf_afull;
  wire app_af_afull;
  wire rd_data_valid;
  wire app_wdf_wren;
  wire app_af_wren;
  wire [30:0] app_af_addr;
  wire [2:0] app_af_cmd;
  wire [(APPDATA_WIDTH)-1:0] rd_data_fifo_out;
  wire [(APPDATA_WIDTH)-1:0] app_wdf_data;
  wire [(APPDATA_WIDTH/8)-1:0] app_wdf_mask_data;
  reg [3:0] count = 0;
  always @(posedge clk0) begin
    app_af_cmd <= 3'b000; 
    if(!app_af_afull) begin
        case (count)
            0 : app_af_addr <= 32;  
            1 : app_af_wren <= 1;   
            2 : app_af_wren <= 0;   
        endcase
    end
    if(!app_wdf_afull) begin
      case (count)
        0 : app_wdf_data <= 32;       
            app_wdf_mask_data <= 0x1; 
        1 : app_wdf_wren <= 1;        
        2 : app_wdf_wren <= 0;        
      endcase
    end
    count <= count + 1;
  end
endmodule