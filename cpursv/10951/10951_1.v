
module ddr3_s4_amphy_full_mem_model_ram_module(data,rdaddress,rdclken,wraddress,wrclock,wren,q);

  output [15:0] q;
  input  [15:0] data;
  input  [24:0] rdaddress;
  input  rdclken;
  input  [24:0] wraddress;
  input  wrclock;
  input  wren;
  reg  [15:0] mem_array[33554431:0];
  wire [15:0] q;
  reg  [24:0] read_address;

  
  always @(rdaddress)
      begin
        read_address = rdaddress;
      end
  assign q = mem_array[read_address];
  
  always @(posedge wrclock)
      begin
        if (wren) mem_array[wraddress] <= data;
          
      end
endmodule

