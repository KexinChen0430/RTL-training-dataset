
module SigRegisterFile(clk_in,reset_in,writeEnableR0_in,writeEnableR1_in,
                       writeValueR0_in,writeValueR1_in,shiftEnableR0_in,
                       readSelectA_in,readSelectB_in,readResultA_out,readResultB_out);

  parameter  REGISTER_WIDTH = 'd32;
  parameter  CONST0_VALUE = 32'd0;
  parameter  CONST1_VALUE = 32'd1;
  parameter  CONST2_VALUE = 32'd2;
  parameter  CONST3_VALUE = 32'd128;
  parameter  CONST4_VALUE = 32'd127;
  parameter  CONST5_VALUE = 32'd5;
  parameter  CONST6_VALUE = 32'd6;
  parameter  CONST7_VALUE = 32'h20000000;
  parameter  CONST8_VALUE = 32'hffffffff;
  input  clk_in,reset_in;
  input  writeEnableR0_in,writeEnableR1_in;
  input  [REGISTER_WIDTH+(0-1):0] writeValueR0_in,writeValueR1_in;
  input  shiftEnableR0_in;
  input  [3:0] readSelectA_in,readSelectB_in;
  output reg [REGISTER_WIDTH+(0-1):0] readResultA_out,readResultB_out;
  reg  [REGISTER_WIDTH+(0-1):0] reg0,reg1;

  
  always @(readSelectA_in or readSelectB_in or reg0 or reg1)
      begin
        case (readSelectA_in)

          4'b0000: readResultA_out = reg0;

          4'b0001: readResultA_out = reg1;

          default: begin
                $display("SRF: Undefined register port");
                readResultA_out = 0;
              end

        endcase

      end
  
  always @(posedge clk_in)
      begin
        if (reset_in == 1'b1) 
          begin
            reg0 = 0;
            reg1 <= 0;
          end
        else 
          begin
            if (writeEnableR0_in) reg0 = writeValueR0_in;
              
            if (shiftEnableR0_in) reg0 = (1+1)*reg0;
              
            if (writeEnableR1_in == 1'b1) reg1 <= writeValueR1_in;
              
          end
      end
endmodule

