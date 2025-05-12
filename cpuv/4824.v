module outputs;
  wire [4 : 0] led;
  wire RDY_ledDrive;
  reg doInit;
  wire doInit$D_IN, doInit$EN;
  reg [31 : 0] freeCnt;
  wire [31 : 0] freeCnt$D_IN;
  wire freeCnt$EN;
  reg [4 : 0] ledReg;
  wire [4 : 0] ledReg$D_IN;
  wire ledReg$EN;
  reg [4 : 0] CASE_freeCnt_BITS_25_TO_23_3_0_IF_freeCnt_BIT__ETC__q1;
  wire [4 : 0] x__h621, x__h622;
  assign RDY_ledDrive = 1'd1;
  assign led = doInit ? CASE_freeCnt_BITS_25_TO_23_3_0_IF_freeCnt_BIT__ETC__q1 : ~x__h621;
  assign doInit$D_IN = 1'd0;
  assign doInit$EN = freeCnt > 32'h08000000;
  assign freeCnt$D_IN = freeCnt + 32'd1;
  assign freeCnt$EN = 1'd1;
  assign ledReg$D_IN = ledDrive_i; 
  assign ledReg$EN = EN_ledDrive;  
  assign x__h621 = x__h622 | ledReg;
  assign x__h622 = freeCnt[23] ? 5'h01 : 5'h0;
  always@(freeCnt) begin
    case (freeCnt[25:23])
      3'd0, 3'd1, 3'd2, 3'd6, 3'd7:
        CASE_freeCnt_BITS_25_TO_23_3_0_IF_freeCnt_BIT__ETC__q1 = freeCnt[21] ? 5'd3 : 5'd31;
      3'd3: CASE_freeCnt_BITS_25_TO_23_3_0_IF_freeCnt_BIT__ETC__q1 = 5'd27;
      3'd4: CASE_freeCnt_BITS_25_TO_23_3_0_IF_freeCnt_BIT__ETC__q1 = 5'd19;
      3'd5: CASE_freeCnt_BITS_25_TO_23_3_0_IF_freeCnt_BIT__ETC__q1 = 5'd3;
    endcase
  end
  always@(posedge CLK) begin
    if (RST_N == `BSV_RESET_VALUE) begin
      doInit <= `BSV_ASSIGNMENT_DELAY 1'd1;
      freeCnt <= `BSV_ASSIGNMENT_DELAY 32'd0;
      ledReg <= `BSV_ASSIGNMENT_DELAY 5'd0;
    end else begin
      if (doInit$EN) doInit <= `BSV_ASSIGNMENT_DELAY doInit$D_IN;
      if (freeCnt$EN) freeCnt <= `BSV_ASSIGNMENT_DELAY freeCnt$D_IN;
      if (ledReg$EN) ledReg <= `BSV_ASSIGNMENT_DELAY ledReg$D_IN;
    end
  end
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else 
  initial begin
    doInit = 1'h0;
    freeCnt = 32'hAAAAAAAA;
    ledReg = 5'h0A;
  end
  `endif 
endmodule