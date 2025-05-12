
module my_module();

  wire d_k;

  
  generate
      if (MODE == 1) 
        begin
          assign d_k = z_k[ADDRESS_WIDTH];
        end
      else 
        begin
          assign d_k = ~((((x_k[ADDRESS_WIDTH] | (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH]))) & (((~x_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH])))) | (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH])) & (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH])))) & ~((x_k[ADDRESS_WIDTH] & ((~x_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH])))) | (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH]))) & (x_k[ADDRESS_WIDTH] | (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH]))))) | (~((x_k[ADDRESS_WIDTH] | (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH]))) & (((~x_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH])))) | (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH])) & (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH])))) & ((x_k[ADDRESS_WIDTH] & ((~x_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH])))) | (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH]))) & (x_k[ADDRESS_WIDTH] | (y_k[ADDRESS_WIDTH] & (x_k[ADDRESS_WIDTH] | ~x_k[ADDRESS_WIDTH]))))));
        end
  endgenerate

  
  always @(posedge CLK or negedge RESET_n)
      begin
        if (!RESET_n) 
          begin
            z_k1 <= {ADDRESS_WIDTH{1'b0}};
          end
        else if (d_k == 1'b0) 
          begin
            z_k1 <= z_k-{1'b0,e_k};
          end
        else 
          begin
            z_k1 <= z_k+{1'b0,e_k};
          end
      end
  
  always @(posedge CLK or negedge RESET_n)
      begin
        if (!RESET_n) 
          begin
            x_k1 <= {VALUE_WIDTH{1'b0}};
          end
        else if (d_k == 1'b0) 
          begin
            x_k1 <= x_k-y_k>>>ORDER;
          end
        else 
          begin
            x_k1 <= y_k>>>ORDER+x_k;
          end
      end
  
  always @(posedge CLK or negedge RESET_n)
      begin
        if (!RESET_n) 
          begin
            y_k1 <= {VALUE_WIDTH{1'b0}};
          end
        else if (d_k == 1'b0) 
          begin
            y_k1 <= x_k>>>ORDER+y_k;
          end
        else 
          begin
            y_k1 <= y_k+(-x_k>>>ORDER);
          end
      end
endmodule

