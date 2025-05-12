module delay5 (clock, d5_delay_in, d5_delay_out); 
    input clock; 
    input [`BITS-1:0] d5_delay_in; 
    output [`BITS-1:0] d5_delay_out; 
    reg [`BITS-1:0] d5_reg1; 
    assign d5_delay_out = d5_reg1; 
    always @(posedge clock) 
    begin
        d5_reg1 <= d5_delay_in; 
    end
endmodule 