module ram_controller_full_mem_model_ram_module (
  input   [ 31: 0] data,        
  input   [ 24: 0] rdaddress,   
  input            rdclken,     
  input   [ 24: 0] wraddress,   
  input            wrclock,     
  input            wren,        
  output  [ 31: 0] q            
);
wire    [ 31: 0] q;
input   [ 31: 0] data;
input   [ 24: 0] rdaddress;
input            rdclken;
input   [ 24: 0] wraddress;
input            wrclock;
input            wren;
reg     [ 31: 0] mem_array [33554431: 0];
reg     [ 24: 0] read_address;
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