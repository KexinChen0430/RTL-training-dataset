
module db_ram_1p(clk,cen_i,oen_i,wen_i,addr_i,data_i,data_o);

  parameter  Word_Width = 128;
  parameter  Addr_Width = 8;
  input  clk;
  input  cen_i;
  input  oen_i;
  input  wen_i;
  input  [Addr_Width-1:0] addr_i;
  input  [Word_Width+(0-1):0] data_i;
  output [Word_Width+(0-1):0] data_o;
  reg  [Word_Width+(0-1):0] mem_array[(0-1)+(2**Addr_Width):0];
  reg  [Word_Width+(0-1):0] data_r;

  
  always @(posedge clk)
      begin
        if (!wen_i && !cen_i) mem_array[addr_i] <= data_i;
          
      end
  
  always @(posedge clk)
      begin
        if (wen_i && !cen_i) data_r <= mem_array[addr_i];
        else data_r <= 'bx;
      end
  assign data_o = oen_i ? 'bz : data_r;
endmodule

