module SERIAL_TO_PARALLEL # (parameter SIZE = `PALABRA) 
(
    input wire serial_in, 
    input wire enable_stp, 
    input wire SD_CLK, 
    input wire RESET_L, 
    output reg reception_complete, 
    output reg [SIZE - 1:0] parallel_out 
);
reg [8:0] contador; 
always @ (posedge SD_CLK or negedge RESET_L) 
begin
    if (~RESET_L) 
        begin
            parallel_out <= 0; 
            reception_complete <= 0; 
            contador <= 0; 
        end
    else 
        begin
            if (enable_stp) 
                begin
                    if (contador == SIZE) 
                        begin
                            reception_complete <= 1; 
                            contador <= 0; 
                        end
                    else 
                        begin
                            reception_complete <= 0; 
                            parallel_out <= {serial_in, parallel_out[SIZE-1:1]}; 
                            contador <= contador + 1; 
                        end
                end
            else 
                begin
                    parallel_out <= 0; 
                end
        end
end 
endmodule 