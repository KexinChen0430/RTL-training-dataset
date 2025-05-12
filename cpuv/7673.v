module spi_receiver
  (
   input                      clk,
   input                      sclk_posedge,
   input                      sclk_negedge,
   input                      reset,
   input                      en,
   input                      in,
   output reg [DATA_BITS-1:0] out,
   output                     done
   );
   initial begin
      out = 0;
   end
   parameter DATA_BITS = 8;
   reg [2:0] bit_counter = 7;
   always @ (posedge clk) begin
      if (sclk_negedge) begin
         bit_counter <= bit_counter - 1;
      end
   end
   localparam STATE_IDLE    = 0;
   localparam STATE_SYNC    = 1;
   localparam STATE_ENABLED = 2;
   reg [1:0]                   state = STATE_IDLE;
   reg [$clog2(DATA_BITS)-1:0] counter = 0;
   reg [DATA_BITS-1:0]         next_out = 0;
   assign done = (STATE_IDLE == state) && !en;
   always @ (posedge clk) begin
      if (reset) begin
         state <= STATE_IDLE;
      end else begin
         case (state)
            STATE_IDLE: begin
               if (en) begin
                  out <= 0;
                  state <= STATE_SYNC;
                  counter <= 0;
               end
            end
            STATE_SYNC: begin
               if (7 == bit_counter) begin
                  state <= STATE_ENABLED;
               end
            end
            STATE_ENABLED: begin
               if (sclk_posedge) begin
                  next_out = { out[DATA_BITS-2:0], in };
                  out <= next_out;
                  if (counter == 7 &&
                      next_out[7:0] == 8'hFF) begin
                     counter <= 0;
                  end else if (counter == DATA_BITS - 1) begin
                     state <= STATE_IDLE;
                  end else begin
                     counter <= counter + 1;
                  end
               end
            end
         endcase
      end
   end
endmodule