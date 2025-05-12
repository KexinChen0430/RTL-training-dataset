module is slave (receiver) 
    rx2_out <= tx1_in; 
    rx1_out <= tx2_in; 
end 
else 
begin
    rx3_out <= {N{1'b0}}; 
    rx0_out <= {N{1'b0}}; 
end
if (selectRoute == 3'bX00) 
begin
    rx1_out <= tx0_in; 
    rx0_out <= tx1_in; 
end
else
begin
    rx3_out <= {N{1'b0}}; 
    rx2_out <= {N{1'b0}}; 
end
end 
endmodule 