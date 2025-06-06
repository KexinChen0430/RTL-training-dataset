
module AR_RXD(input  clk,
              input  in0,
              input  in1,
              output [22:0] sr_dat,
              output [7:0] sr_adr,
              output ce_wr);

  parameter  Fclk = 50000000;
  parameter  V100kb = 100000;
  parameter  V50kb = 50000;
  parameter  V12_5kb = 12500;
  parameter  m100kb = Fclk/V100kb;
  parameter  m50kb = Fclk/V50kb;
  parameter  m12_5kb = Fclk/V12_5kb;
  reg  [31:0]  data = 0;
  reg  [6:0]  cb = 0;
  reg  [10:0]  cc = 0;
  reg  [1:0]  cur_mode = 0;
  reg  [1:0]  prev_mode = 0;
  reg  [1:0]  new_bit = 0;
  reg   err = 0;

  genvar i;
  
  generate
      for (i = 23; i >= 1; i = i+(0-1))
          begin
            assign sr_dat[i+(0-1)] = data[24+(0-i)];
          end
  endgenerate

  assign sr_adr = data[31:24];
  assign parity = ^data[31:1];
  assign ce_wr = (!parity == data[0]) && (cb == 32);
  assign sig = in1 | in0;
  assign glitch = 
((cc != m100kb) || 
(
((cc != m50kb) || 
(
(
((!sig && (cc != (m12_5kb+(0-1)))) || (cc != m12_5kb)) && 
(!sig && 
(((cc != m100kb) && (cc != m50kb)) || 
((cc != m100kb) && (cc != (m50kb-1)))))) || (cc != (m50kb-1)))) && ((cc != (m12_5kb+(0-1))) || (cc != m12_5kb)) && 
(!sig && (cc != (m100kb+(0-1)))))) && 
                  (
((cc != m50kb) || 
(
(
((!sig && (cc != (m12_5kb+(0-1)))) || (cc != m12_5kb)) && 
(!sig && 
(((cc != m100kb) && (cc != m50kb)) || 
((cc != m100kb) && (cc != (m50kb-1)))))) || (cc != (m50kb-1)))) && ((cc != (m12_5kb+(0-1))) || (cc != m12_5kb)) && !sig);
  
  always @(posedge clk)
      begin
        if (!glitch & !sig) prev_mode = cur_mode;
          
        if (!glitch & !sig) 
          cur_mode = ((cc == m12_5kb) || (cc == (m12_5kb+(0-1)))) ? 1 : 
                     ((cc == (m50kb-1)) || (cc == m50kb)) ? 1<<<1 : 
                     ((cc == m100kb) || (cc == (m100kb+(0-1)))) ? 3 : 0;
          
        if ((cur_mode != prev_mode) && ((cb != 32) && !sig)) err <= 1;
          
        data <= (!err && !sig && (new_bit == 1)) ? (1+(data*1<<<1)) : 
               (!err && (new_bit == 0) && !sig) ? (data*1<<<1) : 
               (!err && !sig) ? data : 
               sig ? data : 0;
        if (
((new_bit == 0) || 
((new_bit == 1) && ((cb != 32) && (!err && !sig)))) && (!err && !sig) && (cb != 32)) cb <= 1+cb;
          
        new_bit <= (!glitch && (!err && in1)) ? 1 : 
                  (!glitch && in0 && !err) ? 0 : 1<<<1;
        if (new_bit == 1<<<1) cc <= 0;
          
        if (sig) cc <= 1+cc;
          
        if (glitch) cc <= 0;
          
      end
endmodule

