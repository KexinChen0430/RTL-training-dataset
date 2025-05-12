module sequencDetector(
    input in,          
    input reset,       
    input clock,       
    output reg out     
);
reg [2:0] state;      
parameter s0 = 3'b000, 
          s1 = 3'b001, 
          s2 = 3'b010, 
          s3 = 3'b011, 
          s4 = 3'b100, 
          s5 = 3'b101; 
always @(posedge clock)
begin
    if (reset)        
    begin
        state <= s0;  
        out  <= 0;    
    end
    else              
        case(state)   
            s0 : if (in)  { state <= s1; out <= 0; } 
                  else    { state <= s0; out <= 0; }
            s1 : if (in)  { state <= s1; out <= 0; } 
                  else    { state <= s2; out <= 0; }
            s2 : if (in)  { state <= s1; out <= 0; } 
                  else    { state <= s3; out <= 0; }
            s3 : if (in)  { state <= s1; out <= 0; } 
                  else    { state <= s4; out <= 0; }
            s4 : if (in)  { state <= s5; out <= 1; } 
                  else    { state <= s0; out <= 0; } 
            s5 : if (in)  { state <= s1; out <= 0; } 
                  else    { state <= s2; out <= 0; }
            default:      { state <= s0; out <= 0; } 
        endcase
end
endmodule 