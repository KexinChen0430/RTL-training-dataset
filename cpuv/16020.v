module ddr3_int_full_mem_model_ram_module (
  input   [ 63: 0] data,        
  input   [ 25: 0] rdaddress,   
  input            rdclken,     
  input   [ 25: 0] wraddress,   
  input            wrclock,     
  input            wren,        
  output  [ 63: 0] q            
);
wire    [ 63: 0] q;
input   [ 63: 0] data;
input   [ 25: 0] rdaddress;
input            rdclken;
input   [ 25: 0] wraddress;
input            wrclock;
input            wren;
reg     [ 63: 0] mem_array [67108863: 0];
reg     [ 25: 0] read_address;
always @(rdaddress)
  begin
    read_address = rdaddress; 
  end
assign q = mem_array[read_address];
always @(posedge wrclock)
  begin
    if (wren) 
        mem_array[wraddress] <= data; 
  end
endmodule