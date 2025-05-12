module array_packed_2d(); 
reg [1:4][7:0] vec; 
reg [4:1][7:0] vec2; 
integer i; 
initial begin 
for(i = 1; i <= 4; i = i + 1) 
    vec[i] = i * 2; 
$display("%h", vec); 
for(i = 1; i <= 4; i = i + 1) 
    $display(vec[i]); 
$display(vec[1]); 
$display(vec[2]); 
$display(vec[3]); 
$display(vec[4]); 
vec[1] = 2; 
vec[2] = 4; 
vec[3] = 6; 
vec[4] = 8; 
$display("%h", vec); 
for(i = 1; i <= 4; i = i + 1) 
    $display(vec[i]); 
$display(vec[1]); 
$display(vec[2]); 
$display(vec[3]); 
$display(vec[4]); 
for(i = 1; i <= 4; i = i + 1) 
    vec2[i] = i * 2; 
$display("%h", vec2); 
for(i = 1; i <= 4; i = i + 1) 
    $display(vec2[i]); 
$display(vec2[1]); 
$display(vec2[2]); 
$display(vec2[3]); 
$display(vec2[4]); 
vec2[1] = 2; 
vec2[2] = 4; 
vec2[3] = 6; 
vec2[4] = 8; 
$display("%h", vec2); 
for(i = 1; i <= 4; i = i + 1) 
    $display(vec2[i]); 
$display(vec2[1]); 
$display(vec2[2]); 
$display(vec2[3]); 
$display(vec2[4]); 
end 
endmodule 