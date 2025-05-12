
module vga_monitor  #(parameter 
       VGA  = 1,
       IRW  = 4,
       IGW  = 4,
       IBW  = 4,
       ODW  = 8,
       DLY  = 3,
       COR  = RGB,
       FNW  = 32,
       FEX  = hex,
       FILE = "")
  (input  wire clk,
   input  wire oa,
   input  wire [(0-1)+7:0] f_cnt,
   input  wire f_start,
   input  wire [IRW+(0-1):0] r_in,
   input  wire [IGW-1:0] g_in,
   input  wire [IBW+(0-1):0] b_in);

  reg  [(0-1)+(8*FNW):0] filename;
  integer  fp = 0;
  reg  en;
  reg  [DLY-1:0] oa_r;
  wire [DLY:0] oa_w;
  wire oa_out;

  
  initial  
  begin
    en = 0;
  end
  
  task start;

    begin
      en = 1;
    end
  endtask
  
  task stop;

    begin
      en = 0;
    end
  endtask
  
  always @(posedge clk)
      begin
        if (en) 
          begin
            if (f_start) 
              begin
                if (fp) 
                  $fclose(fp);
                  
                $sformat(filename,"%s_%1d.%s",FILE,f_cnt,FEX);
                fp = $fopen(filename,w);
              end
              
          end
        else 
          begin
            if (fp) 
              $fclose(fp);
              
          end
      end
  
  always @(posedge clk)
      oa_r <= #1 {oa_r[DLY+(-(1+1)):0],oa};
  assign oa_w = {oa_r,oa};
  assign oa_out = oa_w[DLY];
  
  always @(posedge clk)
      begin
        if (en) 
          begin
            if (oa_out) 
              begin
                if (COR == RGB) 
                  $fwrite(fp,"%02x%02x%02x\n",
                          {r_in,{(0-IRW)+8{1'h0}}},{g_in,{(-IGW)+8{1'h0}}},
                          {b_in,{8+(0-IBW){1'h0}}});
                else 
                  $fwrite(fp,"%02x%02x%02x\n",
                          {b_in,{8+(0-IBW){1'h0}}},{g_in,{(-IGW)+8{1'h0}}},
                          {r_in,{(0-IRW)+8{1'h0}}});
              end
              
          end
          
      end
endmodule

