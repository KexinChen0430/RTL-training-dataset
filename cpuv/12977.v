module reset_synchronizer ( 
   input arst_in_n, 
   input clk, 
   output arst_out_n 
);
reg[1:0] ff; 
assign arst_out_n = ff[1]; 
always@(posedge clk or negedge arst_in_n)
begin
   if(arst_in_n) 
     ff <= '0; 
  else 
     ff <= {ff[0],1'b1}; 
end
end 
endmodule 