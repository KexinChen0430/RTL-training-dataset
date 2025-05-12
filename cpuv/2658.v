module top (
    hwclk,
    led1,
    keypad_r1,
    keypad_c1,
    );
    input hwclk;
    output led1;
    output keypad_r1=0;
    input keypad_c1;
    reg ledval = 1'b0;
    wire keypad_c1_din;
    SB_IO #(
        .PIN_TYPE(6'b0000_01),
        .PULLUP(1'b1)
    ) keypad_c1_config (
        .PACKAGE_PIN(keypad_c1),
        .D_IN_0(keypad_c1_din)
    );
    assign led1=ledval;
    always @ (negedge keypad_c1_din) begin
        ledval = ~ledval;
    end
endmodule