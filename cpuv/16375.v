module pcie_egress (
  input                     clk,                  
  input                     rst,                  
  input                     i_enable,             
  output reg                o_finished,           
  input      [7:0]          i_command,            
  input      [13:0]         i_flags,              
  input      [31:0]         i_address,            
  input      [15:0]         i_requester_id,       
  input      [7:0]          i_tag,                
  input      [9:0]          i_req_dword_cnt,      
  input                     i_axi_egress_ready,   
  output     [31:0]         o_axi_egress_data,    
  output     [3:0]          o_axi_egress_keep,    
  output reg                o_axi_egress_last,    
  output reg                o_axi_egress_valid,   
  input                     i_fifo_rdy,           
  output reg                o_fifo_act,           
  input      [23:0]         i_fifo_size,          
  input      [31:0]         i_fifo_data,          
  output reg                o_fifo_stb,           
  output reg                dbg_ready_drop        
);
localparam  IDLE                    = 4'h0;
localparam  WAIT_FOR_FIFO           = 4'h1;
localparam  WAIT_FOR_PCIE_CORE      = 4'h2;
localparam  SEND_HDR                = 4'h3;
localparam  SEND_DATA               = 4'h4;
localparam  SEND_NON_DATA_PKT_START = 4'h5;
localparam  SEND_NON_DATA_PKT       = 4'h6;
localparam  SEND_NON_DATA_PKT_FIN   = 4'h7;
localparam  FINISHED                = 4'h8;
reg   [3:0]                 state;                
reg   [23:0]                r_data_count;         
wire  [31:0]                w_hdr[0:3];           
wire  [2:0]                 w_hdr_size;           
reg   [2:0]                 r_hdr_index;          
wire  [9:0]                 w_pkt_data_count;     
wire  [31:0]                w_hdr0;               
wire  [31:0]                w_hdr1;               
wire  [31:0]                w_hdr2;               
wire  [31:0]                w_hdr3;               
wire                        w_non_data_packet;    
assign o_axi_egress_keep = 4'hF; 
assign w_non_data_packet = (i_command == `PCIE_MRD_32B);
assign w_pkt_data_count = (i_command == `PCIE_MRD_32B) ? i_req_dword_cnt : i_fifo_size;
assign w_hdr[0][`PCIE_TYPE_RANGE] = i_command;
assign w_hdr[0][`PCIE_FLAGS_RANGE] = i_flags;
assign w_hdr[0][`PCIE_DWORD_PKT_CNT_RANGE] = w_pkt_data_count;
assign w_hdr[1] = (i_command == `PCIE_MRD_32B) ? {i_requester_id, i_tag, 8'h00} :
                  (i_fifo_size == 1) ? 32'h0000000F : 
                                       32'h000000FF;  
assign w_hdr[2] = i_address;
assign w_hdr_size = (w_hdr[0][29]) ? 3'h4 : 3'h3;
assign w_hdr0 = w_hdr[0];
assign w_hdr1 = w_hdr[1];
assign w_hdr2 = w_hdr[2];
assign o_axi_egress_data = ((state == WAIT_FOR_PCIE_CORE) || (state == SEND_HDR) || (state == SEND_NON_DATA_PKT) || (state == SEND_NON_DATA_PKT_FIN)) ? w_hdr[r_hdr_index] : i_fifo_data;
always @(posedge clk) begin
  o_fifo_stb <= 0;
  dbg_ready_drop <= 0;
  if (rst) begin
    state <= IDLE;
    o_finished <= 0;
    r_hdr_index <= 0;
    o_axi_egress_valid <= 0;
    o_axi_egress_last <= 0;
    o_fifo_act <= 0;
    r_data_count <= 0;
  end else begin
    case (state)
      IDLE: begin
        o_axi_egress_valid <= 0;
        o_finished <= 0;
        r_data_count <= 0;
        r_hdr_index <= 0;
        if (i_enable) begin
          if (w_non_data_packet) begin
            state <= SEND_NON_DATA_PKT_START;
          end else begin
            state <= WAIT_FOR_FIFO;
          end
        end
      end
      WAIT_FOR_FIFO: begin
        if (i_fifo_rdy && !o_fifo_act) begin
          r_data_count <= 0;
          o_fifo_act <= 1;
          state <= WAIT_FOR_PCIE_CORE;
        end
      end
      WAIT_FOR_PCIE_CORE: begin
        if (i_axi_egress_ready && o_axi_egress_valid) begin
          r_hdr_index <= r_hdr_index + 1;
          if (r_hdr_index + 1 >= w_hdr_size) begin
            if (w_non_data_packet) begin
              o_axi_egress_last <= 1;
              state <= FINISHED;
            end else begin
              state <= SEND_DATA;
              o_fifo_stb <= 1;
              r_data_count <= r_data_count + 1;
            end
          end
        end
        o_axi_egress_valid <= 1;
      end
      SEND_DATA: begin
        o_fifo_stb <= 1;
        if (r_data_count + 1 >= i_fifo_size) begin
          state <= FINISHED;
          o_axi_egress_last <= 1;
        end
        r_data_count <= r_data_count + 1;
      end
      SEND_NON_DATA_PKT_START: begin
        if (i_axi_egress_ready) begin
          state <= SEND_NON_DATA_PKT;
        end
      end
      SEND_NON_DATA_PKT: begin
        if (o_axi_egress_valid) begin
          if (!i_axi_egress_ready) begin
            dbg_ready_drop <= 1;
          end
          r_hdr_index <= r_hdr_index + 1;
          if (r_hdr_index + 2 >= w_hdr_size) begin
            o_axi_egress_last <= 1;
            state <= SEND_NON_DATA_PKT_FIN;
          end
        end
        o_axi_egress_valid <= 1;
      end
      SEND_NON_DATA_PKT_FIN: begin
        o_axi_egress_valid <= 0;
        o_axi_egress_last <= 0;
        o_fifo_act <= 0;
        state <= FINISHED;
      end
      FINISHED: begin
        o_axi_egress_valid <= 0;
        o_axi_egress_last <= 0;
        o_fifo_act <= 0;
        o_finished <= 1;
        if (!i_enable) begin
          o_finished <= 0;
          state <= IDLE;
        end
      end
      default: begin
        state <= IDLE;
      end
    endcase
  end
end
endmodule