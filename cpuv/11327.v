module sub(input clk, ref int vr, ref int va[2]); 
   always @(posedge clk) begin 
      vr <= 32'h987; 
      va[0] <= 32'ha98; 
      va[1] <= 32'ha9b; 
   end 
endmodule 