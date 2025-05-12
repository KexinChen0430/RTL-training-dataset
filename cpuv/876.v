module
  assign mrd_s = (mwaddr == mraddr) ? 1'b0 : win_ready;
  assign maddrdiff_s = {1'b1, mwaddr} - mraddr;
  assign mxfer_s = win_ready | ~win_valid;
  always @(posedge clk) begin
    maddrdiff <= maddrdiff_s[5:0];
    if (maddrdiff >= 32) begin
      adc_ready <= 1'b0;
    end else if (maddrdiff <= 20) begin
      adc_ready <= 1'b1;
    end
  end
  always @(posedge clk) begin
    if (mrd_s == 1'b1) begin
      mraddr <= mraddr + 1'b1;
    end
    mrd <= mrd_s;
    mrvalid <= mrd;
    mrdata <= mrdata_s;
  end
  always @(posedge clk) begin
    if (mrvalid == 1'b1) begin
      mwcnt <= mwcnt + 1'b1;
    end
    if ((mwcnt == 2'd0) && (mrvalid == 1'b1)) begin
      mvalid_0 <= 1'b1;
      mdata_0 <= mrdata;
    end else if ((mrcnt == 2'd0) && (mxfer_s == 1'b1)) begin
      mvalid_0 <= 1'b0;
      mdata_0 <= 17'd0;
    end
    if ((mrcnt != mwcnt) && (win_ready == 1'b1)) begin
      mrcnt <= mrcnt + 1'b1;
    end
    if ((win_valid == 1'b0) || (win_ready == 1'b1)) begin
      case (mrcnt)
        2'd3: begin
          win_valid <= mvalid_3;
          win_data <= mdata_3[15:0];
          win_last <= mdata_3[16] & mvalid_3;
        end
      endcase
    end
  end
endmodule