module
always @ (posedge dclock) begin
  if (rst) begin
    r_wfifo_activate  <=  0; 
    r_wfifo_strobe    <=  0; 
    r_wfifo_data      <=  0; 
    r_wfifo_count     <=  0; 
  end
  else begin
    r_wfifo_strobe    <=  0; 
    if (r_wfifo_strobe) begin
        r_wfifo_data  <=  r_wfifo_data + 1;
    end
    if ((w_wfifo_ready > 0) && (r_wfifo_activate == 0)) begin
      r_wfifo_count   <=  0;
      if (w_wfifo_ready[0]) begin
        r_wfifo_activate[0] <=  1;
      end
      else begin
        r_wfifo_activate[1] <=  1;
      end
    end
    else if (r_wfifo_activate > 0) begin
      if (r_wfifo_count < w_wfifo_size) begin
        r_wfifo_count <=  r_wfifo_count + 1;
        r_wfifo_strobe<=  1;
      end
      else begin
        r_wfifo_activate  <=  0;
      end
    end
  end
end
endmodule