
module RAM_512_18  #(parameter  B = 1024)
  (output signed  [31:0] q,
   input  signed  [31:0] data,
   input  [(0-1)+$clog2(B):0] wraddress,
   input  [(0-1)+$clog2(B):0] rdaddress,
   input  wren,
   input  rden,
   input  clock);

  reg  [8:0] read_address_reg;
  reg  signed  [31:0] mem[(0-1)+B:0];
  reg  rden_reg;

  
  always @(posedge clock)
      begin
        if (wren) mem[wraddress] <= data;
          
      end
  
  always @(posedge clock)
      begin
        read_address_reg <= rdaddress;
        rden_reg <= rden;
      end
  assign q = rden_reg ? mem[read_address_reg] : 0;
endmodule

