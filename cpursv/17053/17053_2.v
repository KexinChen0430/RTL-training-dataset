
module aurora_201_RX_STREAM(RX_D,RX_SRC_RDY_N,START_RX,RX_PAD,RX_PE_DATA,RX_PE_DATA_V,
                            RX_SCP,RX_ECP,USER_CLK);

  output [0:15] RX_D;
  output RX_SRC_RDY_N;
  input  START_RX;
  input  RX_PAD;
  input  [0:15] RX_PE_DATA;
  input  RX_PE_DATA_V;
  input  RX_SCP;
  input  RX_ECP;
  input  USER_CLK;
  reg  infinite_frame_started_r;

  
  always @(posedge USER_CLK)
      if (!START_RX) infinite_frame_started_r <= #1 1'b0;
      else if (RX_SCP > 1'd0) infinite_frame_started_r <= #1 1'b1;
        
  assign RX_D = RX_PE_DATA;
  assign RX_SRC_RDY_N = !(infinite_frame_started_r && RX_PE_DATA_V);
endmodule

