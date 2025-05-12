module raycaster_cache_mem(
  clka,    
  wea,     
  addra,   
  dina,    
  douta,   
  clkb,    
  web,     
  addrb,   
  dinb,    
  doutb    
);
input clka;
input [0 : 0] wea;
input [8 : 0] addra;
input [31 : 0] dina;
output reg [31 : 0] douta;
input clkb;
input [0 : 0] web;
input [8 : 0] addrb;
input [31 : 0] dinb;
output reg [31 : 0] doutb;
reg [31:0] mem[0:511];
always @(posedge clka)
begin
  if (wea) 
    mem[addra] <= dina; 
  douta <= mem[addra]; 
end
always @(posedge clkb)
begin
  if (web) 
    mem[addrb] <= dinb; 
  doutb <= mem[addrb]; 
end
endmodule