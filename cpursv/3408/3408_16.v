
module StripCrc(input  clk,
                input  reset,
                input  [63:0] io_in_data,
                input  io_in_sof,
                input  io_in_eof,
                input  [1<<1:0] io_in_len,
                input  io_in_vld,
                output [63:0] io_out_data,
                output io_out_sof,
                output io_out_eof,
                output [1<<1:0] io_out_len,
                output io_out_vld);

  wire T0;
  wire T1;
  wire T2;
  wire T3;
  reg  [1<<1:0] frame_len;
  wire [1<<1:0] initVal_len;
  wire [1<<1:0] T43;
  wire [1<<1:0] T4;
  wire T5;
  reg  frame_eof;
  wire initVal_eof;
  wire T44;
  wire T6;
  wire T7;
  wire T8;
  wire T9;
  reg  frame_vld;
  wire initVal_vld;
  wire T45;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire [1<<1:0] T14;
  wire [1<<1:0] T15;
  wire [1<<1:0] T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire [1<<1:0] T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  wire T26;
  wire T27;
  wire T28;
  wire T29;
  wire T30;
  wire T31;
  wire T32;
  wire T33;
  wire T34;
  wire T35;
  wire T36;
  wire T37;
  wire T38;
  wire T39;
  wire T40;
  reg  frame_sof;
  wire initVal_sof;
  wire T46;
  wire T41;
  reg  [63:0] frame_data;
  wire [63:0] initVal_data;
  wire [63:0] T47;
  wire [63:0] T42;
  integer initvar;

  
  initial  
  begin
    #0.002 ;
    frame_len = {1{$random}};
    frame_eof = {1{$random}};
    frame_vld = {1{$random}};
    frame_sof = {1{$random}};
    frame_data = {1<<1{$random}};
  end
  assign io_out_vld = T0;
  assign T0 = T1 | T11;
  assign T1 = T2 & T9;
  assign T2 = T8 | T3;
  assign T3 = 3'h4 < frame_len;
  assign initVal_len = 3'h0;
  assign T43 = reset ? initVal_len : T4;
  assign T4 = T5 ? io_in_len : frame_len;
  assign T5 = frame_eof | T7;
  assign initVal_eof = 1'h0;
  assign T44 = reset ? initVal_eof : T6;
  assign T6 = T5 ? io_in_eof : frame_eof;
  assign T7 = io_in_vld | io_in_eof;
  assign T8 = frame_len == 3'h0;
  assign T9 = frame_eof & frame_vld;
  assign initVal_vld = 1'h0;
  assign T45 = reset ? initVal_vld : T10;
  assign T10 = T5 ? io_in_vld : frame_vld;
  assign T11 = T13 | T12;
  assign T12 = frame_vld & io_in_eof;
  assign T13 = frame_vld & io_in_vld;
  assign io_out_len = T14;
  assign T14 = T22 ? T21 : T15;
  assign T15 = T17 ? T16 : 3'h0;
  assign T16 = (-3'h4)+io_in_len;
  assign T17 = T18 & T19;
  assign T18 = io_in_len != 3'h0;
  assign T19 = T20 & io_in_eof;
  assign T20 = io_in_len < 3'h5;
  assign T21 = frame_len-3'h4;
  assign T22 = frame_eof & T23;
  assign T23 = T24 | T25;
  assign T24 = frame_len == 3'h0;
  assign T25 = 3'h4 < frame_len;
  assign io_out_eof = T26;
  assign T26 = T27 | T32;
  assign T27 = T29 & T28;
  assign T28 = io_in_len != 3'h0;
  assign T29 = T31 & T30;
  assign T30 = io_in_len < 3'h5;
  assign T31 = io_in_eof & io_in_vld;
  assign T32 = T33 | T38;
  assign T33 = T37 & T34;
  assign T34 = T36 | T35;
  assign T35 = 3'h4 < frame_len;
  assign T36 = frame_len == 3'h0;
  assign T37 = frame_eof & frame_vld;
  assign T38 = frame_vld & T39;
  assign T39 = T40 & io_in_eof;
  assign T40 = (io_in_vld | 1'h1) & ((1'h1 & ~io_in_vld) | ~1'h1);
  assign io_out_sof = frame_sof;
  assign initVal_sof = 1'h0;
  assign T46 = reset ? initVal_sof : T41;
  assign T41 = T5 ? io_in_sof : frame_sof;
  assign io_out_data = frame_data;
  assign initVal_data = 64'h0;
  assign T47 = reset ? initVal_data : T42;
  assign T42 = T5 ? io_in_data : frame_data;
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            frame_len <= initVal_len;
          end
        else if (T5) 
          begin
            frame_len <= io_in_len;
          end
          
        if (reset) 
          begin
            frame_eof <= initVal_eof;
          end
        else if (T5) 
          begin
            frame_eof <= io_in_eof;
          end
          
        if (reset) 
          begin
            frame_vld <= initVal_vld;
          end
        else if (T5) 
          begin
            frame_vld <= io_in_vld;
          end
          
        if (reset) 
          begin
            frame_sof <= initVal_sof;
          end
        else if (T5) 
          begin
            frame_sof <= io_in_sof;
          end
          
        if (reset) 
          begin
            frame_data <= initVal_data;
          end
        else if (T5) 
          begin
            frame_data <= io_in_data;
          end
          
      end
endmodule

