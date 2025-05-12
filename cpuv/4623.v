module quad_encoder(
    input clk, 
    input reset, 
    input a, 
    input b, 
    output  [31:0] count 
    );
reg [2:0] a_prev;
reg [2:0] b_prev;
reg dir = 1'b0;
reg [31:0] count = 32'b0;
reg count_enable = 1'b0;
always @(posedge clk)
 begin
   a_prev <= {a_prev[1:0],a};
   b_prev <= {b_prev[1:0],b};
 end
always @(posedge clk or posedge reset)
begin
     if (reset == 1'b1)
      begin
        dir <= 1'b0;
        count <= 32'b0;
        count_enable <= 0'b0;
      end
     else
        count_enable <= a_prev[2] ^ b_prev[2] ^ a_prev[1] ^ b_prev[1];
        dir <=  b_prev[2] ^ a_prev[1] ;
        if(count_enable)
         begin
          if(dir)
            begin
              count <= count + 32'b1; 
            end
          else
            begin
              count <= count - 32'b1; 
            end
         end
    end
endmodule