
module SyncToClock(clk_i,unsynced_i,synced_o);

  parameter  syncStages = 1<<1;
  input  clk_i;
  input  unsynced_i;
  output synced_o;
  reg  [syncStages:1] sync_r;

  
  always @(posedge clk_i)
      sync_r <= {sync_r[syncStages+(0-1):1],unsynced_i};
  assign synced_o = sync_r[syncStages];
endmodule

