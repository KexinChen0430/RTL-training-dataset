
module ipa(input  clk_i,
           input  reset_i,
           input  cyc_i,
           output ack_o,
           output [15:0] dat_o,
           input  txd_i,
           input  txc_i);

  reg  [19:0] bits_received;
  reg  txc_r;
  reg  ack_o;
  reg  [15:0] dat_o;
  wire  sample = txc_r & ~txc_i;
  wire 
       framed = ((~bits_received[0] & bits_received[19]) & ~bits_received[10]) & bits_received[9];

  
  always @(posedge clk_i)
      begin
        bits_received <= bits_received;
        txc_r <= txc_i;
        ack_o <= 0;
        dat_o <= 0;
        if (reset_i) 
          begin
            bits_received <= ~0;
            txc_r <= 0;
          end
        else 
          begin
            if (sample) 
              begin
                bits_received <= {txd_i,bits_received[19:1]};
              end
              
            if (framed) 
              begin
                bits_received <= ~0;
                if (cyc_i) 
                  begin
                    ack_o <= 1;
                    dat_o <= {bits_received[18:11],bits_received[8:1]};
                  end
                  
              end
              
          end
      end
endmodule

