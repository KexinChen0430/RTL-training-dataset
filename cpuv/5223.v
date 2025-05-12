module t (
   clk
);
   input clk; 
   localparam NO = 10;  
   struct packed {
      logic       e0;    
      logic [1:0] e1;    
      logic [3:0] e2;    
      logic [7:0] e3;    
   } struct_bg;  
   struct packed {
      logic       e0;    
      logic [0:1] e1;    
      logic [0:3] e2;    
      logic [0:7] e3;    
   } struct_lt;  
   localparam WS = 15;  
   integer cnt = 0; 
   always @ (posedge clk) begin
      cnt <= cnt + 1; 
   end
   always @ (posedge clk) begin
      if ((cnt[30:2] == NO) && (cnt[1:0] == 2'd0)) begin
         $write("*-* All Finished *-*\n"); 
         $finish; 
      end
   end
   always @ (posedge clk) begin
      if (cnt[1:0] == 2'd0) begin
         if      (cnt[30:2] == 0)  struct_bg <= {WS{1'bx}};
         else if (cnt[30:2] == 1)  struct_bg <= {WS{1'bx}};
      end else if (cnt[1:0] == 2'd1) begin
         if      (cnt[30:2] == 0)  begin end 
         else if (cnt[30:2] == 1)  struct_bg <= {WS{1'b1}}; 
      end else if (cnt[1:0] == 2'd2) begin
         if      (cnt[30:2] == 0)  begin if (struct_bg !== 15'bxxxxxxxxxxxxxxx) begin $display("%b", struct_bg); $stop(); end end
      end else if (cnt[1:0] == 2'd3) begin
         if      (cnt[30:2] == 0)  begin if (struct_bg !== {WS{1'bx}}) $stop(); end
      end
   end
   always @ (posedge clk) begin
      if (cnt[1:0] == 2'd0) begin
      end else if (cnt[1:0] == 2'd1) begin
      end else if (cnt[1:0] == 2'd2) begin
      end else if (cnt[1:0] == 2'd3) begin
      end
   end
endmodule