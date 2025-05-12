module load_data_translator(
    d_readdatain,    
    d_address,       
    load_size,       
    load_sign_ext,   
    d_loadresult);   
input [`WIDTH-1:0] d_readdatain; 
input [1:0] d_address;           
input [1:0] load_size;           
input load_sign_ext;             
output [`WIDTH-1:0] d_loadresult; 
wire d_adr_one;
assign d_adr_one = d_address [1]; 
reg [`WIDTH-1:0] d_loadresult; 
reg sign;                      
always @(d_readdatain or d_address or load_size or load_sign_ext)
begin
    case (load_size)
        2'b11: 
        begin
            case (d_address)
                2'b00: 
					begin
					d_loadresult[7:0]=d_readdatain[31:24]; 
					sign = d_readdatain[31]; 
					end
                2'b01: 
						begin
						d_loadresult[7:0]=d_readdatain[23:16]; 
						sign = d_readdatain[23]; 
						end
                2'b10: 
					begin
					d_loadresult[7:0]=d_readdatain[15:8]; 
					sign = d_readdatain[15]; 
					end
                default: 
					begin
					d_loadresult[7:0]=d_readdatain[7:0]; 
					sign = d_readdatain[7]; 
					end
            endcase
			d_loadresult[31]= load_sign_ext&sign; 
			d_loadresult[8]= load_sign_ext&sign;
        end
        2'b01: 
        begin
            case (d_adr_one)
                1'b0: 
					begin
						d_loadresult[15:0]=d_readdatain[31:16]; 
						sign = d_readdatain[31]; 
					end
                default: 
					begin
						d_loadresult[15:0]=d_readdatain[15:0]; 
						sign = d_readdatain[15]; 
					end
            endcase
			d_loadresult[31]= load_sign_ext&sign; 
			d_loadresult[16]= load_sign_ext&sign;
        end
        default: 
	begin
								sign = d_readdatain[31]; 
            d_loadresult[31:0]=d_readdatain[31:0]; 
end
    endcase
end
endmodule