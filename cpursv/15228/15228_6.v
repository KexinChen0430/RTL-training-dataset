
module SCCBCtrl(clk_i,rst_i,sccb_clk_i,data_pulse_i,addr_i,data_i,data_o,
                rw_i,start_i,ack_error_o,done_o,sioc_o,siod_io);

  input  clk_i;
  input  rst_i;
  input  sccb_clk_i;
  input  data_pulse_i;
  input  [7:0] addr_i;
  input  [15:0] data_i;
  output reg [7:0] data_o;
  input  rw_i;
  input  start_i;
  output ack_error_o;
  output reg done_o;
  output sioc_o;
  inout  siod_io;
  reg   sccb_stm_clk = 1;
  reg  [6:0]  stm = 0;
  reg   bit_out = 1;
  reg   ack_err1 = 1;
  reg   ack_err2 = 1;
  reg   ack_err3 = 1;

  assign sioc_o = (((start_i == 1) && (stm <= 62) && (stm >= 55)) || 
                  ((start_i == 1) && (stm == 64)) || 
                  (
((stm == 53) || (stm == 36) || ((stm >= 44) && (stm <= 51)) || 
((stm <= 34) && ((stm == 36) || (stm >= 27)))) && 
(((stm <= 51) && ((stm >= 44) && (start_i == 1))) || 
(
((stm >= 55) || 
((stm == 53) || 
((stm == 36) || 
(
(((stm == 25) || (stm <= 34)) && 
((stm == 25) || (stm >= 27))) || (stm == 14) || 
(
((stm == 14) || 
((stm >= 5) && 
(
((stm >= 16) || (stm == 14) || 
(((stm == 14) || (stm == 14) || (stm >= 5)) && 
(stm <= 12))) && ((stm == 14) || (stm <= 12))))) && 
(((stm >= 16) || (stm >= 5)) && 
((stm <= 12) || (stm >= 16))))) || 
(
(
((stm == 14) || 
((stm >= 5) && 
(
((stm >= 16) || (stm == 14) || 
(((stm == 14) || (stm == 14) || (stm >= 5)) && 
(stm <= 12))) && ((stm == 14) || (stm <= 12))))) && (stm <= 23)) || ((stm <= 23) && (stm >= 16)))))) && (start_i == 1)))) || 
                  (
((stm == 14) || (stm <= 23) || 
(((stm == 14) || (stm == 14) || (stm >= 5)) && 
(stm <= 12)) || (stm == 25)) && 
((stm == 25) || ((stm >= 5) && (stm <= 12)) || 
((stm >= 16) || (stm == 14))) && 
(((stm <= 51) && ((stm >= 44) && (start_i == 1))) || 
(
((stm >= 55) || 
((stm == 53) || 
((stm == 36) || 
(
(((stm == 25) || (stm <= 34)) && 
((stm == 25) || (stm >= 27))) || (stm == 14) || 
(
((stm == 14) || 
((stm >= 5) && 
(
((stm >= 16) || (stm == 14) || 
(((stm == 14) || (stm == 14) || (stm >= 5)) && 
(stm <= 12))) && ((stm == 14) || (stm <= 12))))) && 
(((stm >= 16) || (stm >= 5)) && 
((stm <= 12) || (stm >= 16))))) || 
(
(
((stm == 14) || 
((stm >= 5) && 
(
((stm >= 16) || (stm == 14) || 
(((stm == 14) || (stm == 14) || (stm >= 5)) && 
(stm <= 12))) && ((stm == 14) || (stm <= 12))))) && (stm <= 23)) || ((stm <= 23) && (stm >= 16)))))) && (start_i == 1))))) ? sccb_clk_i : sccb_stm_clk;
  assign siod_io = (
(((stm == 53) || (stm >= 54)) && 
((stm <= 62) || 
((stm == 52) || 
(
((stm == 53) || (stm == 36) || 
((stm == 14) || (stm == 25) || (stm == 13) || (stm == 24))) && 
((stm >= 54) || ((stm == 53) || (stm == 52)) || 
((stm == 35) || 
((stm == 25) || (stm == 24) || (stm == 36)) || ((stm == 13) || (stm == 14))))) || 
(
((stm >= 54) || ((stm == 53) || (stm == 52)) || 
((stm == 35) || 
((stm == 25) || (stm == 24) || (stm == 36)) || ((stm == 13) || (stm == 14)))) && (stm == 35))))) || 
                   ((stm == 36) || (stm == 52) || (stm == 35) || (stm == 25)) || ((stm == 13) || (stm == 14) || (stm == 24))) ? 1'bz : bit_out;
  assign ack_error_o = (ack_err1 | ack_err2) | ack_err3;
  
  always @(posedge clk_i or negedge rst_i)
      begin
        if (rst_i == 0) 
          begin
            stm <= 0;
            sccb_stm_clk <= 1;
            bit_out <= 1;
            data_o <= 0;
            done_o <= 0;
            ack_err1 <= 1;
            ack_err2 <= 1;
            ack_err3 <= 1;
          end
        else if (data_pulse_i) 
          begin

          end
          
      end
endmodule

