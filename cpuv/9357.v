module outputs 
  reg [31 : 0] read; 
  wire RDY_read, RDY_write; 
  reg [3 : 0] rag; 
  wire [3 : 0] rag$D_IN; 
  wire rag$EN; 
  reg [31 : 0] regs; 
  wire [31 : 0] regs$D_IN; 
  wire regs$EN; 
  reg [31 : 0] regs_1; 
  wire [31 : 0] regs_1$D_IN; 
  wire regs_1$EN; 
  reg [31 : 0] regs_2; 
  wire [31 : 0] regs_2$D_IN; 
  wire regs_2$EN; 
  reg [31 : 0] regs_3; 
  wire [31 : 0] regs_3$D_IN; 
  wire regs_3$EN; 
  reg [3 : 0] wag; 
  wire [3 : 0] wag$D_IN; 
  wire wag$EN; 
  assign RDY_write = 1'd1 ; 
  always@(rag or regs_3 or regs or regs_1 or regs_2) 
  begin
    case (rag) 
      4'd0: read = regs; 
      4'd1: read = regs_1; 
      4'd2: read = regs_2; 
      default: read = regs_3; 
    endcase
  end
  assign RDY_read = 1'd1 ; 
  assign rag$D_IN = rag + 4'd1 ; 
  assign rag$EN = EN_read ; 
  assign regs$D_IN = write_arg ; 
  assign regs$EN = EN_write && wag == 4'd0 ; 
  assign regs_1$D_IN = write_arg ; 
  assign regs_1$EN = EN_write && wag == 4'd1 ; 
  assign regs_2$D_IN = write_arg ; 
  assign regs_2$EN = EN_write && wag == 4'd2 ; 
  assign regs_3$D_IN = write_arg ; 
  assign regs_3$EN = EN_write && wag == 4'd3 ; 
  assign wag$D_IN = wag ; 
  assign wag$EN = EN_write ; 
  always@(posedge CLK) 
  begin
    if (!RST_N) 
      begin
        rag <= `BSV_ASSIGNMENT_DELAY 4'd0; 
	wag <= `BSV_ASSIGNMENT_DELAY 4'd0; 
      end
    else 
      begin
        if (rag$EN) rag <= `BSV_ASSIGNMENT_DELAY rag$D_IN; 
	if (wag$EN) wag <= `BSV_ASSIGNMENT_DELAY wag$D_IN; 
      end
    if (regs$EN) regs <= `BSV_ASSIGNMENT_DELAY regs$D_IN; 
    if (regs_1$EN) regs_1 <= `BSV_ASSIGNMENT_DELAY regs_1$D_IN; 
    if (regs_2$EN) regs_2 <= `BSV_ASSIGNMENT_DELAY regs_2$D_IN; 
    if (regs_3$EN) regs_3 <= `BSV_ASSIGNMENT_DELAY regs_3$D_IN; 
  end
  `ifdef BSV_NO_INITIAL_BLOCKS 
  `else 
  initial 
  begin
    rag = 4'hA; 
    regs = 32'hAAAAAAAA; 
    regs_1 = 32'hAAAAAAAA; 
    regs_2 = 32'hAAAAAAAA; 
    regs_3 = 32'hAAAAAAAA; 
    wag = 4'hA; 
  end
  `endif 
endmodule 