module udp_reg_master
   #(
      parameter SRC_ADDR = 0, 
      parameter TIMEOUT = 127, 
      parameter TIMEOUT_RESULT = 'h dead_0000, 
      parameter UDP_REG_SRC_WIDTH = 2 
   )
   (
      input                                  core_reg_req, 
      output reg                             core_reg_ack, 
      input                                  core_reg_rd_wr_L, 
      input [`UDP_REG_ADDR_WIDTH - 1:0]      core_reg_addr, 
      output reg [`CPCI_NF2_DATA_WIDTH - 1:0]core_reg_rd_data, 
      input [`CPCI_NF2_DATA_WIDTH - 1:0]     core_reg_wr_data, 
      output reg                             reg_req_out, 
      output reg                             reg_ack_out, 
      output reg                             reg_rd_wr_L_out, 
      output reg [`UDP_REG_ADDR_WIDTH - 1:0] reg_addr_out, 
      output reg [`CPCI_NF2_DATA_WIDTH - 1:0] reg_data_out, 
      output reg [UDP_REG_SRC_WIDTH - 1:0]   reg_src_out, 
      input                                  reg_req_in, 
      input                                  reg_ack_in, 
      input                                  reg_rd_wr_L_in, 
      input [`UDP_REG_ADDR_WIDTH - 1:0]      reg_addr_in, 
      input [`CPCI_NF2_DATA_WIDTH - 1:0]     reg_data_in, 
      input [UDP_REG_SRC_WIDTH - 1:0]        reg_src_in, 
      input                                  clk, 
      input                                  reset 
   );
localparam WAIT         = 'd0; 
localparam PROCESSING   = 'd1; 
localparam DONE         = 'd2; 
reg [1:0] state; 
reg [7:0] count; 
wire result_valid = reg_req_in && reg_src_in == SRC_ADDR; 
always @(posedge clk)
begin
   if (reset) begin
      core_reg_ack <= 1'b0; 
      core_reg_rd_data <= 'h0; 
      state <= WAIT; 
      count <= 'h0; 
   end
   else begin
      case (state)
         WAIT : begin
            if (core_reg_req && !reg_req_in) begin
               state <= PROCESSING; 
               count <= TIMEOUT; 
            end
         end
         PROCESSING : begin
            if (!core_reg_req) begin
               state <= WAIT; 
            end
            else if (result_valid || count == 'h0) begin
               state <= DONE; 
               core_reg_ack <= 1'b1; 
               if (result_valid && reg_ack_in)
                  core_reg_rd_data <= reg_data_in; 
               else if (count == 'h0)
                  core_reg_rd_data <= TIMEOUT_RESULT; 
               else
                  core_reg_rd_data <= 'h dead_beef; 
            end
            count <= count - 'h1; 
         end
         DONE : begin
            core_reg_ack <= 1'b0; 
            if (!core_reg_req)
               state <= WAIT; 
         end
         default : begin
            if ($time > 3000)
               $display($time, " ERROR: invalid state: %x", state); 
         end
      endcase
   end
end
always @(posedge clk)
begin
   if (reset) begin
      reg_req_out <= 1'b0; 
      reg_ack_out <= 1'b0; 
      reg_rd_wr_L_out <= 1'b0; 
      reg_addr_out <= 'h0; 
      reg_data_out <= 'h0; 
      reg_src_out <= 'h0; 
   end
   else begin
      if (reg_req_in && reg_src_in != SRC_ADDR) begin
         reg_req_out <= reg_req_in; 
         reg_ack_out <= reg_ack_in; 
         reg_rd_wr_L_out <= reg_rd_wr_L_in; 
         reg_addr_out <= reg_addr_in; 
         reg_data_out <= reg_data_in; 
         reg_src_out <= reg_src_in; 
      end
      else if (state == WAIT && core_reg_req && !reg_req_in) begin
         reg_req_out <= 1'b1; 
         reg_ack_out <= 1'b0; 
         reg_rd_wr_L_out <= core_reg_rd_wr_L; 
         reg_addr_out <= core_reg_addr; 
         reg_data_out <= core_reg_wr_data; 
         reg_src_out <= SRC_ADDR; 
      end
      else begin
         reg_req_out <= 1'b0; 
         reg_ack_out <= 1'b0; 
         reg_rd_wr_L_out <= 1'b0; 
         reg_addr_out <= 'h0; 
         reg_data_out <= 'h0; 
         reg_src_out <= 'h0; 
      end
   end
end
endmodule