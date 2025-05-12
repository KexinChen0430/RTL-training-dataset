
module insn_out(input  wire [15:0] insn,
                input  wire clk,
                input  wire res,
                output wire [3:0] anode,
                output wire [6:0] cathode);

  parameter  MSB = 16;
  reg  [MSB:0] counter;
  reg  [3:0] nibble;

  sseg_driver ssgd0(.digit(nibble),.sel(counter[MSB:MSB-1]),
                    .anode(anode),.cathode(cathode));
  
  always @(posedge clk)
      begin
        if (res) counter <= {MSB+1{1'b0}};
        else counter <= 1'b1+counter;
      end
  
  always @(counter[MSB:MSB-1] or insn)
      begin
        case (counter[MSB:MSB-1])

          2'b00: nibble = insn[3:0];

          2'b01: nibble = insn[7:4];

          2'b10: nibble = insn[11:8];

          2'b11: nibble = insn[15:12];

        endcase

      end
endmodule

