
module master_0_p2b_adapter(input  clk,
                            input  reset_n,
                            output reg in_ready,
                            input  in_valid,
                            input  [7:0] in_data,
                            input  in_startofpacket,
                            input  in_endofpacket,
                            input  out_ready,
                            output reg out_valid,
                            output reg [7:0] out_data,
                            output reg out_startofpacket,
                            output reg out_endofpacket,
                            output reg [7:0] out_channel);

  reg   in_channel = 0;

  
  always @* 
      begin
        in_ready = out_ready;
        out_valid = in_valid;
        out_data = in_data;
        out_startofpacket = in_startofpacket;
        out_endofpacket = in_endofpacket;
        out_channel = 0;
        out_channel = in_channel;
      end
endmodule

