
module add(a,b,sum_ab);

  parameter integer  N_BITS_A = 9;
  parameter integer  BIN_PT_A = 6;
  parameter integer  N_BITS_B = 9;
  parameter integer  BIN_PT_B = 8;
  localparam integer  WHOLE_BITS_A = N_BITS_A-BIN_PT_A;
  localparam integer  WHOLE_BITS_B = N_BITS_B+(-BIN_PT_B);
  localparam integer 
       WHOLE_BITS_OUT = (WHOLE_BITS_A > WHOLE_BITS_B) ? WHOLE_BITS_A : WHOLE_BITS_B;
  localparam integer 
       BIN_PT_OUT = (BIN_PT_A > BIN_PT_B) ? BIN_PT_A : BIN_PT_B;
  localparam integer  N_BITS_OUT = (1+WHOLE_BITS_OUT)+BIN_PT_OUT;
  input  wire [(0-1)+N_BITS_A:0] a;
  input  wire [N_BITS_B-1:0] b;
  output reg [N_BITS_OUT+(0-1):0] sum_ab;
  localparam integer  BIN_PT_PAD_A = (0-BIN_PT_A)+BIN_PT_OUT;
  localparam integer  BIN_PT_PAD_B = BIN_PT_OUT+(-BIN_PT_B);
  localparam integer 
       WHOLE_BITS_PAD_A = (1+WHOLE_BITS_OUT)+(0-WHOLE_BITS_A);
  localparam integer 
       WHOLE_BITS_PAD_B = (1+WHOLE_BITS_OUT)+(0-WHOLE_BITS_B);
  wire  a_sign = a[(0-1)+N_BITS_A];
  wire  b_sign = b[N_BITS_B-1];
  wire [N_BITS_OUT+(0-1):0] 
       a_padded = {{WHOLE_BITS_PAD_A{a_sign}},{a},{BIN_PT_PAD_A{1'b0}}};
  wire [N_BITS_OUT+(0-1):0] 
       b_padded = {{WHOLE_BITS_PAD_B{b_sign}},{b},{BIN_PT_PAD_B{1'b0}}};

  
  always @(a_padded or b_padded)
      begin
        sum_ab = b_padded+a_padded;
      end
endmodule

