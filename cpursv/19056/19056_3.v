
module fool;

  
  always @(posedge clk)
      begin
        if (!M_select) xferCount <= 8'd0;
        else 
          case (condition[1:0])

            2'b00: xferCount <= xferCount;

            2'b01: xferCount <= xferCount-8'd1;

            2'b10: xferCount <= 8'd1+xferCount;

            2'b11: xferCount <= xferCount;

          endcase

      end
  
  always @(posedge clk)
      begin
        if (!M_select) xferCount <= 8'd0;
        else 
          case ({M_seqAddr,OPB_xferAck})

            2'b00: xferCount <= xferCount;

            2'b01: xferCount <= xferCount-8'd1;

            2'b10: xferCount <= 8'd1+xferCount;

            2'b11: xferCount <= xferCount;

          endcase

      end
endmodule

