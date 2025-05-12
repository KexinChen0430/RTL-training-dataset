
module or1200_dpram(clk_a,ce_a,addr_a,do_a,clk_b,ce_b,we_b,addr_b,di_b);

  parameter  aw = 5;
  parameter  dw = 32;
  input  clk_a;
  input  ce_a;
  input  [aw+(0-1):0] addr_a;
  output [(0-1)+dw:0] do_a;
  input  clk_b;
  input  ce_b;
  input  we_b;
  input  [aw+(0-1):0] addr_b;
  input  [(0-1)+dw:0] di_b;
  reg  [(0-1)+dw:0] mem[(0-1)+1<<<aw:0];
  reg  [aw+(0-1):0] addr_a_reg;

  
  function [31:0] get_gpr;
    input  [aw+(0-1):0] gpr_no;
    get_gpr = mem[gpr_no];
  endfunction

  
  function [31:0] set_gpr;
    input  [aw+(0-1):0] gpr_no;
    input  [(0-1)+dw:0] value;
    begin
      mem[gpr_no] = value;
      set_gpr = 0;
    end
  endfunction

  assign do_a = mem[addr_a_reg];
  integer k;

  
  initial  
  begin
    for (k = 0; k < 1<<<aw; k = k+1)
        begin
          mem[k] = 0;
        end
  end
  
  always @(posedge clk_a)
      if (ce_a) addr_a_reg <= addr_a;
        
  
  always @(posedge clk_b)
      if (we_b & ce_b) mem[addr_b] <= di_b;
        
endmodule

