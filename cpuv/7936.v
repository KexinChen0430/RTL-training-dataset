module stop (clk, reset, primed, i_trigger, i_holdoff, stopped); 
input clk, reset, primed, i_trigger; 
input [(`HOLDOFF_WIDTH-1) : 0] i_holdoff; 
output reg stopped = 0; 
reg triggered = 0; 
reg [(`HOLDOFF_WIDTH-1) : 0] holdoff_counter = 0; 
always @(posedge clk) 
begin
    if (reset) 
	triggered <= 1'b0; 
    else if ((i_trigger) && (primed)) 
	triggered <= 1'b1;  
end
always @(posedge clk) 
begin
    if (reset) 
	holdoff_counter <= 0; 
    else
	holdoff_counter <= (triggered) ? (holdoff_counter + 1) : holdoff_counter;   
end
always @(posedge clk) 
begin
    if (reset) 
	stopped <= 0; 
    else if (!stopped) 
	stopped <= (holdoff_counter >= i_holdoff) && (triggered); 
end
endmodule 