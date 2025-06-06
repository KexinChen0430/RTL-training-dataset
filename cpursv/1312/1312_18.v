
module ym_timer  #(parameter  cnt_width = 8, mult_width = 1)
  (input  CLK,
   input  TICK_144,
   input  nRESET,
   input  [cnt_width+(0-1):0] LOAD_VALUE,
   input  LOAD,
   input  CLR_FLAG,
   input  SET_RUN,
   input  CLR_RUN,
   output reg OVF_FLAG,
   output reg OVF);

  reg  RUN;
  reg  [mult_width-1:0] MULT;
  reg  [cnt_width+(0-1):0] CNT;
  reg  [(cnt_width+(0-1))+mult_width:0] NEXT,INIT;

  
  always @(posedge CLK)
      begin
        if (!nRESET || CLR_RUN) RUN <= 0;
        else if (SET_RUN || LOAD) RUN <= 1;
          
        if (!nRESET || CLR_FLAG) OVF_FLAG <= 0;
        else if (OVF) OVF_FLAG <= 1;
          
        if (TICK_144) 
          begin
            if (LOAD) 
              begin
                MULT <= {mult_width{1'b0}};
                CNT <= LOAD_VALUE;
              end
            else if (RUN) {CNT,MULT} <= OVF ? INIT : NEXT;
              
          end
          
      end
  
  always @(*)
      begin
        {OVF,NEXT} <= 1'b1+{1'b0,CNT,MULT};
        INIT <= {LOAD_VALUE,{mult_width{1'b0}}};
      end
endmodule

