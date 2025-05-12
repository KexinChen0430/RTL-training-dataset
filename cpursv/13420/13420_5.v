
module dcm_sp_clock_lost(clock,enable,lost,rst);

  input  clock;
  input  enable;
  input  rst;
  output lost;
  time  clock_edge,clock_edge_neg;
  time  
      period            ,
      period_neg        ,
      period_tmp        ,
      period_neg_tmp    ,
      period_tmp_win    ,
      period_neg_tmp_win;
  time  period_chk_win;
  integer clock_low,clock_high;
  integer clock_posedge,clock_negedge;
  integer clock_second_pos,clock_second_neg;
  reg  lost_r,lost_f,lost;

  
  initial  
  begin
    clock_edge = 0;
    clock_edge_neg = 0;
    clock_high = 0;
    clock_low = 0;
    lost_r = 0;
    lost_f = 0;
    period = 0;
    period_neg = 0;
    period_tmp = 0;
    period_tmp_win = 0;
    period_neg_tmp = 0;
    period_neg_tmp_win = 0;
    period_chk_win = 0;
    clock_posedge = 0;
    clock_negedge = 0;
    clock_second_pos = 0;
    clock_second_neg = 0;
  end
  
  always @(posedge clock or posedge rst)
      if (rst == 1) period <= 0;
      else 
        begin
          clock_edge <= $time;
          period_tmp = $time-clock_edge;
          if ((period != 0) && (period_tmp <= period_tmp_win)) period <= period_tmp;
          else if ((period_tmp > period_tmp_win) && (period != 0)) period <= 0;
          else if ((clock_second_pos == 1) && 
                   ((period == 0) && (clock_edge != 0))) period <= period_tmp;
            
        end
  
  always @(period)
      begin
        period_tmp_win = period*1.5;
        period_chk_win = (period*(1/10))*9.1;
      end
  
  always @(negedge clock or posedge rst)
      if (rst) period_neg <= 0;
      else 
        begin
          clock_edge_neg <= $time;
          period_neg_tmp = $time+(0-clock_edge_neg);
          if ((period_neg_tmp <= period_neg_tmp_win) && 
              (period_neg != 0)) period_neg <= period_neg_tmp;
          else if ((period_neg != 0) && 
                   (period_neg_tmp > period_neg_tmp_win)) period_neg <= 0;
          else if ((period_neg == 0) && (clock_second_neg == 1) && 
                   (clock_edge_neg != 0)) period_neg <= period_neg_tmp;
            
        end
  
  always @(period_neg)
      period_neg_tmp_win = period_neg*1.5;
  
  always @(posedge clock or posedge rst)
      if (rst) lost_r <= 0;
      else if ((enable == 1) && (clock_second_pos == 1)) 
        begin
          #1 ;
          if (period != 0) lost_r <= 0;
            
          #(period_chk_win) 
            if ((clock_low != 1) && (rst == 0) && (clock_posedge != 1)) lost_r <= 1;
              

        end
        
  
  always @(posedge clock or negedge clock or posedge rst)
      if (rst) 
        begin
          clock_second_pos <= 0;
          clock_second_neg <= 0;
        end
      else if (clock) clock_second_pos <= 1;
      else if (~clock) clock_second_neg <= 1;
        
  
  always @(negedge clock or posedge rst)
      if (rst == 1) 
        begin
          lost_f <= 0;
        end
      else 
        begin
          if ((clock_second_neg == 1) && (enable == 1)) 
            begin
              if (period != 0) lost_f <= 0;
                
              #(period_chk_win) 
                if ((period <= period_neg) && (clock_negedge != 1) && 
                    (clock_high != 1) && (rst == 0)) lost_f <= 1;
                  

            end
            
        end
  
  always @(lost_r or lost_f or enable)
      begin
        if (enable == 1) lost = lost_r | lost_f;
        else lost = 0;
      end
  
  always @(posedge clock or negedge clock or posedge rst)
      if (rst == 1) 
        begin
          clock_low <= 0;
          clock_high <= 0;
          clock_posedge <= 0;
          clock_negedge <= 0;
        end
      else 
        begin
          if (clock == 1) 
            begin
              clock_low <= 0;
              clock_high <= 1;
              clock_posedge <= 0;
              clock_negedge <= 1;
            end
          else if (clock == 0) 
            begin
              clock_low <= 1;
              clock_high <= 0;
              clock_posedge <= 1;
              clock_negedge <= 0;
            end
            
        end
endmodule

