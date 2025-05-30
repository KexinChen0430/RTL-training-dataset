module IBUFDS_GTE3 #( 
  `ifdef XIL_TIMING 
  parameter LOC = "UNPLACED", 
  `endif
  parameter [0:0] REFCLK_EN_TX_PATH = 1'b0, 
  parameter [1:0] REFCLK_HROW_CK_SEL = 2'b00, 
  parameter [1:0] REFCLK_ICNTL_RX = 2'b00 
)(
  output O, 
  output ODIV2, 
  input CEB, 
  input I, 
  input IB 
);
  localparam MODULE_NAME = "IBUFDS_GTE3"; 
  `ifndef XIL_DR 
  localparam [0:0] REFCLK_EN_TX_PATH_REG = REFCLK_EN_TX_PATH; 
  localparam [1:0] REFCLK_HROW_CK_SEL_REG = REFCLK_HROW_CK_SEL; 
  localparam [1:0] REFCLK_ICNTL_RX_REG = REFCLK_ICNTL_RX; 
  `endif
  wire REFCLK_EN_TX_PATH_BIN; 
  wire [1:0] REFCLK_HROW_CK_SEL_BIN; 
  wire [1:0] REFCLK_ICNTL_RX_BIN; 
  wire i_in, ib_in, ceb_in; 
  tri0 GSR = glbl.GSR; 
 `ifdef XIL_TIMING 
  reg notifier; 
  `endif
  `ifdef XIL_DR 
  `include "IBUFDS_GTE3_dr.v" 
  `endif
  assign i_in = I; 
  assign ib_in = IB; 
  assign ceb_in = CEB; 
  assign REFCLK_EN_TX_PATH_BIN = REFCLK_EN_TX_PATH_REG; 
  assign REFCLK_HROW_CK_SEL_BIN = REFCLK_HROW_CK_SEL_REG; 
  assign REFCLK_ICNTL_RX_BIN = REFCLK_ICNTL_RX_REG; 
   reg  ODIV2_out=0; 
   wire  O_out; 
   reg [2:0] ce_count = 1; 
   reg [2:0] edge_count = 0; 
   reg allEqual; 
   initial begin 
        allEqual = 0; 
     end 
    always @(posedge I) begin 
         if(allEqual) 
             edge_count <= 3'b000; 
          else
             if (CEB == 1'b0) 
                 edge_count <= edge_count + 1; 
     end
    always @(edge_count) 
        if (edge_count == ce_count) 
           allEqual = 1; 
        else
          allEqual = 0; 
    always @(*) begin 
       case (REFCLK_HROW_CK_SEL_BIN) 
	 2'b00: ODIV2_out <= O_out; 
         2'b01: ODIV2_out <= allEqual; 
         2'b10: ODIV2_out <= 1'b0; 
         2'b11: ODIV2_out <= 1'b0; 
         default : ODIV2_out <= O_out; 
	   endcase
    end
   assign O_out = (REFCLK_EN_TX_PATH_BIN | ceb_in) ? 1'b0 : i_in; 
    assign O  = O_out; 
    assign ODIV2   = ODIV2_out; 
  specify 
    (CEB => O) = (0:0:0, 0:0:0); 
    (CEB => ODIV2) = (0:0:0, 0:0:0); 
    (I => O) = (0:0:0, 0:0:0); 
    (I => ODIV2) = (0:0:0, 0:0:0); 
    (IB => O) = (0:0:0, 0:0:0); 
    (IB => ODIV2) = (0:0:0, 0:0:0); 
    specparam PATHPULSE$ = 0; 
  endspecify
endmodule