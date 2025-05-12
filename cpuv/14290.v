module sdram_phase (
                     pre_wcmd,   
                     wd,         
                     ph_err,     
                     sclk0,      
                     sclk270,    
                     enrd180,    
                     udqsr90,    
                     ldqsr90,    
                     udqsr270,   
                     ldqsr270,   
                     dcm_rst,    
                     dcm_clk,    
                     dcm_en,     
                     dcm_incdec, 
                     phase90sel  
                     );
   input         pre_wcmd; 
   input  [ 3:0] wd; 
   output [ 1:0] ph_err; 
   input         sclk0, sclk270; 
   input         enrd180; 
   input         udqsr90, udqsr270, ldqsr90, ldqsr270; 
   output        dcm_rst, dcm_clk, dcm_en, dcm_incdec; 
   output [ 1:0] phase90sel; 
   wire          wcmd = pre_wcmd; 
   reg    [ 1:0] phase90sel; 
   reg dcm_rst; 
   reg [1:0] dcm_drst; 
   reg       dcm_en; 
   reg       dcm_incdec; 
   reg           enrd0, enrd180_d,enrd90,enrd270; 
   reg           waslate90, waslate270, wasearly90, wasearly270; 
  always @ (negedge sclk0) begin 
    dcm_drst[1:0] <= {dcm_drst[0], (wcmd && (wd[1:0] == 2'b11))}; 
    dcm_rst    <= (wcmd && (wd[1:0] == 2'b11)) || dcm_drst[0]  || dcm_drst[1] ; 
    dcm_en     <= wcmd && (wd[1]!=wd[0]); 
    dcm_incdec <= wcmd && wd[0]; 
    if      (wcmd && wd[2] && wd[3]) phase90sel[1:0] <= 2'h0; 
    else if (wcmd && wd[2]) phase90sel[1:0] <= phase90sel[1:0] +1;
    else if (wcmd && wd[3]) phase90sel[1:0] <= phase90sel[1:0] -1;
  end
   assign  dcm_clk=!sclk0; 
   always @ (posedge sclk0)   enrd0     <= enrd180; 
   always @ (negedge sclk0)   enrd180_d <= enrd180;
   always @ (negedge sclk270)  enrd90    <= enrd180_d;
   always @ (posedge sclk270) enrd270   <= enrd0;
   always @ (negedge sclk270 or posedge wcmd) 
     if (wcmd) begin 
       waslate90  <= 1'b0;
       wasearly90 <= 1'b0;
     end else begin 
       waslate90  <= waslate90  || (enrd90 && ( udqsr90 ||  ldqsr90));
       wasearly90 <= wasearly90 || (enrd90 && (!udqsr90 || !ldqsr90));
     end
   always @ (posedge sclk270 or posedge wcmd) 
     if (wcmd) begin 
       waslate270  <= 1'b0;
       wasearly270 <= 1'b0;
     end else begin 
       waslate270  <= waslate270  || (enrd270 && (!udqsr270 || !ldqsr270));
       wasearly270 <= wasearly270 || (enrd270 && ( udqsr270 ||  ldqsr270));
     end
     assign ph_err[1:0]= {(wasearly90 || wasearly270), (waslate90 || waslate270)}; 
endmodule