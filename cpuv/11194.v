module during setup.
  assign bitinclk  = ((m == 0) ? evalclk : evalclkby2) | bitinclkoverride;
  always @ (posedge clkin or posedge reset) begin
    if (reset) begin
      bitout <= 0;
    end else begin
      bitout <= nextbitout & bitoutenable;
    end
  end
  reg [5:0] subcarriers;
  always @ (posedge clkin or posedge reset) begin
    if (reset) begin
      subcarriers      <= 0;
      bitinclkoverride <= 0;
      txdone           <= 0;
      txdoneout        <= 0;
      setupdone        <= 0;
    end else if (subcarriers < 8) begin
      subcarriers      <= subcarriers + 6'd1;
      bitinclkoverride <= 1;
    end else if (subcarriers < 17) begin
      subcarriers      <= subcarriers + 6'd1;
      bitinclkoverride <= 0;
    end else if (subcarriers == 17) begin 
      if (rtcal_expired) begin
        subcarriers <= subcarriers + 6'd1;
        setupdone   <= 1;
      end
    end else if (txstop & !txdone & (m==0)) begin  
      txdone <= 1;
      subcarriers <= subcarriers + 6'd1;
    end else if (txstop & !txdone & (m==1) & (subcarriers >= 19)) begin
      txdone <= 1;
      subcarriers <= subcarriers + 6'd1;
    end else if (txstop & !txdone & (m==2) & (subcarriers >= 21)) begin
      txdone <= 1;
      subcarriers <= subcarriers + 6'd1;
    end else if (txstop & !txdone & (m==3) & (subcarriers >= 25)) begin
      txdone <= 1;
      subcarriers <= subcarriers + 6'd1;
    end else if (txstop & (subcarriers==6'b111111)) begin 
      txdone    <= 1;
      txdoneout <= 1;
    end else if (txdone) begin 
      txdoneout <= 1;
    end else if (txstop) begin 
      subcarriers <= subcarriers + 6'd1;
    end
  end
  always @ (posedge evalclk or posedge reset) begin
    if (reset) begin
      previousbit      <= 0;
      currentbit       <= 0;
      phaseinvert      <= 0;
      clkphase         <= 0;
      currentviolation <= 0;
      txstop           <= 0;
      bitoutenable     <= 0;
    end else begin
      if (clkphase == 0 | m == 0) begin
        clkphase         <= 1;
        phaseinvert      <= nextphaseinvert;
        currentbit       <= bitin;
        previousbit      <= currentbit;
        currentviolation <= violationin;
        txstop           <= txstopin;
        if(m==0) bitoutenable <= 1;
      end else begin
        clkphase    <= 0;
        phaseinvert <= millerphaseinvert;
        bitoutenable <= 1;
      end
    end
  end
endmodule