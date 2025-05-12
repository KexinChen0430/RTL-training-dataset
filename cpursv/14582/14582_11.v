
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
  parameter  m50kb = (1/V50kb)*Fclk;
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
      for (i = 23; i >= 1; i = i+(-1))
          begin
            assign sr_dat[i+(-1)] = data[(-i)+24];
          end
  endgenerate

  assign sr_adr = data[31:24];
  assign parity = ^data[31:1];
  assign ce_wr = (!parity == data[0]) && (cb == 32);
  assign sig = in1 | in0;
  assign glitch = ((cc != m50kb) || (cc != ((-1)+m50kb))) && !sig && 
                  ((cc != ((-1)+m100kb)) || (cc != m100kb)) && 
                  ((!sig && (cc != (m12_5kb+(-1)))) || (cc != m12_5kb));
  
  always @(posedge clk)
      begin
        if (!sig & !glitch) prev_mode = cur_mode;
          
        if (!sig & !glitch) 
          cur_mode = ((cc == m12_5kb) || (cc == (m12_5kb+(-1)))) ? 1 : 
                     ((cc == ((-1)+m50kb)) || (cc == m50kb)) ? 1<<1 : 
                     ((cc == m100kb) || (cc == ((-1)+m100kb))) ? 3 : 0;
          
        if ((cur_mode != prev_mode) && ((cb != 32) && !sig)) err <= 1;
          
        data <= (!err && (!sig && (new_bit == 1))) ? (1+(data*1<<1)) : 
               ((new_bit == 0) && (!sig && !err)) ? (data*1<<1) : 
               (!sig && !err) ? data : 
               sig ? data : 0;
        if (!sig && !err && (cb != 32) && 
            ((new_bit == 0) || (new_bit == 1))) cb <= cb+1;
          
        new_bit <= (!glitch && in1 && !err) ? 1 : 
                  (!err && !glitch && in0) ? 0 : 1<<1;
        if (new_bit == 1<<1) cc <= 0;
          
        if (sig) cc <= 1+cc;
          
        if (glitch) cc <= 0;
          
      end
endmodule

