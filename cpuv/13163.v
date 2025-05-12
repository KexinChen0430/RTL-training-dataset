module adv7513_reconfig ( 
    input clock, 
    input [7:0] data_in, 
    input [7:0] clock_config_data, 
    input [1:0] colorspace_in, 
    output ADV7513Config adv7513Config, 
    output [7:0] clock_data_out, 
    output [1:0] colorspace_out, 
    output adv7513_reconf 
);
    `include "../config/adv_config.v" 
    reg [7:0] data_in_reg = 0; 
    reg [1:0] colorspace_in_reg = 0; 
    reg [7:0] clock_config_data_reg = 0; 
    reg [7:0] clock_data_out_reg = 8'b_0110_0000; 
    reg [1:0] colorspace_reg = 0; 
    reg adv7513_reconf_reg; 
    ADV7513Config adv7513Config_reg; 
    initial begin
        adv7513Config_reg <= ADV7513_CONFIG_1080P; 
    end
    assign adv7513Config = adv7513Config_reg; 
    assign clock_data_out = clock_data_out_reg; 
    assign adv7513_reconf = adv7513_reconf_reg; 
    assign colorspace_out = colorspace_reg; 
    always @(posedge clock) begin 
        data_in_reg <= data_in; 
        colorspace_in_reg <= colorspace_in; 
        clock_config_data_reg <= clock_config_data; 
        if (data_in_reg != data_in 
         || colorspace_in_reg != colorspace_in
         || clock_config_data_reg != clock_config_data
        ) begin
            adv7513_reconf_reg <= 1'b1; 
            if (data_in_reg != data_in) begin 
                case (data_in[6:0]) 
                endcase
            end
            if (clock_config_data_reg != clock_config_data) begin 
                case (clock_config_data) 
                endcase
            end
            colorspace_reg <= colorspace_in; 
        end else begin
            adv7513_reconf_reg <= 0; 
        end
    end
endmodule