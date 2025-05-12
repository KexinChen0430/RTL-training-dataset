module Msg_In(input clk, 
              input rst, 
              input start, 
              input [31:0]msg_in, 
              output reg done, 
              output reg [511:0]msg_out 
    );
reg [9:0]count; 
always@(posedge clk or negedge rst) begin
         if(rst == 0) begin 
            done <= 0; 
            msg_out <= 0; 
            count <= 0; 
         end else begin
          if(start) 
              if(count < 17) 
                count <= count + 1; 
         end
end
always@(count) begin
    if(count == 1)
        msg_out[511:480] = msg_in;
    else if(count == 2)
        msg_out[479:448] = msg_in;
    else if (count == 17)
        done = 1; 
    else begin end 
end
endmodule