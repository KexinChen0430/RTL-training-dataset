
module atr_controller(input  clk_i,
                      input  rst_i,
                      input  [5:0] adr_i,
                      input  [3:0] sel_i,
                      input  [31:0] dat_i,
                      output reg [31:0] dat_o,
                      input  we_i,
                      input  stb_i,
                      input  cyc_i,
                      output reg ack_o,
                      input  run_rx,
                      input  run_tx,
                      output [31:0] ctrl_lines);

  reg  [3:0] state;
  reg  [31:0] atr_ram[0:15];

  
  always @(posedge clk_i)
      if (cyc_i & (stb_i & we_i)) 
        begin
          if (sel_i[3]) atr_ram[adr_i[5:2]][31:24] <= dat_i[31:24];
            
          if (sel_i[2]) atr_ram[adr_i[5:2]][23:16] <= dat_i[23:16];
            
          if (sel_i[1]) atr_ram[adr_i[5:2]][15:8] <= dat_i[15:8];
            
          if (sel_i[0]) atr_ram[adr_i[5:2]][7:0] <= dat_i[7:0];
            
        end
        
  
  always   dat_o <= 32'd0;
  
  always @(posedge clk_i)
      ack_o <= stb_i & (cyc_i & ~ack_o);
  assign ctrl_lines = atr_ram[state];
  localparam  ATR_IDLE = 4'd0;

  localparam  ATR_TX = 4'd1;

  localparam  ATR_RX = 4'd2;

  localparam  ATR_FULL_DUPLEX = 4'd3;

  
  always @(posedge clk_i)
      if (rst_i) state <= ATR_IDLE;
      else 
        case ({run_rx,run_tx})

          2'b00: state <= ATR_IDLE;

          2'b01: state <= ATR_TX;

          2'b10: state <= ATR_RX;

          2'b11: state <= ATR_FULL_DUPLEX;

        endcase

endmodule

