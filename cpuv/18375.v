module my_fir_h1 (clk, new_data_rdy, output_data_ready, din, dout);
parameter WIDTH = 5'b10000; 
input clk; 
input[WIDTH - 1:0] din; 
output[28 - 1:0] dout; 
reg[28 - 1:0] dout; 
input new_data_rdy; 
output output_data_ready; 
reg output_data_ready; 
reg[WIDTH - 1:0] n_delay_reg1;
reg[WIDTH - 1:0] n_delay_reg2;
reg[WIDTH - 1:0] n_delay_reg3;
reg[WIDTH - 1:0] n_delay_reg4;
reg[WIDTH - 1:0] n_delay_reg5;
reg[WIDTH - 1:0] n_delay_reg6;
always @(posedge clk) 
begin
    if (new_data_rdy == 1'b1) 
    begin
        n_delay_reg1 <= din;
        n_delay_reg2 <= n_delay_reg1;
        n_delay_reg3 <= n_delay_reg2;
        n_delay_reg4 <= n_delay_reg3;
        n_delay_reg5 <= n_delay_reg4;
        n_delay_reg6 <= n_delay_reg5;
        output_data_ready <= 1'b1; 
        dout <= (din * `COEF0_1) +
                (n_delay_reg1 * `COEF1_1) +
                (n_delay_reg2 * `COEF2_1) +
                (n_delay_reg4 * `COEF4_1) +
                (n_delay_reg5 * `COEF5_1) +
                (n_delay_reg6 * `COEF6_1);
    end
    else 
    begin
        output_data_ready <= 1'b0; 
    end
end
endmodule 