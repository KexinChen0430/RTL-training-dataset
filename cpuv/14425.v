module
else
if ((text_on[3] ||
((state_reg == newgame) && text_on[1]) || 
((state_reg == over) && text_on[0])) && ~(state_reg == remember) && ~(state_reg == check))
rgb_next = text_rgb;
else if (state_reg == remember)
rgb_next = study_rgb;
else if (state_reg == check)
rgb_next = check_rgb;
else if (graph_on)  
rgb_next = graph_rgb;
else if (text_on[2]) 
rgb_next = text_rgb;
else
rgb_next = 3'b110; 
assign rgb = rgb_reg;
endmodule