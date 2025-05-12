
module rom(input  wire [15:0] insAddr_i,
           output reg [31:0] ins_o);

  
  always @(*)
      begin
        case (insAddr_i)

          0: ins_o = 32'h00000000;

          4: ins_o = 32'h10000001;

          8: ins_o = 32'h00000000;

          default: ins_o = 0;

        endcase

      end
endmodule

