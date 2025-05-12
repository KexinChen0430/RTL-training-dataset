module x ( 
          a, b, c, 
          clk, reset_l, in_a, in_b, in_c 
          );
   input  clk, reset_l, in_a,in_b,in_c; 
   output a,b,c; 
   reg    a,b,c; 
   always @(posedge clk or negedge reset_l) begin
      if (!reset_l) begin 
         c <= 1; 
         a <= #1 0; 
         b <= #1 0; 
      end
      else begin 
         a <= in_a; 
         b <= in_b; 
         c <= in_c; 
      end
   end
   always @(posedge clk or negedge reset_l) begin
      casex ({reset_l,in_a}) 
        2'b1_x: begin 
           a <= in_a; 
           b <= in_b; 
           c <= in_c; 
        end
        2'b0_x: begin 
           c <= 1; 
           a <= #1 0; 
           b <= #1 0; 
        end
      endcase
   end
   always @(in_a or in_b or reset_l) begin
      casex ({reset_l,in_a}) 
        2'b1_x: begin 
           a  = in_a; 
           b  = in_b; 
        end
        2'b0_x: begin 
           c  = 1; 
           a  = 0; 
           b  = 0; 
        end
      endcase
   end
endmodule