module testmod ();
   always_comb begin
      unique case (eeee)
        ZERO[1:0] : begin
           a  = 1;
        end 
        ONE[1:0] : begin
           a  = 1;
        end 
        TWO[1:0] : begin
           a  = 1;
        end 
        THREE[1:0] : begin
           a  = 1;
        end 
      endcase 
   end 
   always_ff @ (posedge clk) begin
      if (reset) begin
         current_state <= `TQ STATE0;
      end 
      else begin
         priority case (current_state)
           STATE0 : begin
              current_state <= `TQ STATE3;
           end 
           STATE1 : begin
              current_state <= `TQ STATE3;
           end 
           STATE2 : begin
              current_state <= `TQ STATE3;
           end 
           STATE3 : begin
              current_state <= `TQ STATE0;
           end 
           default : current_state <= `TQ STATE0;
         endcase 
      end 
   end 
endmodule