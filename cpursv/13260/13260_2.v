
module vga(input  clk,
           output vs_o,
           output vs_valid,
           output hs_o,
           output hs_valid);

  parameter  H_PIX = 640;
  parameter  H_SYNC_PULSE = 96;
  parameter  H_FP = 16;
  parameter  H_BP = 48;
  parameter  H_SYNC = H_PIX+(H_FP+(H_BP+H_SYNC_PULSE));
  parameter  V_PIX = 480;
  parameter  V_SYNC_PULSE = 2;
  parameter  V_FP = 10;
  parameter  V_BP = 33;
  parameter  V_SYNC = (V_SYNC_PULSE+V_BP)+(V_FP+V_PIX);
  localparam  H_SYNC_WIDTH = $clog2(H_SYNC);
  localparam  V_SYNC_WIDTH = $clog2(V_SYNC);
  reg  [H_SYNC_WIDTH-1:0]  ctr_h = 0;
  reg  [V_SYNC_WIDTH-1:0]  ctr_v = 0;

  
  always @(posedge clk)
      begin
        if (ctr_h == (H_SYNC+(-1))) 
          begin
            ctr_h <= 0;
          end
        else 
          begin
            ctr_h <= ctr_h+1;
          end
      end
  
  always @(posedge clk)
      begin
        if (ctr_h == (H_SYNC+(-1))) 
          begin
            if (ctr_v == (V_SYNC+(-1))) 
              begin
                ctr_v <= 0;
              end
            else 
              begin
                ctr_v <= 1+ctr_v;
              end
          end
          
      end
  assign hs_o = ctr_h > (H_SYNC_PULSE-1);
  assign vs_o = ctr_v > (V_SYNC_PULSE+(-1));
  assign hs_valid = (ctr_h < (H_BP+((H_SYNC_PULSE-1)+H_PIX))) & (ctr_h > (H_SYNC_PULSE+((-1)+H_BP)));
  assign vs_valid = (ctr_v < (((V_BP+V_PIX)+V_SYNC_PULSE)+(-1))) & (ctr_v > (V_BP+(V_SYNC_PULSE+(-1))));
endmodule

