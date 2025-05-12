module spi_data_reader (
   input             clk,
   input             calib_done,
   input             sclk_posedge,
   input             sclk_negedge,
   input [6:0]       block_addr,
   input             en,
   input             in,
   output reg        error,
   output            done,
   output reg        mem_cmd_en,
   output [2:0]      mem_cmd_instr,
   output [5:0]      mem_cmd_bl,
   output reg [29:0] mem_cmd_byte_addr,
   input             mem_cmd_empty,
   input             mem_cmd_full,
   output reg        mem_wr_en,
   output [3:0]      mem_wr_mask,
   output reg [31:0] mem_wr_data,
   input             mem_wr_full,
   input             mem_wr_empty,
   input [6:0]       mem_wr_count,
   input             mem_wr_underrun,
   input             mem_wr_error
);
initial begin
   error = 0;
   mem_cmd_en = 0;
   mem_wr_en = 0;
end
assign mem_cmd_instr = 3'b000;
assign mem_cmd_bl = 6'b011111;
assign mem_wr_mask = 4'b0000;
reg [2:0] bit_counter = 7;
always @ (posedge clk) begin
   if (sclk_negedge) begin
      bit_counter <= bit_counter - 1;
   end
end
reg [7:0] cur_byte = 8'hFF;
reg       cur_byte_valid = 0;
always @ (posedge clk) begin
   cur_byte_valid <= 0;
   if (sclk_posedge) begin
      cur_byte[bit_counter] <= in;
      if (0 == bit_counter) begin
         cur_byte_valid <= 1;
      end
   end
end
localparam STATE_IDLE  = 0;
localparam STATE_TOKEN = 1;
localparam STATE_BLOCK = 2;
localparam STATE_CRC   = 3;
localparam STATE_FLUSH = 4;
localparam STATE_ERROR = 5;
reg [2:0]                    state = STATE_IDLE;
reg [8:0]                    byte_counter = 0;
reg                          crc_counter = 0;
reg [6:0]                    block_addr_reg = 0;
assign done = (STATE_IDLE == state) && !en;
always @ (posedge clk) begin
   mem_cmd_en <= 0;
   mem_wr_en <= 0;
   case (state)
      STATE_IDLE: begin
         if (en) begin
            state <= STATE_TOKEN;
            byte_counter <= 0;
            crc_counter <= 0;
            block_addr_reg <= block_addr;
         end
      end
      STATE_TOKEN: begin
         if (cur_byte_valid) begin
            if (8'hFE == cur_byte) begin
               state <= STATE_BLOCK;
            end else if (3'b000 == cur_byte[7:5]) begin
               state <= STATE_ERROR;
            end
         end
      end
      STATE_BLOCK: begin
         if (cur_byte_valid) begin
            mem_wr_data <= { mem_wr_data[23:0], cur_byte };
            if (3 == byte_counter[1:0]) begin
               mem_wr_en <= 1;
            end
            if (127 == byte_counter[6:0]) begin
               mem_cmd_en <= 1;
               mem_cmd_byte_addr <= { `MAIN_MEM_PREFIX, block_addr_reg,
                                      byte_counter[8:7], 7'b0 };
            end
            if (511 == byte_counter) begin
               state <= STATE_CRC;
            end else begin
               byte_counter <= byte_counter + 1;
            end
         end
      end
      STATE_CRC: begin
         if (cur_byte_valid) begin
            if (crc_counter) begin
               state <= STATE_FLUSH;
            end
            crc_counter <= ~crc_counter;
         end
      end
      STATE_FLUSH: begin
         if (mem_wr_empty) begin
            state <= STATE_IDLE;
         end
      end
      STATE_ERROR: begin
         error <= 1;
      end
   endcase
   if (calib_done && (mem_wr_error || mem_wr_underrun)) begin
      state <= STATE_ERROR;
   end
end
endmodule