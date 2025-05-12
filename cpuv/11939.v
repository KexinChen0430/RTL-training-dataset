module USER_LOGIC #(parameter C_PCI_DATA_WIDTH = 128) 
(                          input  wire                        CLK, 
                           input  wire                        RST, 
                           output wire                        CHNL_RX_CLK, 
 (* mark_debug = "true" *) input  wire                        CHNL_RX, 
 (* mark_debug = "true" *) output wire                        CHNL_RX_ACK, 
 (* mark_debug = "true" *) input  wire                        CHNL_RX_LAST, 
 (* mark_debug = "true" *) input  wire [31:0]                 CHNL_RX_LEN, 
 (* mark_debug = "true" *) input  wire [30:0]                 CHNL_RX_OFF, 
 (* mark_debug = "true" *) input  wire [C_PCI_DATA_WIDTH-1:0] CHNL_RX_DATA, 
 (* mark_debug = "true" *) input  wire                        CHNL_RX_DATA_VALID, 
 (* mark_debug = "true" *) output wire                        CHNL_RX_DATA_REN, 
                           output wire                        CHNL_TX_CLK, 
 (* mark_debug = "true" *) output wire                        CHNL_TX, 
 (* mark_debug = "true" *) input  wire                        CHNL_TX_ACK, 
 (* mark_debug = "true" *) output wire                        CHNL_TX_LAST, 
 (* mark_debug = "true" *) output wire [31:0]                 CHNL_TX_LEN, 
 (* mark_debug = "true" *) output wire [30:0]                 CHNL_TX_OFF, 
 (* mark_debug = "true" *) output wire [C_PCI_DATA_WIDTH-1:0] CHNL_TX_DATA, 
 (* mark_debug = "true" *) output wire                        CHNL_TX_DATA_VALID, 
 (* mark_debug = "true" *) input  wire                        CHNL_TX_DATA_REN); 
reg [C_PCI_DATA_WIDTH-1:0] rData; 
reg [31:0]                 rLen; 
(* mark_debug = "true" *) reg [31:0]                 rCount; 
(* mark_debug = "true" *) reg [1:0]                  rState; 
assign CHNL_RX_CLK        = CLK; 
assign CHNL_RX_ACK        = (rState == 2'd1); 
assign CHNL_RX_DATA_REN   = (rState == 2'd1); 
assign CHNL_TX_CLK        = CLK; 
assign CHNL_TX            = (rState == 2'd3); 
assign CHNL_TX_LAST       = 1'd1; 
assign CHNL_TX_LEN        = rLen; 
assign CHNL_TX_OFF        = 0; 
assign CHNL_TX_DATA       = rData; 
assign CHNL_TX_DATA_VALID = (rState == 2'd3); 
always @(posedge CLK) begin 
  if (RST) begin 
    rLen   <= 0; 
    rCount <= 0; 
    rState <= 0; 
    rData  <= 0; 
  end	else begin 
    case (rState) 
      2'd0: begin 
        if (CHNL_RX) begin 
          rLen   <= CHNL_RX_LEN; 
          rCount <= 0; 
          rState <= 2'd1; 
        end
      end
      2'd1: begin 
        if (CHNL_RX_DATA_VALID) begin 
          rData  <= CHNL_RX_DATA; 
          rCount <= rCount + (C_PCI_DATA_WIDTH/32); 
        end
        if (rCount >= rLen) rState <= 2'd2; 
      end
      2'd2: begin 
        rCount <= (C_PCI_DATA_WIDTH/32); 
        rState <= 2'd3; 
      end
  2'd3: begin 
        if (CHNL_TX_DATA_REN & CHNL_TX_DATA_VALID) begin 
          rData  <= {rCount+32'd4, rCount+32'd3, rCount+32'd2, rCount+32'd1}; 
          rCount <= rCount + (C_PCI_DATA_WIDTH/32); 
          if (rCount >= rLen) rState <= 2'd0; 
        end
      end
    endcase
  end
end
endmodule