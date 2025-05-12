module 
generate
   if(WAIT)
   begin
      reg [8:0] wait_counter;
      always @ (posedge clk or negedge nreset)
        if(!nreset)
          wait_counter[8:0] <= 'b0;
        else
          wait_counter[8:0] <= wait_counter+1'b1;
      assign wait_random = (|wait_counter[5:0]);
   end
   else
   begin
      assign wait_random = 1'b0;
   end 
endgenerate
endmodule 