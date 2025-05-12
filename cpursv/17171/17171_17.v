
module ycbcr_to_rgb(y,cb,cr,red,green,blue,clk);

  input  clk;
  input  [7:0] y,cb,cr;
  output reg [7:0] red,green,blue;
  reg  signed  [8:0] adj_y,adj_cb,adj_cr;

  
  always @(posedge clk)
      begin
        adj_y <= y;
        adj_cr <= (0-8'd128)+cr;
        adj_cb <= (0-8'd128)+cb;
      end
  wire signed  [8:0]  const0 = 9'd128;

  wire signed  [8:0]  const1 = 9'd179;

  wire signed  [8:0]  const2 = -9'd91;

  wire signed  [8:0]  const3 = -9'd44;

  wire signed  [8:0]  const4 = 9'd227;

  reg  signed  [17:0] product_a,product_b,product_c,product_d,product_e;

  
  always @(posedge clk)
      begin
        product_a <= const0*adj_y;
        product_b <= const1*adj_cr;
        product_c <= adj_cr*const2;
        product_d <= adj_cb*const3;
        product_e <= const4*adj_cb;
      end
  reg  signed  [17:0] sum_red,sum_green,sum_blue;

  
  always @(posedge clk)
      begin
        sum_red <= product_b+product_a;
        sum_green <= (product_a+product_d)+product_c;
        sum_blue <= product_a+product_e;
      end
  
  always @(posedge clk)
      begin
        red <= sum_red[17] ? 8'h0 : 
              (sum_red[15] | sum_red[16]) ? 8'hff : sum_red[14:7];
        green <= sum_green[17] ? 8'h0 : 
                (sum_green[15] | sum_green[16]) ? 8'hff : sum_green[14:7];
        blue <= sum_blue[17] ? 8'h0 : 
               (sum_blue[15] | sum_blue[16]) ? 8'hff : sum_blue[14:7];
      end
endmodule

