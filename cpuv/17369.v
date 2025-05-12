module error_analyzer( 
    input [7:0] error, 
    input [7:0] err_level, 
    output reg [1:0] noise 
);
always @(error or err_level) 
begin
    if (error < err_level) 
        noise = error[1:0]; 
    else
        noise = 2'b00; 
end
endmodule 