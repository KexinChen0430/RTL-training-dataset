module PIO16(
    input               rsi_MRST_reset,
    input               csi_MCLK_clk,
    input       [31:0]  avs_gpio_writedata,
    output      [31:0]  avs_gpio_readdata,
    input       [2:0]   avs_gpio_address,
    input       [3:0]   avs_gpio_byteenable,
    input               avs_gpio_write,
    input               avs_gpio_read,
    output              avs_gpio_waitrequest,
    inout               coe_P0,
    inout               coe_P1,
    inout               coe_P2,
    inout               coe_P3,
    inout               coe_P4,
    inout               coe_P5,
    inout               coe_P6,
    inout               coe_P7,
    inout               coe_P8,
    inout               coe_P9,
    inout               coe_P10,
    inout               coe_P11,
    inout               coe_P12,
    inout               coe_P13,
    inout               coe_P14,
    inout               coe_P15,
    inout               coe_P16
);
reg     [15:0]  io_data;
reg     [15:0]  io_out_en;
reg     [15:0]  read_data;
assign  avs_gpio_readdata = {16'b0, read_data};
assign  avs_gpio_waitrequest = 1'b0;
assign  coe_P0 = (io_out_en[0]) ? io_data[0] : 1'bz;
always@(posedge csi_MCLK_clk or posedge rsi_MRST_reset)
begin
    if(rsi_MRST_reset) begin
        read_data <= 0;
    end
    else begin
        case(avs_gpio_address)
            2: read_data <= {16'b0, coe_P15, coe_P14, coe_P13, coe_P12, coe_P11, coe_P10, coe_P9, coe_P8, coe_P7, coe_P6, coe_P5, coe_P4, coe_P3, coe_P2, coe_P1, coe_P0};
            4: read_data <= {16'b0, io_out_en};
            default: read_data <= 0;
        endcase
    end
end
always@(posedge csi_MCLK_clk or posedge rsi_MRST_reset)
begin
    if(rsi_MRST_reset) begin
        io_data <= 0;
        io_out_en <= 0;
    end
    else begin
        if(avs_gpio_write) begin
            case(avs_gpio_address)
                2: begin
                    io_data <= avs_gpio_writedata[15:0];
                end
                4: begin
                    io_out_en <= avs_gpio_writedata[15:0];
                end
                default: begin end
            endcase
        end
    end
end
endmodule