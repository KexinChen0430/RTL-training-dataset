module hdr */
   always @(*) begin
      rd_preprocess_info            = 0;
      state_next                    = state;
      in_fifo_rd_en                 = 0;
      pkt_dropped_wrong_dst_mac     = 0;
      rx_ext_update_data_next = rx_ext_update_data;
      rx_ext_update_wrreq_next = 1'b0;
      command_next = command;
      start_update_next = start_update;
      flush_ddr_next = 1'b0;
      start_load_next = start_load;
      check_terminate_next = 1'b0;
      flush_data_next = 1'b0;
      dram_fifo_writedata_next = dram_fifo_writedata;
      dram_fifo_write_next = 1'b0;
      compute_system_reset_next = 1'b0;
      rx_ext_fifo_sel_next = rx_ext_fifo_sel;
      packet_rcv_next = packet_rcv;
      case(state)
        WAIT_PREPROCESS_RDY: begin
           if(preprocess_vld) begin
		if(is_for_us && is_ip_pkt) begin 
			state_next         = MOVE_MODULE_HDRS;
			packet_rcv_next = packet_rcv+1;
	         end 
	         else begin
	                pkt_dropped_wrong_dst_mac   = 1;
        	        rd_preprocess_info          = 1;
                	in_fifo_rd_en               = 1;
	                state_next                  = DROP_PKT;
        	end
	   end
        end 
        MOVE_MODULE_HDRS: begin
           if(in_fifo_vld) begin
              in_fifo_rd_en    = 1;
              if(in_fifo_ctrl==0) begin
                 state_next    = SEND_SRC_MAC_LO;
              end
           end
        end 
        SEND_SRC_MAC_LO: begin
           if(in_fifo_vld) begin
              in_fifo_rd_en   = 1;
              state_next      = SEND_IP_TTL;
           end
        end
        SEND_IP_TTL: begin
           if(in_fifo_vld) begin
              in_fifo_rd_en   = 1;
              state_next      = SEND_IP_CHECKSUM;
           end
        end
        SEND_IP_CHECKSUM: begin
           if(in_fifo_vld) begin
              in_fifo_rd_en        = 1;
              rd_preprocess_info   = 1;
              state_next           = MOVE_UDP;
           end
        end
	MOVE_UDP: begin
	   if(in_fifo_vld) begin
              in_fifo_rd_en        = 1;
              state_next           = INTERPRET_COMMAND;
	   end
	end
	INTERPRET_COMMAND: begin
	   if(in_fifo_vld) begin
              in_fifo_rd_en        = 1;
	      if(in_fifo_data[47:40]==`START_LOAD) begin
	 	 start_load_next = 1'b1;
		 state_next = DROP_PKT;
	      end
	      else if(in_fifo_data[47:40]==`LOAD_DATA) begin
		 state_next = LOAD_KEY_VALUE;
	      end
	      else if(in_fifo_data[47:40]==`END_LOAD) begin
	         start_load_next = 1'b0;
		 compute_system_reset_next = 1'b1; 
		 state_next = DROP_PKT;
	      end
	      else if(in_fifo_data[47:40]==`FPGA_TO_WORKER_PUT_REQUEST) begin 
		  state_next = ACCUM_KEY_VALUE;
	      end
	      else if(in_fifo_data[47:40]==`WORKER_TO_FPGA_PUT_REQUEST) begin 
		  state_next = ACCUM_KEY_VALUE;
	      end
	      else if(in_fifo_data[47:40]==`START_UPDATE) begin
		  start_update_next = 1'b1;
		  state_next = DROP_PKT;
	      end
	      else if(in_fifo_data[47:40]==`END_UPDATE) begin
		  start_update_next = 1'b0;
		  state_next = DROP_PKT;
	      end
	      else if(in_fifo_data[47:40]==`START_CHECK_TERMINATE) begin
		  check_terminate_next = 1'b1;
		  state_next = DROP_PKT;
	      end
	      else if(in_fifo_data[47:40]==`START_FLUSH_DATA) begin
		  flush_ddr_next = 1'b1;
		  state_next = DROP_PKT;
	      end
	      else begin
              	  state_next   = DROP_PKT;
	      end
	   end 
	end
	LOAD_KEY_VALUE: begin 
           if(in_fifo_vld && (!dram_fifo_full)) begin
		dram_fifo_writedata_next = in_fifo_data[63:0];
		dram_fifo_write_next = 1'b1;
		state_next = (eop)?WAIT_PREPROCESS_RDY:LOAD_KEY_VALUE;
              	in_fifo_rd_en   = (eop)?0:1;
	    end
        end
	ACCUM_KEY_VALUE: begin
	   if(in_fifo_vld) begin
		if((|in_fifo_data)&&(!rx_ext_update_full[rx_ext_fifo_sel])) begin
	      		rx_ext_update_data_next  = in_fifo_data[63:0];
			rx_ext_update_wrreq_next[rx_ext_fifo_sel] = 1'b1;
			rx_ext_fifo_sel_next = ((rx_ext_fifo_sel+1)==8)?ext_start:(rx_ext_fifo_sel+1);
		end
        	in_fifo_rd_en = 1'b1;
		if(eop) begin
			state_next = WAIT_PREPROCESS_RDY;
		end
		else begin
			state_next = ACCUM_KEY_VALUE;
		end
	   end
	end
        DROP_PKT: begin
           if(in_fifo_vld) begin
              in_fifo_rd_en = 1;
              if(eop) begin
                 state_next = WAIT_PREPROCESS_RDY;
              end
           end
        end
      endcase 
   end 
   always @(posedge clk or posedge reset) begin
      if(reset) begin
         state             		<= WAIT_PREPROCESS_RDY;
         ctrl_prev_is_0    		<= 0;
         rx_ext_update_data 		<= 0;
         rx_ext_update_wrreq 		<= 0;
	 start_update 			<= 0;
	 start_load 			<= 0;
	 check_terminate 		<= 0;
	 flush_ddr 			<= 0;
         dram_fifo_writedata 		<= 0;
         dram_fifo_write 		<= 0;
	 compute_system_reset	 	<= 0;
         rx_ext_fifo_sel 		<= 0;
	 packet_rcv			<= 0;
      end
      else begin
         state             		<= state_next;
         ctrl_prev_is_0    		<= in_fifo_rd_en ? (in_fifo_ctrl==0) : ctrl_prev_is_0;
         rx_ext_update_data 		<= rx_ext_update_data_next;
         rx_ext_update_wrreq 		<= rx_ext_update_wrreq_next;
	 start_update 			<= start_update_next;
	 start_load 			<= start_load_next;
	 check_terminate 		<= check_terminate_next;
	 flush_ddr 			<= flush_ddr_next;
         dram_fifo_writedata 		<= dram_fifo_writedata_next;
         dram_fifo_write 		<= dram_fifo_write_next;
	 compute_system_reset	 	<= compute_system_reset_next;
         rx_ext_fifo_sel 		<= (rx_ext_fifo_sel_next<ext_start)?ext_start:rx_ext_fifo_sel_next;
	 packet_rcv			<= packet_rcv_next;
      end 
   end 
endmodule