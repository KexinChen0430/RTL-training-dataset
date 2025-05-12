module spi_clgen (clk_in, rst, go, enable, last_clk, divider, clk_out, pos_edge, neg_edge);
  input                            clk_in;   
  input                            rst;      
  input                            enable;   
  input                            go;       
  input                            last_clk; 
  input     [`SPI_DIVIDER_LEN-1:0] divider;  
  output                           clk_out;  
  output                           pos_edge; 
  output                           neg_edge; 
  reg                              clk_out;  
  reg                              pos_edge; 
  reg                              neg_edge; 
  reg       [`SPI_DIVIDER_LEN-1:0] cnt;      
  wire                             cnt_zero; 
  wire                             cnt_one;  
  assign cnt_zero = cnt == {`SPI_DIVIDER_LEN{1'b0}};
  assign cnt_one  = cnt == {{`SPI_DIVIDER_LEN-1{1'b0}}, 1'b1};
  always @(posedge clk_in)
  begin
    if(rst)
      cnt <= {`SPI_DIVIDER_LEN{1'b1}}; 
    else
      begin
        if(!enable || cnt_zero)
          cnt <= divider; 
        else
          cnt <= cnt - {{`SPI_DIVIDER_LEN-1{1'b0}}, 1'b1}; 
      end
  end
  always @(posedge clk_in)
  begin
    if(rst)
      clk_out <= 1'b0; 
    else
      clk_out <= (enable && cnt_zero && (!last_clk || clk_out)) ? ~clk_out : clk_out;
  end
  always @(posedge clk_in)
  begin
    if(rst)
      begin
        pos_edge  <= 1'b0; 
        neg_edge  <= 1'b0; 
      end
    else
      begin
        pos_edge  <= (enable && !clk_out && cnt_one) || (!(|divider) && clk_out) || (!(|divider) && go && !enable);
        neg_edge  <= (enable && clk_out && cnt_one) || (!(|divider) && !clk_out && enable);
      end
  end
endmodule