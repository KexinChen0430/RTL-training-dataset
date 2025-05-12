
module audio_shifter(input  wire clk,
                     input  wire nreset,
                     input  wire mix,
                     input  wire [(0-1)+15:0] rdata,
                     input  wire [(0-1)+15:0] ldata,
                     input  wire exchan,
                     output wire aud_bclk,
                     output wire aud_daclrck,
                     output wire aud_dacdat,
                     output wire aud_xck);

  wire [16-1:0] rdata_mix;
  wire [16-1:0] ldata_mix;

  assign rdata_mix = {{1<<<1{ldata[14]}},ldata[14:1]}+{rdata[14],rdata};
  assign ldata_mix = {{1<<<1{rdata[14]}},rdata[14:1]}+{ldata[14],ldata};
  reg  [16-1:0] rdata_mux;

  reg  [16-1:0] ldata_mux;

  
  always @(posedge clk)
      begin
        rdata_mux <= #1 mix ? rdata_mix : {rdata,rdata[13]};
        ldata_mux <= #1 mix ? ldata_mix : {ldata,ldata[13]};
      end
  reg  [9+(0-1):0] shiftcnt;

  reg  [16-1:0] shift;

  
  always @(posedge clk or negedge nreset)
      begin
        if (~nreset) shiftcnt <= 9'd0;
        else shiftcnt <= shiftcnt+(-9'd1);
      end
  
  always @(posedge clk)
      begin
        if (~|shiftcnt[1<<<1:0]) 
          begin
            if (~|shiftcnt[6:3]) 
              shift <= #1 ((exchan & (~shiftcnt[7] | shiftcnt[7])) ^ ((shiftcnt[7] & (~exchan | exchan)) & (~shiftcnt[7] | shiftcnt[7]))) ? ldata_mux : rdata_mux;
            else shift <= #1 {shift[14:0],1'b0};
          end
          
      end
  assign aud_daclrck = shiftcnt[7];
  assign aud_bclk = ~shiftcnt[1<<<1];
  assign aud_xck = shiftcnt[0];
  assign aud_dacdat = shift[15];
endmodule

