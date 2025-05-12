
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
      else if (tcr && wr) tmcr[6:0] <= {data_in[6:5],1'b0,data_in[3:0]};
      else if (oneshot && thi_load) tmcr[0] <= 1'd1;
      else if (underflow && oneshot) tmcr[0] <= 1'd0;
        
  
  always @(posedge clk)
      forceload <= (wr & tcr) & data_in[4];
  assign oneshot = tmcr[3];
  assign start = tmcr[0];
  
  always @(posedge clk)
      if (reset) tmll[7:0] <= 8'b1111_1111;
      else if (tlo && wr) tmll[7:0] <= data_in[7:0];
        
  
  always @(posedge clk)
      if (reset) tmlh[7:0] <= 8'b1111_1111;
      else if (thi && wr) tmlh[7:0] <= data_in[7:0];
        
  
  always @(posedge clk)
      thi_load <= (thi & wr) & (oneshot | ((wr & ~start) & thi));
  assign reload = (underflow | forceload) | thi_load;
  
  always @(posedge clk)
      if (reset) tmr[15:0] <= 16'hFF_FF;
      else if (reload) tmr[15:0] <= {tmlh[7:0],tmll[7:0]};
      else if (count && start) tmr[15:0] <= tmr[15:0]-16'd1;
        
  assign zero = ~|tmr;
  assign underflow = (start & zero) & count;
  assign irq = underflow;
  assign data_out[7:0] = (tmr[7:0] & {8{~wr & tlo}}) | (((({8{tcr & ~wr}} | tmr[7:0]) | ({8{~wr & thi}} & (((tmr[15:8] | tmr[7:0]) & (tmr[7:0] | {8{~wr & thi}})) & tmr[15:8]))) & ({1'b0,tmcr[6:0]} & (({8{~wr & thi}} & (((tmr[15:8] | tmr[7:0]) & (tmr[7:0] | {8{~wr & thi}})) & tmr[15:8])) | ({8{~wr & tlo}} | {8{tcr & ~wr}})))) | (({8{~wr & thi}} | {8{~wr & tlo}}) & (tmr[15:8] & (tmr[7:0] | {8{~wr & thi}}))));
endmodule

