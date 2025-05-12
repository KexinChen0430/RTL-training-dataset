module sequence_detector(request,clear,switch,clock);
    output reg request;
     input clear,switch,clock;
     reg [1:0] state;
     parameter state_a=0, state_b=1,state_c=3;
     initial begin
         state <= state_a;
     end
     always @(posedge clock) begin
         case (state)
              state_a:
                    if (switch) begin
                        state <= state_b;
                     end
                state_b:
                    if (!switch) begin
                         state <= state_c;
                     end
                state_c:
                    if (clear) begin
                         request <= 0;
                         state <= state_a;
                     end
                     else
                         request <= 1;
          endcase
     end
endmodule