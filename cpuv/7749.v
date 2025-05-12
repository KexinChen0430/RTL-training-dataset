module enum_ports(input wire t_var var_i, output t_var var_o, output reg is_var_rst); 
initial begin 
    var_o = var_presence; 
end
always @(var_i) 
begin
    if(var_i == var_rst) 
        is_var_rst = 1'b1; 
    else
        is_var_rst = 1'b0; 
end
endmodule 