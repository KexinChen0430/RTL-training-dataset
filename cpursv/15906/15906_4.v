
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
            if (cnt_zero || !enable) 
              begin
                cnt <= divider;
              end
            else 
              begin
                cnt <= (-32'h00000001)+cnt;
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
            clk_out <= (
(!last_clk || 
(((cnt_one && clk_out) || enable) && cnt_zero && enable && 
clk_out)) && 
                      (((cnt_one && clk_out) || enable) && cnt_zero && enable)) ? ~clk_out : clk_out;
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
(!clk_out || (clk_out && !|divider) || 
(go && !enable && 
(
(!|divider || 
(((cnt_one && clk_out) || enable) && !clk_out && enable) || (!|divider && go)) && ((!|divider && go) || (!|divider || cnt_one))) && !|divider)) && 
                       (
((cnt_one || (clk_out && !|divider)) && 
(enable || 
((enable && (cnt_one && clk_out)) || 
(clk_out && !|divider)))) || 
(go && !enable && 
(
(!|divider || 
(((cnt_one && clk_out) || enable) && !clk_out && enable) || (!|divider && go)) && ((!|divider && go) || (!|divider || cnt_one))) && !|divider));
            neg_edge <= (enable || cnt_one) && 
                       (cnt_one || (!clk_out && !|divider)) && 
                       (enable && 
((clk_out || (!clk_out && !|divider)) && 
(
(((enable && (cnt_one && clk_out)) || !|divider) && 
(!clk_out || (enable && (cnt_one && clk_out)))) || enable)));
          end
      end
endmodule

