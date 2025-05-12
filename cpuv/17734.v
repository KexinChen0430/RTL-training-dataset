module t (
   clk
   );
   input clk; 
   localparam WA = 4;  
   localparam WB = 4;  
   localparam NO = 11; 
   logic [WA-1:0] [WB-1:0] array_bg;  
   logic [0:WA-1] [0:WB-1] array_lt;  
   integer cnt = 0; 
   always @ (posedge clk) begin
      cnt <= cnt + 1;
   end
   always @ (posedge clk)
   if ((cnt[30:2]==(NO-1)) && (cnt[1:0]==2'd3)) begin
      $write("*-* All Finished *-*\n"); 
      $finish; 
   end
   always @ (posedge clk)
   if (cnt[1:0]==2'd0) begin
      if      (cnt[30:2]== 0)  array_bg <= '0;
   end else if (cnt[1:0]==2'd1) begin
      if      (cnt[30:2]== 0)  begin end 
      else if (cnt[30:2]== 1)  array_bg <= '{ 3 ,2 ,1, 0 }; 
   end else if (cnt[1:0]==2'd2) begin
      if      (cnt[30:2]== 0)  begin if (array_bg !== 16'b0000000000000000) begin $display("%b", array_bg); $stop(); end end
   end
   always @ (posedge clk)
   if (cnt[1:0]==2'd0) begin
      if      (cnt[30:2]== 0)  array_lt <= '0;
   end else if (cnt[1:0]==2'd1) begin
      if      (cnt[30:2]== 0)  begin end 
      else if (cnt[30:2]== 1)  array_lt <= '{ 3 ,2 ,1, 0 }; 
   end else if (cnt[1:0]==2'd2) begin
      if      (cnt[30:2]== 0)  begin if (array_lt !== 16'b0000000000000000) begin $display("%b", array_lt); $stop(); end end
   end
endmodule