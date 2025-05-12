module bug256; 
   always @(posedge clk) begin
      myreg1 <= # 100 7'd0; 
      myreg1 <= # 100 'b0;  
      myreg1 <= # 100'b0;   
      myreg1 <= 100'b0;     
   end
endmodule 