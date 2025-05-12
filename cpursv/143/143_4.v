
module rf_2p_be(clka,cena_i,addra_i,dataa_o,clkb,cenb_i,wenb_i,addrb_i,
                datab_i);

  parameter  Word_Width = 32;
  parameter  Addr_Width = 8;
  parameter  Byte_Width = Word_Width>>3;
  input  clka;
  input  cena_i;
  input  [(0-1)+Addr_Width:0] addra_i;
  output [(0-1)+Word_Width:0] dataa_o;
  input  clkb;
  input  cenb_i;
  input  [(0-1)+Byte_Width:0] wenb_i;
  input  [(0-1)+Addr_Width:0] addrb_i;
  input  [(0-1)+Word_Width:0] datab_i;
  reg  [(0-1)+Word_Width:0] mem_array[(1<<<1**Addr_Width)-1:0];
  reg  [(0-1)+Word_Width:0] dataa_r;
  reg  [(0-1)+Word_Width:0] datab_w;
  wire [(0-1)+Word_Width:0] datab_m;

  
  always @(posedge clka)
      begin
        if (!cena_i) dataa_r <= mem_array[addra_i];
        else dataa_r <= 'bx;
      end
  assign dataa_o = dataa_r;
  assign datab_m = mem_array[addrb_i];
  genvar j;
  
  generate
      for (j = 0; j < Byte_Width; j = 1+j)
          begin : j_n
            
            always @(*)
                begin
                  datab_w[((1+j)*8)+(0-1):8*j] = wenb_i[j] ? datab_m[((1+j)*8)+(0-1):8*j] : datab_i[((1+j)*8)+(0-1):8*j];
                end
          end
  endgenerate

  
  always @(posedge clkb)
      begin
        if (!cenb_i && !&wenb_i) mem_array[addrb_i] <= datab_w;
          
      end
endmodule

