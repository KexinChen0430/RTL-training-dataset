
module addrdecode(clk,addr_in,bank0_addr,bank1_addr,bank31_addr,sel,odd);

  input  clk;
  input  [13:0] addr_in;
  output [10:0] bank0_addr;
  output [10:0] bank31_addr;
  output [1:0] sel;
  output odd;
  reg  [10:0] bank0_addr;
  reg  [10:0] bank31_addr;
  reg  [1:0] sel_dlya;
  reg  [1:0] sel_dlyb;
  reg  [1:0] sel;
  reg  odd_dlya;
  reg  odd_dlyb;
  reg  odd;
  wire [10:0]  addr = addr_in[13:3];
  wire [10:0]  addr_pone = addr_in[13:3]+1;

  
  always @(posedge clk)
      begin
        odd_dlya <= addr_in[0];
        sel_dlya <= addr_in[2:1];
      end
  
  always @(posedge clk)
      begin
        odd_dlyb <= odd_dlya;
        sel_dlyb <= sel_dlya;
      end
  
  always @(posedge clk)
      begin
        odd <= odd_dlyb;
        sel <= sel_dlyb;
      end
  
  always @(posedge clk)
      begin
        case (addr_in[2:1])

          2'b00: begin
                bank0_addr <= addr;
                bank31_addr <= addr;
              end

          2'b01: begin
                bank0_addr <= addr_pone;
                bank31_addr <= addr;
              end

        endcase

      end
endmodule

