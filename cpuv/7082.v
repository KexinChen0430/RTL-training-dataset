module hamdec(
        data_in,
        edc_in,
        data_out,
        error);
    `include "parameters_global.v"
    input [`uart_data_width-1:0] data_in;                   
    input [`uart_rx_hamming_decoder_edc_width-1:0] edc_in;  
    output reg [`uart_data_width-1:0] data_out; 
    output reg error;                           
    wire [3:0]    syndrome;
    assign #`DEL syndrome[0] = edc_in[3] ^ data_in[7] ^ data_in[6] ^ data_in[4] ^ data_in[3] ^ data_in[1];
    assign #`DEL syndrome[1] = edc_in[2] ^ data_in[7] ^ data_in[5] ^ data_in[4] ^ data_in[2] ^ data_in[1];
    assign #`DEL syndrome[2] = edc_in[1] ^ data_in[6] ^ data_in[5] ^ data_in[4] ^ data_in[0];
    assign #`DEL syndrome[3] = edc_in[0] ^ data_in[3] ^ data_in[2] ^ data_in[1] ^ data_in[0];
    always @(syndrome or data_in) begin
        data_out = data_in;
        case (syndrome)     
            4'h0: begin
                error = 0;
            end
            4'h1: begin
                error = 1;
            end
            4'h2: begin
                error = 1;
            end
            4'h4: begin
                error = 1;
            end
            4'h8: begin
                error = 1;
            end
            4'h3: begin
                data_out[7] = ~data_in[7];
                error = 1;
            end
            4'h5: begin
                data_out[6] = ~data_in[6];
                error = 1;
            end
            4'h6: begin
                data_out[5] = ~data_in[5];
                error = 1;
            end
            4'h7: begin
                data_out[4] = ~data_in[4];
                error = 1;
            end
            4'h9: begin
                data_out[3] = ~data_in[3];
                error = 1;
            end
            4'ha: begin
                data_out[2] = ~data_in[2];
                error = 1;
            end
            4'hb: begin
                data_out[1] = ~data_in[1];
                error = 1;
            end
            4'hc: begin
                data_out[0] = ~data_in[0];
                error = 1;
            end
        endcase
    end
endmodule