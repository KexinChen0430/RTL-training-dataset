
module timerb(input  clk,
              input  wr,
              input  reset,
              input  tlo,
              input  thi,
              input  tcr,
              input  [7:0] data_in,
              output [7:0] data_out,
              input  eclk,
              input  tmra_ovf,
              output irq);

  reg  [15:0] tmr;
  reg  [7:0] tmlh;
  reg  [7:0] tmll;
  reg  [6:0] tmcr;
  reg  forceload;
  wire oneshot;
  wire start;
  reg  thi_load;
  wire reload;
  wire zero;
  wire underflow;
  wire count;

  assign count = tmcr[6] ? tmra_ovf : eclk;
  
  always @(posedge clk)
      if (reset) tmcr[6:0] <= 7'd0;
      else if (wr && tcr) tmcr[6:0] <= {data_in[6:5],1'b0,data_in[3:0]};
      else if (thi_load && oneshot) tmcr[0] <= 1'd1;
      else if (underflow && oneshot) tmcr[0] <= 1'd0;
        
  
  always @(posedge clk)
      forceload <= data_in[4] & (wr & tcr);
  assign oneshot = tmcr[3];
  assign start = tmcr[0];
  
  always @(posedge clk)
      if (reset) tmll[7:0] <= 8'b1111_1111;
      else if (wr && tlo) tmll[7:0] <= data_in[7:0];
        
  
  always @(posedge clk)
      if (reset) tmlh[7:0] <= 8'b1111_1111;
      else if (wr && thi) tmlh[7:0] <= data_in[7:0];
        
  
  always @(posedge clk)
      thi_load <= (~start | (wr & (oneshot & thi))) & (wr & thi);
  assign reload = underflow | (forceload | thi_load);
  
  always @(posedge clk)
      if (reset) tmr[15:0] <= 16'hFF_FF;
      else if (reload) tmr[15:0] <= {tmlh[7:0],tmll[7:0]};
      else if (start && count) tmr[15:0] <= tmr[15:0]-16'd1;
        
  assign zero = ~|tmr;
  assign underflow = (start & zero) & count;
  assign irq = underflow;
  assign data_out[7:0] = ((((((({8{tlo & ~wr}} | {8{~wr & thi}}) & ({8{~wr & thi}} | tmr[7:0])) & tmr[7:0]) & {8{tlo & ~wr}}) | (({8{~wr & thi}} & tmr[15:8]) | {8{~wr & tcr}})) & (tmr[15:8] | ((tmr[15:8] | {8{tlo & ~wr}}) & tmr[7:0]))) & {8{~wr & thi}}) | ((({8{~wr & tcr}} | tmr[7:0]) & ({8{~wr & tcr}} | ({8{tlo & ~wr}} & (({8{tlo & ~wr}} | {8{~wr & thi}}) & ({8{~wr & thi}} | tmr[7:0]))))) & (({1'b0,tmcr[6:0]} | {8{tlo & ~wr}}) & ({1'b0,tmcr[6:0]} | ((({8{tlo & ~wr}} | {8{~wr & thi}}) & ({8{~wr & thi}} | tmr[7:0])) & tmr[7:0]))));
endmodule

