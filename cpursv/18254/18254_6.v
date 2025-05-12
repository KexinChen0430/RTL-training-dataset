
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
   input  wire [7-1:0] f_cnt,
   input  wire f_start,
   input  wire [(-1)+IRW:0] r_in,
   input  wire [(-1)+IGW:0] g_in,
   input  wire [IBW-1:0] b_in);

  reg  [(FNW*8)-1:0] filename;
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
      oa_r <= #1 {oa_r[(0-1<<<1)+DLY:0],oa};
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
                          {r_in,{(-IRW)+8{1'h0}}},{g_in,{8+(0-IGW){1'h0}}},
                          {b_in,{8-IBW{1'h0}}});
                else 
                  $fwrite(fp,"%02x%02x%02x\n",{b_in,{8-IBW{1'h0}}},
                          {g_in,{8+(0-IGW){1'h0}}},{r_in,{(-IRW)+8{1'h0}}});
              end
              
          end
          
      end
endmodule

