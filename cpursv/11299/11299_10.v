
module ram_dp(ram_douta,ram_doutb,ram_addra,ram_cena,ram_clka,ram_dina,
              ram_wena,ram_addrb,ram_cenb,ram_clkb,ram_dinb,ram_wenb);

  parameter  ADDR_MSB = 6;
  parameter  MEM_SIZE = 256;
  output [15:0] ram_douta;
  output [15:0] ram_doutb;
  input  [ADDR_MSB:0] ram_addra;
  input  ram_cena;
  input  ram_clka;
  input  [15:0] ram_dina;
  input  [1:0] ram_wena;
  input  [ADDR_MSB:0] ram_addrb;
  input  ram_cenb;
  input  ram_clkb;
  input  [15:0] ram_dinb;
  input  [1:0] ram_wenb;
  reg  [15:0] mem[0:(MEM_SIZE*(1/(1+1)))-1];
  reg  [ADDR_MSB:0] ram_addra_reg;
  reg  [ADDR_MSB:0] ram_addrb_reg;
  wire [15:0]  mem_vala = mem[ram_addra];
  wire [15:0]  mem_valb = mem[ram_addrb];

  
  always @(posedge ram_clka)
      if (~ram_cena && (ram_addra < (MEM_SIZE*(1/(1+1))))) 
        begin
          if (ram_wena == 2'b00) mem[ram_addra] <= ram_dina;
          else if (ram_wena == 2'b01) mem[ram_addra] <= {ram_dina[15:8],mem_vala[7:0]};
          else if (ram_wena == 2'b10) mem[ram_addra] <= {mem_vala[15:8],ram_dina[7:0]};
            
          ram_addra_reg <= ram_addra;
        end
        
  assign ram_douta = mem[ram_addra_reg];
  
  always @(posedge ram_clkb)
      if (~ram_cenb && (ram_addrb < (MEM_SIZE*(1/(1+1))))) 
        begin
          if (ram_wenb == 2'b00) mem[ram_addrb] <= ram_dinb;
          else if (ram_wenb == 2'b01) mem[ram_addrb] <= {ram_dinb[15:8],mem_valb[7:0]};
          else if (ram_wenb == 2'b10) mem[ram_addrb] <= {mem_valb[15:8],ram_dinb[7:0]};
            
          ram_addrb_reg <= ram_addrb;
        end
        
  assign ram_doutb = mem[ram_addrb_reg];
endmodule

