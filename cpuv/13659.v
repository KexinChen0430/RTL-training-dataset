module will handle all the writes 
write_data <= i_wbs_dat; 
end 
else begin 
o_wbs_dat <= read_data; 
end 
if (ram_sleep > 0) begin 
ram_sleep <= ram_sleep - 1; 
end 
else begin 
o_wbs_ack <= 1; 
ram_sleep <= SLEEP_COUNT; 
end 
end 
end 
endmodule 