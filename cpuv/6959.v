module hdr; 
   localparam WAIT_DATA = 3'b000,
              READ_WAIT_FIFO = 3'b001,
              WAIT_CYCLE = 3'b010,
              NETFPGA_HDR = 3'b011,
              WORD_0 = 3'b100,
              WORD_1 = 3'b101,
              WORD_2 = 3'b110,
              WORD_3 = 3'b111,
              WORD_4 = 4'b1000,
              WORD_5 = 4'b1001,
              WORD_6 = 4'b1010,
              WORD_7 = 4'b1011,
              INTERPKT_GAP = 4'b1100,
              PUT = 2'b00,
              FLUSH = 2'b01,
              TCHECK = 2'b10;
   input wire clk, reset, out_rdy, start_update, timeout_expired;
   input wire [63:0] tx_ext_update_q, dram_fifo_readdata;
   input wire [31:0] accum_value_fifo_dataout;
   input wire accum_value_fifo_empty, dram_fifo_empty, tx_ext_update_empty;
   output reg [63:0] out_data;
   output reg [7:0] out_ctrl;
   output reg out_wr;
   output reg tx_ext_update_rdreq, dram_fifo_read, accum_value_fifo_rdreq;
   output reg [31:0] packet_sent;
   reg [2:0] state, state_next;
   reg [1:0] select, select_next;
   reg [63:0] out_data_next;
   reg [7:0] out_ctrl_next;
   reg out_wr_next;
   reg [31:0] key, key_next, val, val_next;
   reg [7:0] pkt_count, pkt_count_next;
   reg start_timeout, start_timeout_next;
   reg dram_fifo_read_next, accum_value_fifo_rdreq_next, tx_ext_update_rdreq_next;
   always @(*) begin
      state_next                    = state;
      dram_fifo_read_next           = 1'b0;
      accum_value_fifo_rdreq_next   = 1'b0;
      start_timeout_next            = 0;
      tx_ext_update_rdreq_next      = 1'b0;
      select_next                   = select;
      out_data_next                 = out_data;
      out_ctrl_next                 = out_ctrl;
      out_wr_next                   = 0;
      key_next                      = key;
      val_next                      = val;
      pkt_count_next                = pkt_count;
      case(state)
        WAIT_DATA: begin
            pkt_count_next = 0;
            if(!accum_value_fifo_empty) begin 
                accum_value_fifo_rdreq_next = 1;
                state_next = READ_WAIT_FIFO;
                select_next = TCHECK;
            end
            else if(!dram_fifo_empty) begin
                dram_fifo_read_next = 1;
                state_next = READ_WAIT_FIFO;
                select_next = FLUSH;
            end
            else if((!tx_ext_update_empty) & start_update) begin 
                tx_ext_update_rdreq_next = 1;
                state_next = READ_WAIT_FIFO;
                select_next = PUT;
            end
        end
        READ_WAIT_FIFO: begin
            if(out_rdy) begin
                state_next = WAIT_CYCLE;
            end
        end
        WAIT_CYCLE: begin
            case(select)
                PUT:        key_next = tx_ext_update_q[63:32];
                FLUSH:      key_next = dram_fifo_readdata[63:32];
                TCHECK:     key_next = 0;
                default:    key_next = 0;
            endcase
            case(select)
                PUT:        val_next = tx_ext_update_q[31:0];
                FLUSH:      val_next = dram_fifo_readdata[31:0];
                TCHECK:     val_next = accum_value_fifo_dataout[31:0];
                default:    val_next = 0;
            endcase
            state_next = NETFPGA_HDR;
        end
        NETFPGA_HDR: begin
            if(out_rdy) begin
                out_wr_next     = 1;
                out_data_next   = netfpga_header; 
                out_ctrl_next   = 8'hFF;
                state_next      = WORD_0;
            end
        end
        WORD_0: begin
            if(out_rdy) begin
                out_wr_next     = 1;
                out_data_next   = {dst_mac,src_mac[47:32]};
                out_ctrl_next   = 8'h00;
                state_next      = WORD_1;
            end
        end
        WORD_1: begin
            if(out_rdy) begin
                out_wr_next     = 1;
                out_data_next   = {src_mac[31:0],ether_type_16,ip_version_4,ip_hdr_length_4,ip_tos_8};
                out_ctrl_next   = 8'h00;
                state_next      = WORD_2;
            end
        end
        WORD_2: begin
            if(out_rdy) begin
                out_wr_next     = 1;
                out_data_next   = {ip_total_length_16,ip_id_16,ip_flags_3,ip_flag_offset_13,ip_ttl_8,ip_prot_8};
                out_ctrl_next   = 8'h00;
                state_next      = WORD_3;
            end
        end
        WORD_3: begin
            if(out_rdy) begin
                out_wr_next     = 1;
                out_data_next   = {checksum,src_ip,dst_ip[31:16]};
                out_ctrl_next   = 8'h00;
                state_next      = WORD_4;
            end
        end
        WORD_4: begin
            if(out_rdy) begin
                out_wr_next     = 1;
                out_data_next   = {dst_ip[15:0],udp_src_16,udp_dst_16,udp_length_16};
                out_ctrl_next   = 8'h00;
                state_next      = WORD_5;
            end
        end
        WORD_5: begin
            if(out_rdy) begin
                out_wr_next     = 1;
                out_data_next   = {command_word};
                out_ctrl_next   = 8'h00;
                state_next      = WORD_6;
            end
        end
        WORD_6: begin
            if(out_rdy) begin
                out_wr_next     = 1;
                out_data_next   = {64'h0};
                out_ctrl_next   = 8'h00;
                state_next      = WORD_7;
            end
        end
        WORD_7: begin
            if(out_rdy) begin
                out_wr_next         = 1;
                out_data_next       = {key,val};
                start_timeout_next  = 1;
                out_ctrl_next       = 8'h80;
                state_next          = INTERPKT_GAP;
            end
        end
        INTERPKT_GAP: begin
            if(timeout_expired) begin
                state_next = WAIT_DATA;
            end
        end
      endcase
   end
   always @(posedge clk) begin
      if(reset) begin
         state                   <= WAIT_DATA;
         out_data                <= 0;
         out_ctrl                <= 1;
         out_wr                  <= 0;
         start_timeout           <= 0;
         tx_ext_update_rdreq     <= 0;
         dram_fifo_read          <= 0;
         accum_value_fifo_rdreq  <= 0;
         select                  <= 0;
         out_data                <= 0;
         out_ctrl                <= 0;
         key                     <= 0;
         val                     <= 0;
         pkt_count               <= 0;
      end
      else begin
         state                   <= state_next;
         out_data                <= out_data_next;
         out_ctrl                <= out_ctrl_next;
         out_wr                  <= out_wr_next;
         start_timeout           <= start_timeout_next;
         tx_ext_update_rdreq     <= tx_ext_update_rdreq_next;
         dram_fifo_read          <= dram_fifo_read_next;
         accum_value_fifo_rdreq  <= accum_value_fifo_rdreq_next;
         select                  <= select_next;
         out_data                <= out_data_next;
         out_ctrl                <= out_ctrl_next;
         key                     <= key_next;
         val                     <= val_next;
         pkt_count               <= pkt_count_next;
      end 
   end 
   always@(posedge clk)
   begin
      if(reset) begin
         packet_sent <= 0;
      end
      else begin
         packet_sent <= ((state==WAIT_CYCLE)&&(select==FLUSH))?(packet_sent+1):(packet_sent);
      end
   end
endmodule