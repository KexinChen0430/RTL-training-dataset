
module RRArbiter_1(input  clk,
                   input  reset,
                   output io_in_0_ready,
                   input  io_in_0_valid,
                   input  [31:0] io_in_0_bits,
                   output io_in_1_ready,
                   input  io_in_1_valid,
                   input  [31:0] io_in_1_bits,
                   input  io_out_ready,
                   output io_out_valid,
                   output [31:0] io_out_bits,
                   output io_chosen);

  wire T0;
  wire T1;
  wire T2;
  wire T3;
  wire T4;
  wire T5;
  wire T6;
  reg  last_grant;
  wire T7;
  wire T8;
  wire choose;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;

  assign io_out_valid = T0;
  assign T0 = io_in_1_valid || io_in_0_valid;
  assign io_in_0_ready = T1;
  assign T1 = T2 && io_out_ready;
  assign T2 = T3 || T14;
  assign T3 = !T4;
  assign T4 = T12 || T5;
  assign T5 = T6 && io_in_1_valid;
  assign T6 = 1'h1 > last_grant;
  assign T7 = io_out_ready && io_out_valid;
  assign T8 = T7 ? choose : last_grant;
  assign choose = T10 ? 1'h1 : T9;
  assign T9 = io_in_0_valid ? 1'h0 : 1'h1;
  assign T10 = io_in_1_valid && T11;
  assign T11 = 1'h1 > last_grant;
  assign T12 = T13 && io_in_0_valid;
  assign T13 = 1'h0 > last_grant;
  assign T14 = 1'h0 > last_grant;
  assign io_in_1_ready = T15;
  assign T15 = io_out_ready && T16;
  assign T16 = T17 || T20;
  assign T17 = !T18;
  assign T18 = io_in_0_valid || T19;
  assign T19 = T12 || T5;
  assign T20 = T21 && T22;
  assign T21 = 1'h1 > last_grant;
  assign T22 = !T12;
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            last_grant <= 1'h0;
          end
        else if (T7) 
          begin
            last_grant <= T8;
          end
          
      end
endmodule

