
module pippo_barrel(shift_in,shift_cnt,insert_in,mask_begin,mask_end,shift_left,
                    shift_arith,rotate_en,mask_op,shrot_out,shrot_ca_new);

  input  [31:0] shift_in;
  input  [31:0] insert_in;
  input  [4:0] shift_cnt;
  input  shift_left;
  input  shift_arith;
  input  rotate_en;
  input  [4:0] mask_begin;
  input  [4:0] mask_end;
  input  mask_op;
  output [31:0] shrot_out;
  output shrot_ca_new;
  reg  [95:0] shifted;
  wire [31:0] insert_in;
  wire [31:0] shift_out;
  wire [31:0] rotate_out;
  wire [31:0] shrot_out;
  wire [95:0] sht_operand;
  wire fill;

  assign fill = !rotate_en & (shift_arith & shift_in[31]);
  assign sht_operand = {{32{fill}},shift_in,32'b0};
  
  always @(sht_operand or shift_left or shift_cnt)
      begin
        if (shift_left) shifted = sht_operand*(2**shift_cnt);
        else shifted = sht_operand>>shift_cnt;
      end
  assign shift_out = shifted[63:32];
  wire [31:0] mask_first,mask_second,mask_last;

  assign mask_first[31] = mask_begin <= 5'd0;
  assign mask_second[31] = mask_end >= 5'd0;
  assign mask_select = mask_begin < mask_end;
  assign mask_last = mask_select ? (mask_first & mask_second) : (mask_second | mask_first);
  wire [31:0] mask_and_out;

  wire [31:0] mask_insert_out;

  assign mask_and_out = (mask_last & shifted[63:32]) | (mask_last & shifted[95:64]);
  assign mask_insert_out = (((insert_in & ~mask_last) | shifted[95:64]) & (insert_in | mask_last)) | (((mask_last & shifted[63:32]) | (mask_last & shifted[95:64])) & ((mask_last & shifted[63:32]) | ~mask_last));
  assign rotate_out = mask_op ? mask_and_out : mask_insert_out;
  assign shrot_out = rotate_en ? rotate_out : shift_out;
  assign shrot_ca_new = |shifted[31:0] & (shift_arith & shift_in[31]);
endmodule

