
module early_boot(input  CLK_I,
                  input  RST_I,
                  output reg CYC_O,
                  output reg [31:0] DAT_O,
                  output reg STB_O,
                  output reg WE_O,
                  output reg [31:2] ADR_O,
                  output [3:0] SEL_O,
                  input  [31:0] DAT_I,
                  input  ACK_I,
                  input  ERR_I,
                  input  RTY_I,
                  output loading_finished_o);

  assign SEL_O = 4'b1111;
  assign loading_finished_o = (state == S_FINISHED) ? 1'b1 : 1'b0;
  reg  [3:0] state;

  reg  [9:0] wait_counter;

  parameter [3:0] 
       S_CHECK_STATUS     = 4'd0,
       S_CHECK_STATUS_2   = 4'd1,
       S_CHECK_STATUS_3   = 4'd2,
       S_SET_SIZE         = 4'd3,
       S_SET_SIZE_2       = 4'd4,
       S_SET_CONTROL      = 4'd5,
       S_SET_CONTROL_2    = 4'd6,
       S_CHECK_FINISHED   = 4'd7,
       S_CHECK_FINISHED_2 = 4'd8,
       S_CHECK_FINISHED_3 = 4'd9,
       S_FINISHED         = 4'd10;

  
  always @(posedge CLK_I)
      begin
        if (RST_I == 1'b1) 
          begin
            CYC_O <= 1'b0;
            DAT_O <= 32'd0;
            STB_O <= 1'b0;
            WE_O <= 1'b0;
            ADR_O <= 30'd0;
            state <= S_CHECK_STATUS;
            wait_counter <= 10'd0;
          end
        else if (state == S_CHECK_STATUS) 
          begin
            CYC_O <= 1'b1;
            DAT_O <= 32'd0;
            STB_O <= 1'b1;
            WE_O <= 1'b0;
            ADR_O <= 30'h30000000;
            state <= S_CHECK_STATUS_2;
          end
          
      end
endmodule

