
module Queue_0(input  clk,
               input  reset,
               output io_enq_ready,
               input  io_enq_valid,
               input  [7:0] io_enq_bits_7,
               input  [7:0] io_enq_bits_0,
               input  io_deq_ready,
               output io_deq_valid,
               output [7:0] io_deq_bits_7,
               output [7:0] io_deq_bits_0,
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
  wire [7:0] T10;
  wire [63:0] T11;
  reg  [63:0] ram[31:0];
  wire [63:0] T12;
  wire [63:0] T13;
  wire [63:0] T14;
  wire [31:0] T15;
  wire [15:0] T16;
  wire [15:0] T17;
  wire [31:0] T18;
  wire [15:0] T19;
  wire [15:0] T20;
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
    for (initvar = 0; initvar < 32; initvar = initvar+1)
        ram[initvar] = {2{$random}};
  end
endmodule

