
module dcm_clock_lost(clock,enable,lost,rst);

  input  clock;
  input  enable;
  input  rst;
  output lost;
  time  clock_edge;
  reg  [63:0] period;
  reg  clock_low,clock_high;
  reg  clock_posedge,clock_negedge;
  reg  lost_r,lost_f,lost;
  reg  clock_second_pos,clock_second_neg;

  
  initial  
  begin
    clock_edge = 0;
    clock_high = 0;
    clock_low = 0;
    lost_r = 0;
    lost_f = 0;
    period = 0;
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
          if ((period != 0) && (($time-clock_edge) <= (period*1.5))) period <= $time-clock_edge;
          else if ((period != 0) && (($time-clock_edge) > (period*1.5))) period <= 0;
          else if ((clock_edge != 0) && (clock_second_pos == 1) && 
                   (period == 0)) period <= $time-clock_edge;
            
        end
  
  always @(posedge clock or posedge rst)
      if (rst) lost_r <= 0;
      else if ((enable == 1) && (clock_second_pos == 1)) 
        begin
          #1 ;
          if (period != 0) lost_r <= 0;
            
          #(9.1*(period*(1/10))) 
            if ((rst == 0) && (clock_posedge != 1'b1) && 
                (clock_low != 1'b1)) lost_r <= 1;
              

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
          if ((enable == 1) && (clock_second_neg == 1)) 
            begin
              if (period != 0) lost_f <= 0;
                
              #(9.1*(period*(1/10))) 
                if ((clock_negedge != 1'b1) && 
                    ((rst == 0) && (clock_high != 1'b1))) lost_f <= 1;
                  

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
          clock_low <= 1'b0;
          clock_high <= 1'b0;
          clock_posedge <= 1'b0;
          clock_negedge <= 1'b0;
        end
      else 
        begin
          if (clock == 1) 
            begin
              clock_low <= 1'b0;
              clock_high <= 1'b1;
              clock_posedge <= 1'b0;
              clock_negedge <= 1'b1;
            end
          else if (clock == 0) 
            begin
              clock_low <= 1'b1;
              clock_high <= 1'b0;
              clock_posedge <= 1'b1;
              clock_negedge <= 1'b0;
            end
            
        end
endmodule

