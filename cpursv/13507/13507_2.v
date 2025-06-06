
module position_encoder(input  rsi_MRST_reset,
                        input  csi_MCLK_clk,
                        input  [31:0] avs_ctrl_writedata,
                        output reg [31:0] avs_ctrl_readdata,
                        input  [3:0] avs_ctrl_byteenable,
                        input  [1<<1:0] avs_ctrl_address,
                        input  avs_ctrl_write,
                        input  avs_ctrl_read,
                        output avs_ctrl_waitrequest,
                        input  A,
                        input  B,
                        input  Z);

  reg  [31:0] read_data;
  reg  [15:0] position;
  reg  direction;

  assign avs_ctrl_readdata = read_data;
  
  always @(posedge csi_MCLK_clk or posedge rsi_MRST_reset)
      begin
        if (rsi_MRST_reset) 
          begin
            read_data <= 0;
          end
        else 
          begin
            case (avs_ctrl_address)

              0: read_data <= 32'hEA680003;

              1: read_data <= {{16{position[15]}},position};

              1<<1: read_data <= {31'b0,direction};

              default: read_data <= 32'b0;

            endcase

          end
      end
  
  always @(posedge A or posedge rsi_MRST_reset)
      begin
        if (rsi_MRST_reset) position <= 16'b0;
        else if (Z) position <= 16'b0;
        else 
          begin
            if (B) position <= position+1;
            else position <= position-1;
            direction <= B;
          end
      end
endmodule

