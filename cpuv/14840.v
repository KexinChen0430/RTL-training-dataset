module instantiation
  generate if (1) begin : gen_gtwiz_userdata_rx_main
    genvar ch_idx;
    if ((P_RX_DATA_DECODING != 0) ||
       ((P_RX_DATA_DECODING == 0) && (P_RX_USER_DATA_WIDTH % 10 != 0))) begin : gen_rxdata
      for (ch_idx = 0; ch_idx < P_TOTAL_NUMBER_OF_CHANNELS; ch_idx = ch_idx + 1) begin : gen_assign
        assign gtwiz_userdata_rx_out[(P_RX_USER_DATA_WIDTH*ch_idx)+P_RX_USER_DATA_WIDTH-1:
                                     (P_RX_USER_DATA_WIDTH*ch_idx)] =
          rxdata_in[(128*ch_idx)+P_RX_USER_DATA_WIDTH-1:(128*ch_idx)];
      end
    end
    else begin : gen_rxdata_rxctrl
      case (P_RX_USER_DATA_WIDTH)
        20:
          for (ch_idx = 0; ch_idx < P_TOTAL_NUMBER_OF_CHANNELS; ch_idx = ch_idx + 1) begin : gen_width20
            assign gtwiz_userdata_rx_out [(ch_idx*20)+19:(ch_idx*20)] =
              {rxctrl1_in[(ch_idx* 16)+1],
               rxctrl0_in[(ch_idx* 16)+1],
               rxdata_in [(ch_idx*128)+15:(ch_idx*128)+8],
               rxctrl1_in[(ch_idx* 16)],
               rxctrl0_in[(ch_idx* 16)],
               rxdata_in [(ch_idx*128)+7:ch_idx*128]};
          end
        40:
          for (ch_idx = 0; ch_idx < P_TOTAL_NUMBER_OF_CHANNELS; ch_idx = ch_idx + 1) begin : gen_width40
            assign gtwiz_userdata_rx_out [(ch_idx*40)+39:(ch_idx*40)] =
              {rxctrl1_in[(ch_idx* 16)+3],
               rxctrl0_in[(ch_idx* 16)+3],
               rxdata_in [(ch_idx*128)+31:(ch_idx*128)+24],
               rxctrl1_in[(ch_idx* 16)+2],
               rxctrl0_in[(ch_idx* 16)+2],
               rxdata_in [(ch_idx*128)+23:(ch_idx*128)+16],
               rxctrl1_in[(ch_idx* 16)+1],
               rxctrl0_in[(ch_idx* 16)+1],
               rxdata_in [(ch_idx*128)+15:(ch_idx*128)+8],
               rxctrl1_in[(ch_idx* 16)],
               rxctrl0_in[(ch_idx* 16)],
               rxdata_in [(ch_idx*128)+7:ch_idx*128]};
          end
        80:
          for (ch_idx = 0; ch_idx < P_TOTAL_NUMBER_OF_CHANNELS; ch_idx = ch_idx + 1) begin : gen_width80
            assign gtwiz_userdata_rx_out [(ch_idx*80)+79:(ch_idx*80)] =
              {rxctrl1_in[(ch_idx* 16)+7],
               rxctrl0_in[(ch_idx* 16)+7],
               rxdata_in [(ch_idx*128)+63:(ch_idx*128)+56],
               rxctrl1_in[(ch_idx* 16)+6],
               rxctrl0_in[(ch_idx* 16)+6],
               rxdata_in [(ch_idx*128)+55:(ch_idx*128)+48],
               rxctrl1_in[(ch_idx* 16)+5],
               rxctrl0_in[(ch_idx* 16)+5],
               rxdata_in [(ch_idx*128)+47:(ch_idx*128)+40],
               rxctrl1_in[(ch_idx* 16)+4],
               rxctrl0_in[(ch_idx* 16)+4],
               rxdata_in [(ch_idx*128)+39:(ch_idx*128)+32],
               rxctrl1_in[(ch_idx* 16)+3],
               rxctrl0_in[(ch_idx* 16)+3],
               rxdata_in [(ch_idx*128)+31:(ch_idx*128)+24],
               rxctrl1_in[(ch_idx* 16)+2],
               rxctrl0_in[(ch_idx* 16)+2],
               rxdata_in [(ch_idx*128)+23:(ch_idx*128)+16],
               rxctrl1_in[(ch_idx* 16)+1],
               rxctrl0_in[(ch_idx* 16)+1],
               rxdata_in [(ch_idx*128)+15:(ch_idx*128)+8],
               rxctrl1_in[(ch_idx* 16)],
               rxctrl0_in[(ch_idx* 16)],
               rxdata_in [(ch_idx*128)+7:ch_idx*128]};
          end
        160:
          for (ch_idx = 0; ch_idx < P_TOTAL_NUMBER_OF_CHANNELS; ch_idx = ch_idx + 1) begin : gen_width160
            assign gtwiz_userdata_rx_out [(ch_idx*160)+159:(ch_idx*160)] =
              {rxctrl1_in[(ch_idx* 16)+15],
               rxctrl0_in[(ch_idx* 16)+15],
               rxdata_in [(ch_idx*128)+127:(ch_idx*128)+120],
               rxctrl1_in[(ch_idx* 16)+14],
               rxctrl0_in[(ch_idx* 16)+14],
               rxdata_in [(ch_idx*128)+119:(ch_idx*128)+112],
               rxctrl1_in[(ch_idx* 16)+13],
               rxctrl0_in[(ch_idx* 16)+13],
               rxdata_in [(ch_idx*128)+111:(ch_idx*128)+104],
               rxctrl1_in[(ch_idx* 16)+12],
               rxctrl0_in[(ch_idx* 16)+12],
               rxdata_in [(ch_idx*128)+103:(ch_idx*128)+96],
               rxctrl1_in[(ch_idx* 16)+11],
               rxctrl0_in[(ch_idx* 16)+11],
               rxdata_in [(ch_idx*128)+95:(ch_idx*128)+88],
               rxctrl1_in[(ch_idx* 16)+10],
               rxctrl0_in[(ch_idx* 16)+10],
               rxdata_in [(ch_idx*128)+87:(ch_idx*128)+80],
               rxctrl1_in[(ch_idx* 16)+9],
               rxctrl0_in[(ch_idx* 16)+9],
               rxdata_in [(ch_idx*128)+79:(ch_idx*128)+72],
               rxctrl1_in[(ch_idx* 16)+8],
               rxctrl0_in[(ch_idx* 16)+8],
               rxdata_in [(ch_idx*128)+71:(ch_idx*128)+64],
               rxctrl1_in[(ch_idx* 16)+7],
               rxctrl0_in[(ch_idx* 16)+7],
               rxdata_in [(ch_idx*128)+63:(ch_idx*128)+56],
               rxctrl1_in[(ch_idx* 16)+6],
               rxctrl0_in[(ch_idx* 16)+6],
               rxdata_in [(ch_idx*128)+55:(ch_idx*128)+48],
               rxctrl1_in[(ch_idx* 16)+5],
               rxctrl0_in[(ch_idx* 16)+5],
               rxdata_in [(ch_idx*128)+47:(ch_idx*128)+40],
               rxctrl1_in[(ch_idx* 16)+4],
               rxctrl0_in[(ch_idx* 16)+4],
               rxdata_in [(ch_idx*128)+39:(ch_idx*128)+32],
               rxctrl1_in[(ch_idx* 16)+3],
               rxctrl0_in[(ch_idx* 16)+3],
               rxdata_in [(ch_idx*128)+31:(ch_idx*128)+24],
               rxctrl1_in[(ch_idx* 16)+2],
               rxctrl0_in[(ch_idx* 16)+2],
               rxdata_in [(ch_idx*128)+23:(ch_idx*128)+16],
               rxctrl1_in[(ch_idx* 16)+1],
               rxctrl0_in[(ch_idx* 16)+1],
               rxdata_in [(ch_idx*128)+15:(ch_idx*128)+8],
               rxctrl1_in[(ch_idx* 16)],
               rxctrl0_in[(ch_idx* 16)],
               rxdata_in [(ch_idx*128)+7:ch_idx*128]};
          end
        default:
          begin : gen_default
            assign gtwiz_userdata_rx_out = {P_TOTAL_NUMBER_OF_CHANNELS*P_RX_USER_DATA_WIDTH{1'b1}};
          end
      endcase
    end
  end
  endgenerate
endmodule