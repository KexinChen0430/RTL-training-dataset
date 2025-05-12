module you need to facilitate transfering data from
always @ (posedge dclock) begin
  if (rst) begin
    r_rfifo_activate  <=  0; 
    r_rfifo_strobe    <=  0; 
    r_rfifo_count     <=  0; 
  end
  else begin
    r_rfifo_strobe    <=  0;
    if (w_rfifo_ready && !r_rfifo_activate) begin
      r_rfifo_count   <=  0; 
      r_rfifo_activate<=  1; 
    end
    else if (r_rfifo_activate) begin
      if (r_rfifo_count < w_rfifo_size) begin
        r_rfifo_count     <=  r_rfifo_count + 1; 
        r_rfifo_strobe    <=  1; 
      end
      else begin
        r_rfifo_activate  <=  0; 
      end
    end
  end
end
endmodule