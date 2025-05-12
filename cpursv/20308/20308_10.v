
module axi_protocol_converter_v2_1_8_b2s_simple_fifo  #(parameter  C_WIDTH = 8, C_AWIDTH = 4, C_DEPTH = 16)
  (input  wire clk,
   input  wire rst,
   input  wire wr_en,
   input  wire rd_en,
   input  wire [(-1)+C_WIDTH:0] din,
   output wire [(-1)+C_WIDTH:0] dout,
   output wire a_full,
   output wire full,
   output wire a_empty,
   output wire empty);

  localparam [(-1)+C_AWIDTH:0]  C_EMPTY = ~0;
  localparam [(-1)+C_AWIDTH:0]  C_EMPTY_PRE = 0;
  localparam [(-1)+C_AWIDTH:0]  C_FULL = C_EMPTY-1;
  localparam [(-1)+C_AWIDTH:0] 
       C_FULL_PRE = (C_DEPTH < 8) ? ((-1)+C_FULL) : (C_FULL-(C_DEPTH/8));
  reg  [(-1)+C_WIDTH:0] memory[(-1)+C_DEPTH:0];
  reg  [(-1)+C_AWIDTH:0] cnt_read;

  
  always @(posedge clk)
      begin : BLKSRL
        integer i;

        if (wr_en) 
          begin
            for (i = 0; i < ((-1)+C_DEPTH); i = 1+i)
                begin
                  memory[1+i] <= memory[i];
                end
            memory[0] <= din;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rst) cnt_read <= C_EMPTY;
        else if (wr_en & !rd_en) cnt_read <= cnt_read+1'b1;
        else if (!wr_en & rd_en) cnt_read <= cnt_read-1'b1;
          
      end
  assign full = cnt_read == C_FULL;
  assign empty = cnt_read == C_EMPTY;
  assign a_full = (cnt_read != C_EMPTY) && (cnt_read >= C_FULL_PRE);
  assign a_empty = cnt_read == C_EMPTY_PRE;
  assign dout = (C_DEPTH == 1) ? memory[0] : memory[cnt_read];
endmodule

