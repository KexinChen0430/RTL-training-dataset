
module sky130_fd_io__top_refgen(VINREF,VOUTREF,REFLEAK_BIAS,VCCD,VCCHIB,VDDA,VDDIO,VDDIO_Q,
                                VSSD,VSSIO,VSSIO_Q,HLD_H_N,IBUF_SEL,OD_H,VOHREF,VREF_SEL,
                                VREG_EN,VTRIP_SEL);

  wire error_vsel;
  output VINREF;
  output VOUTREF;
  inout  REFLEAK_BIAS;
  inout  VCCD;
  inout  VCCHIB;
  inout  VDDA;
  inout  VDDIO;
  inout  VDDIO_Q;
  inout  VSSD;
  inout  VSSIO;
  inout  VSSIO_Q;
  input  HLD_H_N;
  input  IBUF_SEL;
  input  OD_H;
  input  VOHREF;
  input  VREF_SEL;
  input  VREG_EN;
  input  VTRIP_SEL;
  reg  [2:0] dm_final;
  reg  
      slow_final     ,
      vtrip_sel_final,
      inp_dis_final  ,
      hld_ovr_final  ;
  reg  [2:0] dm;
  reg  slow,inp_dis,hld_ovr;
  reg  [1:0] vsel;
  wire 
       pwr_good_active_mode = (VDDIO === 1) && (VCCD === 1) && 
((VDDIO_Q === 1) && (VSSD === 0));
  wire 
       pwr_good_hold_mode = (VSSD === 0) && ((VDDIO === 1) && (VDDIO_Q === 1));

  
  always @(*)
      begin
        if (
(
((^HLD_H_N === 1'bx) || 
((OD_H === 0) && !pwr_good_hold_mode) || !pwr_good_hold_mode) && 
((OD_H === 0) || 
(!pwr_good_hold_mode && (^OD_H === 1'bx)) || !pwr_good_hold_mode)) || 
            (
(((^OD_H === 1'bx) || !pwr_good_hold_mode) && 
(OD_H === 0)) || (^OD_H === 1'bx))) 
          begin
            dm_final = 3'bxxx;
            slow_final = 1'bx;
            vtrip_sel_final = 1'bx;
            inp_dis_final = 1'bx;
            hld_ovr_final = 1'bx;
          end
        else if (OD_H === 1) 
          begin
            dm_final = 3'b000;
            slow_final = 1'b0;
            vtrip_sel_final = 1'b0;
            inp_dis_final = 1'b0;
            hld_ovr_final = 1'b0;
          end
        else if (HLD_H_N === 1) 
          begin
            dm_final = ((^dm[2:0] === 1'bx) || !pwr_good_active_mode) ? 3'bxxx : dm;
            slow_final = (!pwr_good_active_mode || (^slow === 1'bx)) ? 1'bx : slow;
            vtrip_sel_final = ((^VTRIP_SEL === 1'bx) || !pwr_good_active_mode) ? 1'bx : VTRIP_SEL;
            inp_dis_final = ((^inp_dis === 1'bx) || !pwr_good_active_mode) ? 1'bx : inp_dis;
            hld_ovr_final = (!pwr_good_active_mode || (^hld_ovr === 1'bx)) ? 1'bx : hld_ovr;
          end
          
      end
  reg  dis_err_msgs;

  
  initial  
  begin
    dis_err_msgs = 1'b1;
    #1 ;
    dis_err_msgs = 1'b0;
  end
  assign error_vsel = (vsel[1] === 1) && (vsel[0] === 1);
  
  always @(*)
      begin
        if (!dis_err_msgs) 
          begin
            if (error_vsel == 1) 
              $display(" ===ERROR=== sky130_fd_io__top_refgen : %m : Incorrect inputs on vsel[1:0] = 11",
                       $stime);
              
          end
          
      end
endmodule

