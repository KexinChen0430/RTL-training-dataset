module 
generate
   if(WAIT)
   begin
      reg [15:0] stall_counter;
      always @ (posedge clk or negedge nreset)
        if(!nreset)
          stall_counter[15:0] <= 'b0;
        else
          stall_counter[15:0] <= stall_counter+1'b1;
      assign stall_random = (|stall_counter[6:0]);
   end
   else
   begin
      assign stall_random = 1'b0;
   end 
endgenerate
endmodule 