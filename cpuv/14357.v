module bug33; 
   integer i; 
   initial begin 
      unique case (i) 
      endcase 
      priority case (i) 
      endcase 
      if (i) begin end 
      else begin end 
   end 
endmodule 