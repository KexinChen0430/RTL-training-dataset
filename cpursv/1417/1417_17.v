
module jt12_timer  #(parameter  CW = 8, FW = 4, FREE_EN = 0)
  (input  rst,
   input  clk,
   input  cen,
   input  zero,
   input  [(-1)+CW:0] start_value,
   input  load,
   input  clr_flag,
   output reg flag,
   output reg overflow);

  reg  load_l;
  reg  [(-1)+CW:0] cnt,next;
  reg  [(-1)+FW:0] free_cnt,free_next;
  reg  free_ov;

  
  always @(posedge clk or posedge rst)
      if (rst) flag <= 1'b0;
      else 
        begin
          if (clr_flag) flag <= 1'b0;
          else if (load && overflow && (cen && zero)) flag <= 1'b1;
            
        end
  
  always @(*)
      begin
        {free_ov,free_next} = 1'b1+{1'b0,free_cnt};
        {overflow,next} = {1'b0,cnt}+(FREE_EN ? free_ov : 1'b1);
      end
  
  always @(posedge clk)
      begin
        load_l <= load;
        if (!load_l && load) 
          begin
            cnt <= start_value;
          end
        else if (cen && (zero && load)) cnt <= overflow ? start_value : next;
          
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            free_cnt <= 0;
          end
        else if (cen && zero) 
          begin
            free_cnt <= free_cnt+1'd1;
          end
          
      end
endmodule

