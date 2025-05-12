module's undeclared outputs) 
   reg [HAMAX-1:0]      haddr_d; 
   reg [2:0]            hburst_d; 
   reg [3:0]            hmaster_d; 
   reg                  hmastlock_d; 
   reg                  hready_ba_d; 
   reg                  hsel_d; 
   reg [2:0]            hsize_d; 
   reg [1:0]            htrans_d; 
   reg [HDMAX-1:0]      hwdata_d; 
   reg                  hwrite_d; 
   always @ (haddr or hburst or hmaster or hmastlock
             or hready_ba or hsel or hsize or htrans or hwdata
             or hwrite)
     begin
        hsel_d <= #delta hsel; 
        hready_ba_d <= #delta hready_ba; 
        hwrite_d <= #delta hwrite; 
        hmastlock_d <= #delta hmastlock; 
        haddr_d <= #delta haddr; 
        htrans_d <= #delta htrans; 
        hsize_d <= #delta hsize; 
        hburst_d <= #delta hburst; 
        hwdata_d <= #delta hwdata; 
        hmaster_d <= #delta hmaster; 
     end
endmodule