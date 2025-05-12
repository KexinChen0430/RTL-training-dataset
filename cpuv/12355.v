module reset
    input start, 
    output reg [DATA_WIDTH-1:0] dout, 
    output reg valid 
    );
reg [2:0] current_state_in, next_state_in; 
reg [DATA_WIDTH-1:0] dout_tmp; 
reg [CNT_WIDTH:0] cnt; 
parameter s0=3'b001; 
parameter s1=3'b010;
parameter s2=3'b100;
parameter s3=3'b000;
always@(negedge clk or posedge rst) 
begin
if(rst) 
 begin
 current_state_in<=s0; 
 end
else 
 begin
 current_state_in<=next_state_in; 
 end
end
always@(current_state_in or rst or start or cnt) 
begin
if(rst) 
 begin
 next_state_in=s0; 
 end
else 
 begin
  case(current_state_in) 
    s0: next_state_in=(start == 1'b1 && READ_DELAY == 0)?s2: 
                      (start == 1'b1 && READ_DELAY == 1)?s3: 
                      (start == 1'b1 && READ_DELAY == 2)?s1:s0; 
    s1: next_state_in=s3; 
    s3: next_state_in=s2; 
    s2: next_state_in=(cnt==DATA_WIDTH)?s0:s2; 
    default: next_state_in=s0; 
  endcase
 end
end
always@(negedge clk or posedge rst) 
begin
 if(rst) 
 begin
  cnt<=0; 
  dout_tmp<=0; 
 end
 else 
 begin
  case(next_state_in) 
   s0: 
     begin
     cnt<=0; 
     dout_tmp<=0; 
     end
   s1,s3: 
     begin
     cnt<=0; 
     dout_tmp<=0; 
     end
   s2: 
     begin
     cnt<=cnt+1'b1; 
     if(SHIFT_DIRECTION) 
      begin
      dout_tmp[DATA_WIDTH-1-cnt]<=data_in; 
      end
     else 
      begin
      dout_tmp[cnt]<=data_in; 
      end
     end
   default: 
     begin
     cnt<=0; 
     dout_tmp<=0; 
     end
   endcase
 end
end
always@(negedge clk or posedge rst) 
begin
 if(rst) 
  begin
   dout<=0; 
   valid<=0; 
  end
 else 
  begin
   if(cnt==DATA_WIDTH) 
    begin
     dout<=dout_tmp; 
     valid<=1; 
    end
   else 
    begin
     dout<=dout; 
     valid<=valid; 
    end
  end
end
endmodule