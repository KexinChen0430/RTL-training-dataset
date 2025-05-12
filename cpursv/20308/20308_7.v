
module axi_protocol_converter_v2_1_8_b2s_simple_fifo  #(parameter  C_WIDTH = 8, C_AWIDTH = 4, C_DEPTH = 16)
  (input  wire clk,
   input  wire rst,
   input  wire wr_en,
   input  wire rd_en,
   input  wire [C_WIDTH+(-1):0] din,
   output wire [C_WIDTH+(-1):0] dout,
   output wire a_full,
   output wire full,
   output wire a_empty,
   output wire empty);

  localparam [(-1)+C_AWIDTH:0]  C_EMPTY = ~0;
  localparam [(-1)+C_AWIDTH:0]  C_EMPTY_PRE = 0;
  localparam [(-1)+C_AWIDTH:0]  C_FULL = (-1)+C_EMPTY;
  localparam [(-1)+C_AWIDTH:0] 
       C_FULL_PRE = (C_DEPTH < 8) ? ((-1)+C_FULL) : (C_FULL+(0-(C_DEPTH/8)));
  reg  [C_WIDTH+(-1):0] memory[(-1)+C_DEPTH:0];
  reg  [(-1)+C_AWIDTH:0] cnt_read;

  
  always @(posedge clk)
      begin : BLKSRL
        integer i;

        if (wr_en) 
          begin
            for (i = 0; i < ((-1)+C_DEPTH); i = i+1)
                begin
                  memory[i+1] <= memory[i];
                end
            memory[0] <= din;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rst) cnt_read <= C_EMPTY;
        else if (!rd_en & wr_en) cnt_read <= 1'b1+cnt_read;
        else if (!wr_en & rd_en) cnt_read <= cnt_read+(-1'b1);
          
      end
  assign full = cnt_read == C_FULL;
  assign empty = cnt_read == C_EMPTY;
  assign a_full = (cnt_read != C_EMPTY) && (cnt_read >= C_FULL_PRE);
  assign a_empty = cnt_read == C_EMPTY_PRE;
  assign dout = (C_DEPTH == 1) ? memory[0] : memory[cnt_read];
endmodule

