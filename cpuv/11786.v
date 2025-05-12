module crc16( 
  input [7:0] data_in, 
  input crc_en, 
  output [15:0] crc_out, 
  input rst, 
  input clk); 
  reg [15:0] lfsr_q,lfsr_c; 
  assign crc_out = lfsr_q; 
  always @(*) begin
    lfsr_c[0] = lfsr_q[8] ^ lfsr_q[9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15] ^ data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];
  end 
  always @(posedge clk, posedge rst) begin
    if(rst) begin
      lfsr_q <= {16{1'b1}}; 
    end
    else begin
      lfsr_q <= crc_en ? lfsr_c : lfsr_q; 
    end
  end 
endmodule