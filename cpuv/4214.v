module ram_dp_be (
				clka    ,
				cena_i  ,
		        oena_i  ,
		        wena_i  ,
		        addra_i ,
		        dataa_o ,
		        dataa_i ,
				clkb    ,
				cenb_i  ,
				oenb_i  ,
				wenb_i  ,
				addrb_i	,
				datab_o ,
				datab_i
);
parameter     		Word_Width=32;  
parameter	  		Addr_Width=8;   
localparam			Byte_Width=(Word_Width>>3);  
input                     clka;      
input   		          cena_i;    
input   		          oena_i;    
input   [Byte_Width-1:0]  wena_i;    
input   [Addr_Width-1:0]  addra_i;   
input   [Word_Width-1:0]  dataa_i;   
output	[Word_Width-1:0]  dataa_o;   
input                     clkb;      
input   		          cenb_i;    
input   		          oenb_i;    
input   [Byte_Width-1:0]  wenb_i;    
input   [Addr_Width-1:0]  addrb_i;   
input   [Word_Width-1:0]  datab_i;   
output	[Word_Width-1:0]  datab_o;   
reg    [Word_Width-1:0]   mem_array[(1<<Addr_Width)-1:0];  
reg	   [Word_Width-1:0]  dataa_r;  
reg	   [Word_Width-1:0]  datab_r;  
reg	   [Word_Width-1:0]  dataa_w;  
reg	   [Word_Width-1:0]  datab_w;  
wire   [Word_Width-1:0]  dataa_m;  
wire   [Word_Width-1:0]  datab_m;  
assign dataa_m = mem_array[addra_i];
generate
	for (i=0; i<Byte_Width; i=i+1) begin:i_n
		always@(*) begin
			dataa_w[(i+1)*8-1:i*8] = wena_i[i] ? dataa_m[(i+1)*8-1:i*8] : dataa_i[(i+1)*8-1:i*8];
		end
	end
endgenerate
always @(posedge clka) begin
	if(!cena_i && !(&wena_i))
		mem_array[addra_i] <= dataa_w;
end
always @(posedge clka) begin
	if (!cena_i && wena_i)
		dataa_r <= mem_array[addra_i];
	else
		dataa_r <= 'bx;
end
assign dataa_o = oena_i ? 'bz : dataa_r;
assign datab_m = mem_array[addrb_i];
generate
	for (j=0; j<Byte_Width; j=j+1) begin:j_n
		always@(*) begin
			datab_w[(j+1)*8-1:j*8] = wenb_i[j] ? datab_m[(j+1)*8-1:j*8] : datab_i[(j+1)*8-1:j*8];
		end
	end
endgenerate
always @(posedge clkb) begin
	if(!cenb_i && !(&wenb_i))
		mem_array[addrb_i] <= datab_w;
end
always @(posedge clkb) begin
	if (!cenb_i && wenb_i)
		datab_r <= mem_array[addrb_i];
	else
		datab_r <= 'bx;
end
assign datab_o = oenb_i ? 'bz : datab_r;
endmodule