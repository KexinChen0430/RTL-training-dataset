
module prbs_gen  #(parameter  PRBS_WIDTH = 4)
  (input  clk,
   input  clk_en,
   input  rst,
   output [PRBS_WIDTH-1:0] prbs_o);

  localparam  PRBS_OFFSET = 0;
  reg  [PRBS_WIDTH-1:0] Next_LFSR_Reg;
  reg  [PRBS_WIDTH-1:0] LFSR_Reg;
  reg  [3:0] prbs_shift_value;
  reg  Bits_all,Feedback;
  integer i;

  
  always @(posedge clk)
      begin
        if (rst) LFSR_Reg <= {{PRBS_WIDTH-1{1'b0}},1'b1};
        else if (clk_en) 
          begin
            LFSR_Reg <= Next_LFSR_Reg;
            prbs_shift_value <= {prbs_shift_value[2:0],LFSR_Reg[PRBS_WIDTH-1]};
          end
          
      end
  
  always @(LFSR_Reg)
      begin : LFSR_Next
        Bits_all = ~|LFSR_Reg[PRBS_WIDTH-2:0];
        Feedback = LFSR_Reg[PRBS_WIDTH-1] ^ Bits_all;
        for (i = PRBS_WIDTH-1; i >= 1; i = i-1)
            Next_LFSR_Reg[i] = LFSR_Reg[i-1];
        case (PRBS_WIDTH)

          32'd4: Next_LFSR_Reg[0] = Feedback ^ LFSR_Reg[2];

          default: Next_LFSR_Reg[0] = ((Feedback ^ LFSR_Reg[59]) ^ LFSR_Reg[60]) ^ LFSR_Reg[62];

        endcase

      end
  assign prbs_o = LFSR_Reg;
endmodule

