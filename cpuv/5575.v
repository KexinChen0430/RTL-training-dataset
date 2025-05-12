module is then enitirely resposible for the bandwidth
         if (byte_count == 1 & tready) begin
            next_gen_state = OVERHEAD;
         end
      end
      OVERHEAD : begin
         if (overhead_count == 1 & tready) begin
            next_gen_state = IDLE;
         end
      end
      default : begin
         next_gen_state = IDLE;
      end
   endcase
end
always @(posedge axi_tclk)
begin
   if (axi_treset) begin
      gen_state <= IDLE;
   end
   else begin
   gen_state <= next_gen_state;
   end
end
always @(posedge axi_tclk)
begin
   if (axi_treset)
      tvalid_int <= 0;
   else if (gen_state != IDLE & gen_state != OVERHEAD)
      tvalid_int <= 1;
   else if (tready)
      tvalid_int <= 0;
end
always @(posedge axi_tclk)
begin
   if (gen_state == HEADER & (tready | !tvalid_int))
      tdata <= lut_data;
   else if (gen_state == SIZE & tready) begin
      if (header_count[3])
         tdata <= {5'h0, pkt_size[10:8]};
      else
         tdata <= pkt_size[7:0];
   end
   else if (tready)
      tdata <= byte_count[7:0];
end
always @(posedge axi_tclk)
begin
   if (axi_treset)
      tlast <= 0;
   else if (byte_count == 1 & tready)
      tlast <= 1;
   else if (tready)
      tlast <= 0;
end
assign tvalid = tvalid_int;
endmodule