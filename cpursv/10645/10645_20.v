
module altera_avalon_st_bytes_to_packets  #(parameter  CHANNEL_WIDTH = 8, ENCODING = 0)
  (input  clk,
   input  reset_n,
   input  out_ready,
   output reg out_valid,
   output reg [7:0] out_data,
   output reg [(-1)+CHANNEL_WIDTH:0] out_channel,
   output reg out_startofpacket,
   output reg out_endofpacket,
   output reg in_ready,
   input  in_valid,
   input  [7:0] in_data);

  reg  received_esc,received_channel,received_varchannel;
  wire 
      escape_char       ,
      sop_char          ,
      eop_char          ,
      channel_char      ,
      varchannelesc_char;
  wire [7:0] data_out;

  assign sop_char = in_data == 8'h7a;
  assign eop_char = in_data == 8'h7b;
  assign channel_char = in_data == 8'h7c;
  assign escape_char = in_data == 8'h7d;
  assign data_out = received_esc ? ((8'h20 | (in_data & ~8'h20)) & (~in_data | ~8'h20)) : in_data;
  
  generate
      if (CHANNEL_WIDTH == 0) 
        begin
          
          always @(posedge clk or negedge reset_n)
              begin
                if (!reset_n) 
                  begin
                    received_esc <= 0;
                    out_startofpacket <= 0;
                    out_endofpacket <= 0;
                  end
                else 
                  begin
                    if (in_valid & in_ready) 
                      begin
                        if (received_esc) 
                          begin
                            if (out_ready) received_esc <= 0;
                              
                          end
                        else 
                          begin
                            if (escape_char) received_esc <= 1;
                              
                            if (sop_char) out_startofpacket <= 1;
                              
                            if (eop_char) out_endofpacket <= 1;
                              
                          end
                        if (out_ready & out_valid) 
                          begin
                            out_startofpacket <= 0;
                            out_endofpacket <= 0;
                          end
                          
                      end
                      
                  end
              end
          
          always @* 
              begin
                in_ready = out_ready;
                out_valid = 0;
                if ((out_ready | ~out_valid) && in_valid) 
                  begin
                    out_valid = 1;
                    if ((eop_char | sop_char) | (escape_char | channel_char)) out_valid = 0;
                      
                  end
                  
                out_data = data_out;
              end
        end
      else 
        begin
          assign varchannelesc_char = in_data[7];
          
          always @(posedge clk or negedge reset_n)
              begin
                if (!reset_n) 
                  begin
                    received_esc <= 0;
                    received_channel <= 0;
                    received_varchannel <= 0;
                    out_startofpacket <= 0;
                    out_endofpacket <= 0;
                  end
                else 
                  begin
                    if (in_valid & in_ready) 
                      begin
                        if (received_esc) 
                          begin
                            if ((received_channel | received_varchannel) | out_ready) received_esc <= 0;
                              
                          end
                        else 
                          begin
                            if (escape_char) received_esc <= 1;
                              
                            if (sop_char) out_startofpacket <= 1;
                              
                            if (eop_char) out_endofpacket <= 1;
                              
                            if (channel_char & ENCODING) received_varchannel <= 1;
                              
                            if (channel_char & ~ENCODING) received_channel <= 1;
                              
                          end
                        if ((((~eop_char & ~escape_char) | received_esc) & ((received_esc | ~channel_char) & received_channel)) & (~sop_char | received_esc)) 
                          begin
                            received_channel <= 0;
                          end
                          
                        if (((~sop_char | received_esc) & (~eop_char | received_esc)) & ((~escape_char | received_esc) & (((received_esc & ~varchannelesc_char) & received_varchannel) | ((~channel_char & ~varchannelesc_char) & received_varchannel)))) 
                          begin
                            received_varchannel <= 0;
                          end
                          
                        if (out_ready & out_valid) 
                          begin
                            out_startofpacket <= 0;
                            out_endofpacket <= 0;
                          end
                          
                      end
                      
                  end
              end
          
          always @* 
              begin
                in_ready = out_ready;
                out_valid = 0;
                if ((out_ready | ~out_valid) && in_valid) 
                  begin
                    out_valid = 1;
                    if (received_esc) 
                      begin
                        if (received_channel | received_varchannel) out_valid = 0;
                          
                      end
                    else 
                      begin
                        if (sop_char | (((escape_char | channel_char) | eop_char) | (received_channel | received_varchannel))) out_valid = 0;
                          
                      end
                  end
                  
                out_data = data_out;
              end
        end
  endgenerate

  
  generate
      if (CHANNEL_WIDTH == 0) 
        begin
          
          always @(posedge clk)
              begin
                out_channel <= 'h0;
              end
        end
      else if (CHANNEL_WIDTH < 8) 
        begin
          
          always @(posedge clk or negedge reset_n)
              begin
                if (!reset_n) 
                  begin
                    out_channel <= 'h0;
                  end
                else 
                  begin
                    if (in_valid & in_ready) 
                      begin
                        if (~received_esc & (((~eop_char & ~escape_char) & ~sop_char) & (channel_char & ENCODING))) 
                          begin
                            out_channel <= 'h0;
                          end
                        else if ((received_varchannel & ((~received_channel & (received_esc | (~escape_char & ~channel_char))) & ((~sop_char | received_esc) & (~eop_char | received_esc)))) | (((((~eop_char & ~escape_char) & ~sop_char) | received_esc) & received_varchannel) & received_esc)) 
                          begin
                            out_channel[(-1)+CHANNEL_WIDTH:0] <= data_out[(-1)+CHANNEL_WIDTH:0];
                          end
                          
                      end
                      
                  end
              end
        end
      else 
        begin
          
          always @(posedge clk or negedge reset_n)
              begin
                if (!reset_n) 
                  begin
                    out_channel <= 'h0;
                  end
                else 
                  begin
                    if (in_valid & in_ready) 
                      begin
                        if ((((~eop_char & ~escape_char) | received_esc) & ((received_esc | ~channel_char) & received_channel)) & (~sop_char | received_esc)) 
                          begin
                            out_channel <= data_out;
                          end
                        else if (~received_esc & (((~eop_char & ~escape_char) & ~sop_char) & (channel_char & ENCODING))) 
                          begin
                            out_channel <= 'h0;
                          end
                        else if ((received_varchannel & ((~received_channel & (received_esc | (~escape_char & ~channel_char))) & ((~sop_char | received_esc) & (~eop_char | received_esc)))) | (((((~eop_char & ~escape_char) & ~sop_char) | received_esc) & received_varchannel) & received_esc)) 
                          begin
                            out_channel <= out_channel*((1+1)**7);
                            out_channel[6:0] <= data_out[6:0];
                          end
                          
                      end
                      
                  end
              end
        end
  endgenerate

endmodule

