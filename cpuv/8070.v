module 32
wire  [31:0] state_sbox     = `Sbox(state_addmod32); 
wire  [31:0] state_shift11  = {state_sbox[20:0],state_sbox[31:21]}; 
always @(posedge clk)
  if(rst)
    {b,a} <= {64{1'b0}};
  else if(load)
    {b,a} <= pdata;
  else  begin
    a <= b ^ state_shift11;
    b <= a;
  end
reg r_done;
always @(posedge clk)
  if(rst)
    r_done <= 1'b0;
  else
    r_done <= &i;
assign done  = r_done;  
assign cdata = {a,b};
endmodule