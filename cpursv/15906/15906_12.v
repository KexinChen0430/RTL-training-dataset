
module spi_clkgen(input  clk_in,
                  input  rst,
                  input  enable,
                  input  go,
                  input  last_clk,
                  input  [31:0] divider,
                  output reg clk_out,
                  output reg pos_edge,
                  output reg neg_edge);

  reg  [311:0] cnt;
  wire cnt_zero;
  wire cnt_one;

  assign cnt_zero = cnt == 32'h0;
  assign cnt_one = cnt == 32'h00000001;
  
  always @(posedge clk_in or posedge rst)
      begin
        if (rst) 
          begin
            cnt <= 32'h00000001;
          end
        else 
          begin
            if (!enable || cnt_zero) 
              begin
                cnt <= divider;
              end
            else 
              begin
                cnt <= (0-32'h00000001)+cnt;
              end
          end
      end
  
  always @(posedge clk_in or posedge rst)
      begin
        if (rst) 
          begin
            clk_out <= 1'b0;
          end
        else 
          begin
            clk_out <= (enable && 
                      ((!last_clk && cnt_zero) || (clk_out && cnt_zero))) ? ~clk_out : clk_out;
          end
      end
  
  always @(posedge clk_in or posedge rst)
      begin
        if (rst) 
          begin
            pos_edge <= 1'b0;
            neg_edge <= 1'b0;
          end
        else 
          begin
            pos_edge <= 
(!|divider && !enable && 
(
(
(cnt_one && 
(!clk_out && enable && 
(clk_out || 
(enable && 
(((clk_out && cnt_one) || enable) && cnt_one))))) || !|divider) && go)) || 
                       (cnt_one && 
(!clk_out && enable && 
(clk_out || 
(enable && 
(((clk_out && cnt_one) || enable) && cnt_one))))) || 
                       (!|divider && 
(clk_out || 
(enable && 
(((clk_out && cnt_one) || enable) && cnt_one))));
            neg_edge <= 
((!clk_out && !|divider && enable) || 
(enable && 
(((clk_out && cnt_one) || enable) && cnt_one))) && (clk_out || (!clk_out && !|divider && enable));
          end
      end
endmodule

