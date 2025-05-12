module shifter (value, shift_amount, shift_func, c_shift); 
   input  [31:0] value; 
   input  [ 4:0] shift_amount; 
   input  [ 1:0] shift_func; 
   output [31:0] c_shift; 
   wire [31: 0] shift1L ;
   wire [31: 0] shift2L ;
   wire [31: 0] shift4L ;
   wire [31: 0] shift8L ;
   wire [31: 0] shift16L;
   wire [31: 0] shift1R ;
   wire [31: 0] shift2R ;
   wire [31: 0] shift4R ;
   wire [31: 0] shift8R ;
   wire [31: 0] shift16R;
   wire [31:16] fills   ; 
   assign fills    = (shift_func == `shift_right_signed & value[31]) ? 16'b1111111111111111 : 16'b0000000000000000; 
   assign shift1L  = (shift_amount[0]) ? {value  [30:0],  1'b0}  :value; 
   assign shift2L  = (shift_amount[1]) ? {shift1L[29:0],  2'b0}  :shift1L; 
   assign shift4L  = (shift_amount[2]) ? {shift2L[27:0],  4'b0}  :shift2L; 
   assign shift8L  = (shift_amount[3]) ? {shift4L[23:0],  8'b0}  :shift4L; 
   assign shift16L = (shift_amount[4]) ? {shift8L[15:0], 16'b0}  :shift8L; 
   assign shift1R  = (shift_amount[0]) ? {fills[31], value[31:1]}:value; 
   assign shift2R  = (shift_amount[1]) ? {fills[31:30],shift1R[31: 2]}: shift1R; 
   assign shift4R  = (shift_amount[2]) ? {fills[31:28],shift2R[31: 4]}: shift2R; 
   assign shift8R  = (shift_amount[3]) ? {fills[31:24],shift4R[31: 8]}: shift4R; 
   assign shift16R = (shift_amount[4]) ? {fills[31:16],shift8R[31:16]}: shift8R; 
`ifdef shifter_type_GENERIC 
   reg   [31:0] c_shift; 
   always @(shift_func or shift16L or shift16R) begin 
        case(shift_func) 
            `shift_left_unsigned  : c_shift = shift16L; 
            `shift_right_unsigned,
            `shift_right_signed   : c_shift = shift16R; 
            default              : c_shift = `ZERO; 
        endcase
   end
`endif
`ifdef shifter_type_TRISTATE 
   wire   [31:0] c_shift; 
   assign c_shift = (shift_func == `shift_left_unsigned) ? shift16L:{32{1'bz}}; 
   assign c_shift = (shift_func == `shift_right_unsigned | shift_func == `shift_right_signed) ? shift16R:{32{1'bz}}; 
   assign c_shift = (shift_func == `shift_nothing) ? `ZERO : {32{1'bz}} ; 
`endif
endmodule 