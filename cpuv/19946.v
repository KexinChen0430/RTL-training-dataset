module fifo226 (clk, wen, din, dout); 
input clk; 
input wen; 
input[`WIDTH_4B - 1:0] din; 
output[`WIDTH_4B - 1:0] dout; 
reg[`WIDTH_4B - 1:0] dout; 
reg[`WIDTH_4B-1:0] buff1;
reg[`WIDTH_4B-1:0] buff2;
always @(posedge clk)
begin
    if (wen == 1'b1) 
    begin
        buff1 <= din; 
        buff2 <= buff1; 
        dout <= buff2; 
    end
end
endmodule 