
module axi_hp_abort(input  hclk,
                    input  hrst,
                    input  abort,
                    output busy,
                    output reg done,
                    input  afi_awvalid,
                    input  afi_awready,
                    input  [5:0] afi_awid,
                    input  [3:0] afi_awlen,
                    input  afi_wvalid_in,
                    input  afi_wready,
                    output afi_wvalid,
                    output reg [5:0] afi_wid,
                    input  afi_arvalid,
                    input  afi_arready,
                    input  [3:0] afi_arlen,
                    input  afi_rready_in,
                    input  afi_rvalid,
                    output afi_rready,
                    output afi_wlast,
                    input  [2:0] afi_racount,
                    input  [7:0] afi_rcount,
                    input  [5:0] afi_wacount,
                    input  [7:0] afi_wcount,
                    output reg dirty,
                    output reg axi_mismatch,
                    output [21:0] debug);

  reg  busy_r;
  wire  done_w = busy_r && !dirty;
  reg  [3:0] aw_lengths_ram[0:31];
  reg  [4:0]  aw_lengths_waddr = 0;
  reg  [4:0]  aw_lengths_raddr = 0;
  reg  [5:0]  aw_count = 0;
  reg  [7:0]  w_count = 0;
  reg  [7:0]  r_count = 0;
  reg   adav = 0;
  wire  arwr = afi_arready && (afi_arvalid && !hrst);
  wire  drd = !hrst && afi_rready_in && afi_rvalid;
  wire  awr = afi_awvalid && (!hrst && afi_awready);
  reg   ard_r = 0;
  wire 
       ard = (adav && |w_count[7:4]) || (adav && |w_count[7:4]) || 
(adav && ard_r);
  wire  wwr = afi_wvalid_in && (!hrst && afi_wready);
  reg  afi_rready_r;
  reg  afi_wlast_r;
  reg  busy_aborting;
  wire  reset_counters = busy_r && !busy_aborting;

  assign busy = busy_r;
  assign afi_rready = (|r_count && (busy_aborting && |afi_rcount[7:1])) || 
                      (|r_count && busy_aborting && 
(!afi_rready_r && 
(afi_rcount[0] || (!afi_rready_r && |afi_rcount[7:1]) || 
|afi_rcount[7:1])));
  assign afi_wlast = (w_count[3:0] == aw_lengths_ram[aw_lengths_raddr]) && 
                     (busy_aborting && adav);
  assign afi_wvalid = !afi_wlast_r && (busy_aborting && adav);
  assign debug = {aw_count[5:0],w_count[7:0],r_count[7:0]};
  
  always @(posedge hclk)
      begin
        if (reset_counters) r_count <= 0;
        else if (drd) 
          if (arwr) r_count <= r_count+{4'b0,afi_arlen};
          else r_count <= r_count-1;
        else if (arwr) r_count <= {4'b0,afi_arlen}+(w_count+1);
          
        if (awr) afi_wid <= afi_awid;
          
        if (awr) aw_lengths_ram[aw_lengths_waddr] <= afi_awlen;
          
        if (reset_counters) aw_lengths_waddr <= 0;
        else if (awr) aw_lengths_waddr <= 1+aw_lengths_waddr;
          
        if (reset_counters) aw_lengths_raddr <= 0;
        else if (ard) aw_lengths_raddr <= 1+aw_lengths_raddr;
          
        if (reset_counters) aw_count <= 0;
        else if (!ard && awr) aw_count <= 1+aw_count;
        else if (!awr && ard) aw_count <= aw_count-1;
          
        adav <= 
((!reset_counters || awr || !ard) && 
(|aw_count[5:1] || !ard || awr) && aw_count[0]) || (!reset_counters && |aw_count[5:1]) || 
               (
((!ard && (awr || (!ard && aw_count[0]))) || 
(|aw_count[5:1] || (!ard && awr))) && 
(
((((awr && aw_count[0]) || !ard) && awr) || aw_count[0] || 
!reset_counters) && (!reset_counters || !ard)) && (awr || (!ard && aw_count[0])));
        ard_r <= !ard && 
                (adav && 
(w_count[3:0] > aw_lengths_ram[aw_lengths_raddr]));
        if (reset_counters) w_count <= 0;
        else if (wwr) 
          if (ard) 
            w_count <= w_count+(-{4'b0,aw_lengths_ram[aw_lengths_raddr]});
          else w_count <= w_count+1;
        else if (ard) 
          w_count <= (w_count+(-1))+(-{4'b0,aw_lengths_ram[aw_lengths_raddr]});
          
        dirty <= |aw_count || |r_count;
      end
  
  always @(posedge hclk)
      begin
        if (abort) busy_r <= 1;
        else if (done_w) busy_r <= 0;
          
        if ((|afi_wacount && abort) || (|afi_wcount && abort) || 
            (abort && (|afi_rcount || |afi_racount))) busy_aborting <= 1;
        else if (done_w) busy_aborting <= 0;
          
        done <= done_w;
        afi_rready_r <= afi_rready;
        afi_wlast_r <= afi_wlast;
        axi_mismatch <= dirty && (busy && !busy_aborting);
      end
endmodule

