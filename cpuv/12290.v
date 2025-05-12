module bw_io_hstl_drv(
   pad,
   sel_data_n, pad_up, pad_dn_l, por,
   bsr_up, bsr_dn_l, cbu, cbd, vddo );
output  pad;            
input [8:1] cbu;        
input [8:1] cbd;        
input   sel_data_n;     
input   pad_up;         
input   pad_dn_l;       
input   por;            
input   bsr_up;         
input   bsr_dn_l;       
inout   vddo;           
reg  out;
always @(bsr_dn_l or bsr_up or pad_dn_l or pad_up or por or sel_data_n) begin
   if (por == 1'b1) out = 1'bz;
   else if (por == 1'b0) begin
      if (sel_data_n == 1'b0) begin
	 case ({pad_up, pad_dn_l})
	   2'b00: out = 1'b0;     
	   2'b01: out = 1'bz;     
	   2'b11: out = 1'b1;     
	   default: out = 1'bx;   
	 endcase 
      end
      else if (sel_data_n == 1'b1) begin
	 case ({bsr_up, bsr_dn_l})
	   2'b00: out = 1'b0;     
	   2'b01: out = 1'bz;     
	   2'b11: out = 1'b1;     
	   default: out = 1'bx;   
	 endcase 
      end
      else out = 1'bx;
   end 
   else out = 1'bx;
end 
assign (pull1, strong0) #1 pad = out;
endmodule 