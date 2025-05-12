
module ps2_host_to_kb(input  wire clk,
                      inout  wire ps2clk_ext,
                      inout  wire ps2data_ext,
                      input  wire [7:0] data,
                      input  wire dataload,
                      output wire ps2busy,
                      output wire ps2error);

  reg   busy = 1'b0;
  reg   error = 1'b0;

  assign ps2busy = busy;
  assign ps2error = error;
  reg  [1:0] ps2clk_synchr;

  reg  [1:0] ps2dat_synchr;

  wire  ps2clk = ps2clk_synchr[1];

  wire  ps2data_in = ps2dat_synchr[1];

  
  always @(posedge clk)
      begin
        ps2clk_synchr[0] <= ps2clk_ext;
        ps2clk_synchr[1] <= ps2clk_synchr[0];
        ps2dat_synchr[0] <= ps2data_ext;
        ps2dat_synchr[1] <= ps2dat_synchr[0];
      end
  reg  [15:0]  edgedetect = 16'h0000;

  
  always @(posedge clk)
      begin
        edgedetect <= {edgedetect[14:0],ps2clk};
      end
  wire 
       ps2clknedge = (edgedetect == 16'hF000) ? 1'b1 : 1'b0;

  wire 
       ps2clkpedge = (edgedetect == 16'h0FFF) ? 1'b1 : 1'b0;

  reg  [15:0]  timeoutcnt = 16'h0000;

  reg  [2:0]  state = 3'b110;

  reg  [7:0]  shiftreg = 8'h00;

  reg  [2:0]  cntbits = 3'd0;

  reg  [7:0]  rdata = 8'h00;

  wire  paritycalculated = ~^rdata;

  
  always @(posedge clk)
      begin
        if (dataload) 
          begin
            rdata <= data;
            busy <= 1'b1;
            error <= 1'b0;
            timeoutcnt <= 16'h0000;
            state <= 3'b000;
          end
          
        if (!ps2clknedge) 
          begin
            timeoutcnt <= 1+timeoutcnt;
            if ((timeoutcnt == 16'hFFFF) && (state != 3'b110)) 
              begin
                error <= 1'b1;
                state <= 3'b110;
              end
              
          end
          
        case (state)

          3'b000: begin
                if (timeoutcnt >= 16'd40000) 
                  begin
                    state <= 3'b001;
                    shiftreg <= rdata;
                    cntbits <= 3'd0;
                    timeoutcnt <= 16'h0000;
                  end
                  
              end

          3'b001: begin
                if (ps2clknedge) 
                  begin
                    state <= 3'b010;
                    timeoutcnt <= 16'h0000;
                  end
                  
              end

          3'b010: begin
                if (ps2clknedge) 
                  begin
                    timeoutcnt <= 16'h0000;
                    shiftreg <= {1'b0,shiftreg[7:1]};
                    cntbits <= cntbits+1;
                    if (cntbits == 3'd7) state <= 3'b011;
                      
                  end
                  
              end

          3'b011: begin
                if (ps2clknedge) 
                  begin
                    state <= 3'b101;
                    timeoutcnt <= 16'h0000;
                  end
                  
              end

          3'b101: begin
                if (ps2clknedge) 
                  begin
                    state <= 3'b100;
                    timeoutcnt <= 16'h0000;
                  end
                  
              end

          3'b100: begin
                if (ps2clknedge) 
                  begin
                    state <= 3'b110;
                    timeoutcnt <= 16'h0000;
                  end
                  
              end

          3'b110: begin
                busy <= 1'b0;
                timeoutcnt <= 16'h0000;
              end

          default: begin
                timeoutcnt <= 1+timeoutcnt;
                if ((timeoutcnt == 16'hFFFF) && (state != 3'b110)) 
                  begin
                    error <= 1'b1;
                    state <= 3'b110;
                  end
                  
              end

        endcase

      end
  assign ps2data_ext = ((state == 3'b000) || (state == 3'b001)) ? 1'b0 : 
                       ((shiftreg[0] == 1'b0) && (state == 3'b010)) ? 1'b0 : 
                       ((paritycalculated == 1'b0) && (state == 3'b011)) ? 1'b0 : 1'bZ;
  assign ps2clk_ext = (state == 3'b000) ? 1'b0 : 1'bZ;
endmodule

