
module Queue_2(input  clk,
               input  reset,
               output io_enq_ready,
               input  io_enq_valid,
               input  [7:0] io_enq_bits,
               input  io_deq_ready,
               output io_deq_valid,
               output [7:0] io_deq_bits,
               output [5:0] io_count);

  wire [5:0] T0;
  wire [4:0] ptr_diff;
  reg  [4:0] R1;
  wire [4:0] T15;
  wire [4:0] T2;
  wire [4:0] T3;
  wire do_deq;
  reg  [4:0] R4;
  wire [4:0] T16;
  wire [4:0] T5;
  wire [4:0] T6;
  wire do_enq;
  wire T7;
  wire ptr_match;
  reg  maybe_full;
  wire T17;
  wire T8;
  wire T9;
  wire [7:0] T10;
  reg  [7:0] ram[31:0];
  wire [7:0] T11;
  wire T12;
  wire empty;
  wire T13;
  wire T14;
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
  assign ptr_diff = (-R1)+R4;
  assign T15 = reset ? 5'h0 : T2;
  assign T2 = do_deq ? T3 : R1;
  assign T3 = R1+5'h1;
  assign do_deq = io_deq_ready & io_deq_valid;
  assign T16 = reset ? 5'h0 : T5;
  assign T5 = do_enq ? T6 : R4;
  assign T6 = R4+5'h1;
  assign do_enq = io_enq_valid & io_enq_ready;
  assign T7 = ptr_match & maybe_full;
  assign ptr_match = R4 == R1;
  assign T17 = reset ? 1'h0 : T8;
  assign T8 = T9 ? do_enq : maybe_full;
  assign T9 = do_enq != do_deq;
  assign io_deq_bits = T10;
  assign T10 = ram[R1];
  assign io_deq_valid = T12;
  assign T12 = (1'h1 & ~empty) | (empty & ~1'h1);
  assign empty = ptr_match & T13;
  assign T13 = (1'h1 & ~maybe_full) | (maybe_full & (~1'h1 & (maybe_full | 1'h1)));
  assign io_enq_ready = T14;
  assign T14 = ((1'h1 & ~full) | (~1'h1 & ((1'h1 & ~full) | (full & 1'h1)))) | (~1'h1 & (1'h1 | full));
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
          
        if (do_enq) ram[R4] <= io_enq_bits;
          
      end
endmodule

