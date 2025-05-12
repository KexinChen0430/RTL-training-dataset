
module multiplier(clk,sign,enable,multi_1,multi_2,product,multready);

  input  clk,sign,enable;
  input  [31:0] multi_1,multi_2;
  output [63:0] product;
  output multready;
  reg  [63:0] product,product_temp;
  reg  [31:0] multi_1_copy;
  reg  [63:0] multi_2_copy;
  reg  neg_output;
  reg  [6:0] i;

  
  initial  
  begin
    product = 64'b0;
    product_temp = 64'b0;
    multi_1_copy = 32'b0;
    multi_2_copy = 64'b0;
    neg_output = 1'b0;
    i = 7'd32;
  end
  assign multready = !i;
  
  always @(posedge clk)
      begin
        if (enable & (i == 7'd32)) 
          begin
            multi_2_copy <= (sign && 
                           (multi_2[31] && ((multi_1[31] && ~multi_2[31]) || sign))) ? {32'd0,1'b1+~multi_2} : {32'd0,multi_2};
            multi_1_copy <= (sign && multi_1[31]) ? (1'b1+~multi_1) : multi_1;
            neg_output <= 
(
(~multi_1[31] && 
(
(multi_1[31] || 
(~multi_1[31] && (multi_2[31] || multi_1[31]))) && multi_2[31])) || sign) && 
                         ((multi_1[31] && ~multi_2[31]) || 
(~multi_1[31] && (multi_2[31] || multi_1[31]) && 
(~multi_2[31] || multi_2[31]))) && 
                         (sign && (multi_2[31] || multi_1[31]) && 
(~multi_1[31] || (sign && multi_1[31])));
            i <= i+(0-1'b1);
          end
        else if ((enable & i) > 0) 
          begin
            if (multi_1_copy[0] == 1'b1) 
              begin
                product_temp <= multi_2_copy+product_temp;
              end
              
            multi_1_copy <= multi_1_copy>>1;
            multi_2_copy <= multi_2_copy*1<<<1;
            product <= neg_output ? (~product_temp+1'b1) : product_temp;
            i <= i+(0-1'b1);
          end
        else 
          begin
            product <= 64'b0;
            product_temp <= 64'b0;
            multi_1_copy <= 32'b0;
            multi_2_copy <= 64'b0;
            neg_output <= 1'b0;
            i <= 7'd32;
          end
      end
endmodule

