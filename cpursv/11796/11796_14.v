
module fifo_fwft_adapter  #(parameter  DATA_WIDTH = 0)
  (input  wire clk,
   input  wire rst,
   input  wire rd_en,
   input  wire fifo_empty,
   output wire fifo_rd_en,
   input  wire [(-1)+DATA_WIDTH:0] fifo_dout,
   output reg [(-1)+DATA_WIDTH:0] dout,
   output wire empty,
   output wire valid);

  reg  fifo_valid,middle_valid,dout_valid;
  reg  [(-1)+DATA_WIDTH:0] middle_dout;

  assign fifo_rd_en = !(dout_valid && middle_valid && fifo_valid) && 
                      !fifo_empty;
  assign empty = !dout_valid;
  assign valid = dout_valid;
  wire next_dout;

  assign next_dout = rd_en || !dout_valid;
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            fifo_valid <= 0;
            middle_valid <= 0;
            middle_dout <= 0;
            dout_valid <= 0;
            dout <= 0;
          end
        else 
          begin
            if (fifo_rd_en) fifo_valid <= 1;
            else if (next_dout || !middle_valid) fifo_valid <= 0;
              
            if (middle_valid == next_dout) 
              begin
                middle_valid <= fifo_valid;
                middle_dout <= fifo_dout;
              end
              
            if (next_dout) 
              begin
                dout_valid <= fifo_valid || middle_valid;
                dout <= middle_valid ? middle_dout : fifo_dout;
              end
              
          end
      end
endmodule

