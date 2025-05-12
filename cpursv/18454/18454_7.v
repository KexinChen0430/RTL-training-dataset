
module cf_mem(clka,wea,addra,dina,clkb,addrb,doutb);

  parameter  DW = 16;
  parameter  AW = 5;
  input  clka;
  input  wea;
  input  [(-1)+AW:0] addra;
  input  [(-1)+DW:0] dina;
  input  clkb;
  input  [(-1)+AW:0] addrb;
  output [(-1)+DW:0] doutb;
  reg  [(-1)+DW:0] m_ram[0:(-1)+(1<<1**AW)];
  reg  [(-1)+DW:0] doutb;

  
  always @(posedge clka)
      begin
        if (wea == 1'b1) 
          begin
            m_ram[addra] <= dina;
          end
          
      end
  
  always @(posedge clkb)
      begin
        doutb <= m_ram[addrb];
      end
endmodule

