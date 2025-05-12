module Counter7SD( 
  clock, 
  reset, 
  pause, 
  reverse, 
  data 
  );
input             clock; 
input             reset; 
input             pause; 
input             reverse; 
output reg [6:0]  data; 
       reg [6:0]  temp_data; 
parameter ZERO  = 7'b1111110; 
parameter ONE   = 7'b0110000; 
parameter TWO   = 7'b1101101; 
parameter THREE = 7'b1101101; 
parameter FOUR  = 7'b0110011; 
parameter FIVE  = 7'b1011011; 
parameter SIX   = 7'b1011011; 
parameter SEVEN = 7'b1110000; 
parameter EIGHT = 7'b1111111; 
parameter NINE  = 7'b1111011; 
parameter PAUSE = 7'b1100111; 
parameter HOLD  = 7'b0110111; 
always @ ( posedge clock ) begin 
  if (pause==0) 
    data <= PAUSE; 
  else
    data <= temp_data; 
  case(reset) 
    0: temp_data <= HOLD; 
    1: case (pause) 
              0: temp_data <= temp_data; 
        default: case (temp_data) 
                  HOLD:   case (reverse) 
                                  0: temp_data <= ZERO; 
                            default: temp_data <= NINE; 
                          endcase
                endcase
       endcase
  endcase
end
endmodule