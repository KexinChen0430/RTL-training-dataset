module x;
   always @(posedge piclk) begin
      if (k_i_reset) begin
         idat_ICErrData_i3 <= 1'h0;
      end
      else begin
         idat_ICErrData_i3 <= idat_way0_i2[1*OPCWID-1:0*OPCWID];
      end
   end
   localparam MPND  = 5;
   always @(posedge usclk)
     if (~sso_srst_n) begin
        rd_dat_s4 <= 1'h0;
        sel_s3    <= 1'h0;
     end
     else begin
        sel_s3    <= adr_s2[MIDX];
        rd_dat_s4 <= (sel_s3 == 1'h0 ? rd_dat0_s3[MPND:0]
                      :                rd_dat1_s3[MPND:0]);
     end
   integer i;
   always @(posedge usclk)
     if (~sso_srst_n) begin
        for (int j=0; j<10; j++) blob[j] <= 0;
        zsv <= 1'h0;
        zz  <= 1'h0;
     end
     else begin
        for (i=0; i<10; i++) blob[i] <= blob[i+1];
        for (i=0; i<10; i++) zz <= 1;
        for (int isv=0; isv<10; isv++) zsv <= 1;
     end
   always @(in) begin
      for (i=0; i<10; i++) zz <= in;
      for (int isv=0; isv<10; isv++) zsv <= in;
   end
endmodule