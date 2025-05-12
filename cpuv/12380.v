module
assign preambleclk = txbitclk  && (state == STATE_PRE) && (!done); 
assign dataclk = txbitclk && (state == STATE_DATA ||(state == STATE_PRE && bit_transition && !done)); 
assign crcoutclk = txbitclk && (state == STATE_CRC); 
always @ (negedge txbitclk or posedge reset) begin 
  if (reset) begin 
    state      <= 0; 
    done       <= 0; 
    bit_transition <= 0; 
    tx_stop    <= 0; 
  end else if (done) begin 
  end else if (state == STATE_PRE) begin 
    if (bit_transition) begin 
      state      <= STATE_DATA; 
      bit_transition <= 0; 
    end else if (preambledone) begin 
      bit_transition <= 1; 
    end
  end else if (state == STATE_DATA) begin 
    if (bit_transition) begin 
      if (datadone && docrc) state <= STATE_CRC; 
      else if (datadone)     state <= STATE_END; 
      bit_transition <= 0; 
    end else if (datadone) begin 
      bit_transition <= 1; 
    end
  end else if (state == STATE_CRC) begin 
    if (bit_transition) begin 
      state      <= STATE_END; 
      bit_transition <= 0; 
    end else if (crcdone) begin 
      bit_transition <= 1; 
    end
  end else if (state == STATE_END) begin 
    if (txdone) begin 
      state <= STATE_PRE; 
      done  <= 1; 
    end else begin
      tx_stop <= 1; 
    end
  end 
end
endmodule