module
  input  [ 3:0] rdy;          
  output [ 3:0] nxt;          
  output [ 1:0] channel;      
  output [ 1:0] ts_sel;       
  output        ts_en;        
  output        dv;           
  output [23:0] sample_counter;
  reg    [3:0] ts_rq_in_d;
  reg    [3:0] ts_rq;
  reg    [3:0] ts_valid;
  reg    [3:0] channels_ready;
  reg    [3:1] chn1hot;       
  reg          rq_not_zero;   
  reg    [1:0] channel;
  reg          busy;
  wire         wstart;
  reg          ts_en;
  reg    [4:0] seq_cntr;
  reg          seq_cntr_last;
  reg    [1:0] ts_sel;
  reg          dv;
  reg          inc_sample_counter;
  reg   [23:0] sample_counter;
  reg   [ 3:0] nxt;
  reg          pre_nxt;
  reg   [ 3:0] chn_servicing; 
  wire   [3:0] wts_rq;
  assign wstart=   !busy && rq_not_zero;
  assign wts_rq[3:0]= ts_rq_in[3:0] & ~ts_rq_in_d[3:0] & (~rdy[3:0] | chn_servicing[3:0]);
  always @ (posedge xclk) begin
    ts_rq_in_d[3:0] <= ts_rq_in[3:0];
    if (wstart) channel[1:0] <= {chn1hot[3] | chn1hot[2],chn1hot[3] | chn1hot[1]};
    if     (wstart) chn_servicing[3:0]  <= {chn1hot[3:1], ~|chn1hot[3:1]};
    else if (!busy) chn_servicing[3:0]  <= 4'h0;
    if (rst) ts_rq[3:0] <= 4'h0;
    else ts_rq[3:0] <=  ~ts_grant & ( wts_rq[3:0] | ts_rq[3:0]);
    if (rst) ts_valid[3:0] <= 4'h0;
    else ts_valid[3:0] <= (ts_grant[3:0] | (ts_valid & ~wts_rq[3:0]));
    channels_ready[3:0] <= ts_valid[3:0] & rdy[3:0] & ~chn_servicing[3:0]; 
    rq_not_zero <= channels_ready[3:0] != 4'h0;
    chn1hot[3:1] <= {channels_ready[3] & ~|channels_ready[2:0],
                     channels_ready[2] & ~|channels_ready[1:0],
                     channels_ready[1] &  ~channels_ready[0]};
    if  ((seq_cntr[4:0]=='h1e) || rst) busy <= 1'b0;
    else if (rq_not_zero)              busy <= 1'b1;
    if (!busy) seq_cntr[4:0] <= 5'h0;
    else       seq_cntr[4:0] <= seq_cntr[4:0] + 1;
    seq_cntr_last <= (seq_cntr[4:0]=='h1e);
    if      (wstart)              ts_en <=1'b1;
    else if (seq_cntr[1:0]==2'h3) ts_en <=1'b0;
    if (!ts_en) ts_sel[1:0] <= 2'h0;
    else        ts_sel[1:0] <=  ts_sel[1:0] + 1;
    if (!busy || (seq_cntr[4:0]=='h1d)) pre_nxt <= 1'b0;
    else if (seq_cntr[4:0]=='h01)       pre_nxt <= 1'b1;
    nxt [3:0]  <= pre_nxt? chn_servicing[3:0]:4'h0;
    dv <= busy || seq_cntr_last;
    inc_sample_counter <= seq_cntr_last;
    if (rst)                     sample_counter[23:0] <= 24'h0;
    else if (inc_sample_counter) sample_counter[23:0] <= sample_counter[23:0] +1;
  end
endmodule