
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
  parameter  m50kb = Fclk*(1/V50kb);
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
      for (i = 23; i >= 1; i = i-1)
          begin
            assign sr_dat[i-1] = data[24+(-i)];
          end
  endgenerate

  assign sr_adr = data[31:24];
  assign parity = ^data[31:1];
  assign ce_wr = (!parity == data[0]) && (cb == 32);
  assign sig = in1 | in0;
  assign glitch = !sig && 
                  ((cc != (m12_5kb-1)) || ((cc != m12_5kb) && !sig)) && 
                  (
((cc != m50kb) || 
(((cc != m12_5kb) || (cc != (m12_5kb-1))) && 
((cc != ((-1)+m50kb)) && !sig))) && ((cc != (m100kb-1)) || (cc != m100kb)));
  
  always @(posedge clk)
      begin
        if (!sig & !glitch) prev_mode = cur_mode;
          
        if (!sig & !glitch) 
          cur_mode = ((cc == (m12_5kb-1)) || (cc == m12_5kb)) ? 1 : 
                     ((cc == ((-1)+m50kb)) || (cc == m50kb)) ? 2 : 
                     ((cc == m100kb) || (cc == (m100kb-1))) ? 3 : 0;
          
        if (!sig && (cb != 32) && (cur_mode != prev_mode)) err <= 1;
          
        data <= (!err && !sig && (new_bit == 1)) ? (1+(2*data)) : 
               (!sig && (!err && (new_bit == 0))) ? (2*data) : 
               (!err && !sig) ? data : 
               sig ? data : 0;
        if ((!err || (new_bit == 0)) && 
            ((!sig && (new_bit == 1) && (cb != 32)) || 
(new_bit == 0)) && ((cb != 32) && (!err && !sig))) cb <= cb+1;
          
        new_bit <= (in1 && (!glitch && !err)) ? 1 : 
                  (in0 && (!glitch && !err)) ? 0 : 2;
        if (new_bit == 2) cc <= 0;
          
        if (sig) cc <= 1+cc;
          
        if (glitch) cc <= 0;
          
      end
endmodule

