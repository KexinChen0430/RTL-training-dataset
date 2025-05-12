
module Queue_1(input  clk,
               input  reset,
               output io_enq_ready,
               input  io_enq_valid,
               input  io_enq_bits_7,
               input  io_enq_bits_6,
               input  io_enq_bits_5,
               input  io_enq_bits_4,
               input  io_enq_bits_3,
               input  io_enq_bits_2,
               input  io_enq_bits_1,
               input  io_enq_bits_0,
               input  io_deq_ready,
               output io_deq_valid,
               output io_deq_bits_7,
               output io_deq_bits_6,
               output io_deq_bits_5,
               output io_deq_bits_4,
               output io_deq_bits_3,
               output io_deq_bits_2,
               output io_deq_bits_1,
               output io_deq_bits_0,
               output [5:0] io_count);

  wire [5:0] T0;
  wire [4:0] ptr_diff;
  reg  [4:0] R1;
  wire [4:0] T31;
  wire [4:0] T2;
  wire [4:0] T3;
  wire do_deq;
  reg  [4:0] R4;
  wire [4:0] T32;
  wire [4:0] T5;
  wire [4:0] T6;
  wire do_enq;
  wire T7;
  wire ptr_match;
  reg  maybe_full;
  wire T33;
  wire T8;
  wire T9;
  wire T10;
  wire [7:0] T11;
  reg  [7:0] ram[31:0];
  wire [7:0] T12;
  wire [7:0] T13;
  wire [7:0] T14;
  wire [3:0] T15;
  wire [1:0] T16;
  wire [1:0] T17;
  wire [3:0] T18;
  wire [1:0] T19;
  wire [1:0] T20;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  wire T26;
  wire T27;
  wire T28;
  wire empty;
  wire T29;
  wire T30;
  wire full;
  integer initvar;

  
  initial  
  begin
    #0.002 ;
    R1 = {1{$random}};
    R4 = {1{$random}};
    maybe_full = {1{$random}};
    for (initvar = 0; initvar < 32; initvar = 1+initvar)
        ram[initvar] = {1{$random}};
  end
  assign io_count = T0;
  assign T0 = {T7,ptr_diff};
  assign ptr_diff = (0-R1)+R4;
  assign T31 = reset ? 5'h0 : T2;
  assign T2 = do_deq ? T3 : R1;
  assign T3 = R1+5'h1;
  assign do_deq = io_deq_valid & io_deq_ready;
  assign T32 = reset ? 5'h0 : T5;
  assign T5 = do_enq ? T6 : R4;
  assign T6 = 5'h1+R4;
  assign do_enq = io_enq_valid & io_enq_ready;
  assign T7 = ptr_match & maybe_full;
  assign ptr_match = R4 == R1;
  assign T33 = reset ? 1'h0 : T8;
  assign T8 = T9 ? do_enq : maybe_full;
  assign T9 = do_enq != do_deq;
  assign io_deq_bits_0 = T10;
  assign T10 = T11[0];
  assign T11 = ram[R1];
  assign T13 = T14;
  assign T14 = {T18,T15};
  assign T15 = {T17,T16};
  assign T16 = {io_enq_bits_1,io_enq_bits_0};
  assign T17 = {io_enq_bits_3,io_enq_bits_2};
  assign T18 = {T20,T19};
  assign T19 = {io_enq_bits_5,io_enq_bits_4};
  assign T20 = {io_enq_bits_7,io_enq_bits_6};
  assign io_deq_bits_1 = T21;
  assign T21 = T11[1];
  assign io_deq_bits_2 = T22;
  assign T22 = T11[1<<1];
  assign io_deq_bits_3 = T23;
  assign T23 = T11[3];
  assign io_deq_bits_4 = T24;
  assign T24 = T11[4];
  assign io_deq_bits_5 = T25;
  assign T25 = T11[5];
  assign io_deq_bits_6 = T26;
  assign T26 = T11[6];
  assign io_deq_bits_7 = T27;
  assign T27 = T11[7];
  assign io_deq_valid = T28;
  assign T28 = (1'h1 | (empty & ((~empty & ((empty | ((empty | ~empty) & 1'h1)) & 1'h1)) | ~1'h1))) & ((~empty & ((empty | ((empty | ~empty) & 1'h1)) & 1'h1)) | ~1'h1);
  assign empty = T29 & ptr_match;
  assign T29 = ((((maybe_full | 1'h1) | ~1'h1) & maybe_full) & (maybe_full | ~maybe_full)) ^ ((maybe_full & 1'h1) | (~maybe_full & 1'h1));
  assign io_enq_ready = T30;
  assign T30 = (((maybe_full | 1'h1) | ~1'h1) & ((full & 1'h1) | (1'h1 & ~full))) ^ (((maybe_full | 1'h1) | ~1'h1) & full);
  assign full = ptr_match & maybe_full;
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            R1 <= 5'h0;
          end
        else if (do_deq) 
          begin
            R1 <= T3;
          end
          
        if (reset) 
          begin
            R4 <= 5'h0;
          end
        else if (do_enq) 
          begin
            R4 <= T6;
          end
          
        if (reset) 
          begin
            maybe_full <= 1'h0;
          end
        else if (T9) 
          begin
            maybe_full <= do_enq;
          end
          
        if (do_enq) ram[R4] <= T13;
          
      end
endmodule

