module sd_host_phy (
  input                     clk,                    
  input                     rst,                    
  input                     i_phy_crc_enable,       
  input                     i_phy_ddr_en,           
  input                     i_sd1_phy_flag,         
  input                     i_sd4_phy_flag,         
  input                     i_cmd_stb,              
  input       [39:0]        i_cmd,                  
  input                     i_rsp_long_flag,        
  output  reg               o_rsp_stb,              
  output      [135:0]       o_rsp,                  
  input                     i_data_en_stb,          
  output  reg               o_data_finish_ack_stb,  
  input                     i_h2s_fifo_ready,       
  output                    o_h2s_fifo_activate,    
  input       [23:0]        i_h2s_fifo_size,        
  output                    o_h2s_fifo_stb,         
  input       [31:0]        i_h2s_fifo_data,        
  input       [1:0]         i_s2h_fifo_ready,       
  output      [1:0]         o_s2h_fifo_activate,    
  input       [23:0]        i_s2h_fifo_size,        
  input                     i_s2h_fifo_stb,         
  output      [31:0]        o_s2h_fifo_data,        
  output                    o_interrupt             
);
localparam    IDLE              = 4'h0;              
localparam    SEND_COMMAND      = 4'h1;              
localparam    CMD_RESPONSE      = 4'h2;              
localparam    SEND_DATA         = 4'h1;              
localparam    READ_DATA         = 4'h2;              
reg           [3:0]         cmd_state;              
reg           [3:0]         data_state;             
always @ (posedge clk) begin
  o_rsp_stb                 <=  1'b0;               
  if (rst) begin
    cmd_state               <=  IDLE;               
  end
  else begin
    case (cmd_state)
      IDLE: begin
        if (i_cmd_stb) begin
        end
      end
      SEND_COMMAND: begin
      end
      CMD_RESPONSE: begin
      end
      default: begin
      end
    endcase
  end
end
always @ (posedge clk) begin
  o_data_finish_ack_stb     <=  1'b0;               
  if (rst) begin
    data_state              <=  IDLE;               
  end
  else begin
    case (data_state)
      IDLE: begin
        if (i_data_stb) begin
        end
      end
      SEND_DATA: begin
      end
      READ_DATA: begin
      end
      default: begin
      end
    endcase
  end
end
endmodule