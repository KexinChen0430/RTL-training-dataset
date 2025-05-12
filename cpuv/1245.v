module e203_reset_ctrl #(
    parameter MASTER = 1 
)(
  input  clk,        
  input  rst_n,      
  input  test_mode,  
  output rst_core,
  `ifdef E203_HAS_ITCM
  output rst_itcm,
  `endif
  `ifdef E203_HAS_DTCM
  output rst_dtcm,
  `endif
  output rst_aon
);
wire rst_sync_n;
`ifndef E203_HAS_LOCKSTEP
localparam RST_SYNC_LEVEL = `E203_ASYNC_FF_LEVELS; 
`endif
reg [RST_SYNC_LEVEL-1:0] rst_sync_r;
generate
  if(MASTER == 1) begin:master_gen 
     always @(posedge clk or negedge rst_n)
     begin:rst_sync_PROC
       if(rst_n == 1'b0) 
         begin
           rst_sync_r[RST_SYNC_LEVEL-1:0] <= {RST_SYNC_LEVEL{1'b0}};
         end
       else 
         begin
           rst_sync_r[RST_SYNC_LEVEL-1:0] <= {rst_sync_r[RST_SYNC_LEVEL-2:0],1'b1};
         end
     end
     assign rst_sync_n = test_mode ? rst_n : rst_sync_r[`E203_ASYNC_FF_LEVELS-1];
  end
  else begin:slave_gen 
     always @ *
     begin:rst_sync_PROC
       rst_sync_r = {RST_SYNC_LEVEL{1'b0}};
     end
     assign rst_sync_n = rst_n;
  end
endgenerate
assign rst_core = rst_sync_n;
`ifdef E203_HAS_ITCM
assign rst_itcm = rst_sync_n;
`endif
`ifdef E203_HAS_DTCM
assign rst_dtcm = rst_sync_n;
`endif
assign rst_aon = rst_sync_n;
endmodule 