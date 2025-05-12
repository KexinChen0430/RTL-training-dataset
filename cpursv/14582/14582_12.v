
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
  parameter  m100kb = (1/V100kb)*Fclk;
  parameter  m50kb = Fclk/V50kb;
  parameter  m12_5kb = (1/V12_5kb)*Fclk;
  reg  [31:0]  data = 0;
  reg  [6:0]  cb = 0;
  reg  [10:0]  cc = 0;
  reg  [1:0]  cur_mode = 0;
  reg  [1:0]  prev_mode = 0;
  reg  [1:0]  new_bit = 0;
  reg   err = 0;

  genvar i;
  
  generate
      for (i = 23; i >= 1; i = i+(-1))
          begin
            assign sr_dat[i+(-1)] = data[(0-i)+24];
          end
  endgenerate

  assign sr_adr = data[31:24];
  assign parity = ^data[31:1];
  assign ce_wr = (cb == 32) && (!parity == data[0]);
  assign sig = in0 | in1;
  assign glitch = 
((!sig && (cc != (m50kb-1))) || ((cc != m50kb) && !sig)) && 
                  (
((cc != (m50kb-1)) && 
(
((cc != m100kb) && 
(!sig && 
((cc != ((-1)+m12_5kb)) || 
((cc != m50kb) && 
(!sig && ((cc != ((-1)+m12_5kb)) || (cc != m12_5kb))))))) || (!sig && (cc != m12_5kb) && (cc != m100kb)))) || (cc != (m100kb+(-1))) || 
((cc != m50kb) && 
(
((cc != m100kb) && 
(!sig && 
((cc != ((-1)+m12_5kb)) || 
((cc != m50kb) && 
(!sig && ((cc != ((-1)+m12_5kb)) || (cc != m12_5kb))))))) || (!sig && (cc != m12_5kb) && (cc != m100kb))))) && ((cc != ((-1)+m12_5kb)) || (cc != m12_5kb));
  
  always @(posedge clk)
      begin
        if (!glitch & !sig) prev_mode = cur_mode;
          
        if (!glitch & !sig) 
          cur_mode = ((cc == m12_5kb) || (cc == ((-1)+m12_5kb))) ? 1 : 
                     ((cc == m50kb) || (cc == (m50kb-1))) ? 1<<1 : 
                     ((cc == (m100kb+(-1))) || (cc == m100kb)) ? 3 : 0;
          
        if (!sig && ((cb != 32) && (cur_mode != prev_mode))) err <= 1;
          
        data <= (!err && ((new_bit == 1) && !sig)) ? (data<<<1+1) : 
               ((new_bit == 0) && !sig && !err) ? data<<<1 : 
               (!sig && !err) ? data : 
               sig ? data : 0;
        if (((cb != 32) && !err && ((new_bit == 1) && !sig)) || 
            (!err && (!sig && ((cb != 32) && (new_bit == 0))))) cb <= cb+1;
          
        new_bit <= (in1 && (!glitch && !err)) ? 1 : 
                  (in0 && (!glitch && !err)) ? 0 : 1<<1;
        if (new_bit == 1<<1) cc <= 0;
          
        if (sig) cc <= cc+1;
          
        if (glitch) cc <= 0;
          
      end
endmodule

