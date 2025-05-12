module UART_RX(
    input rst, clk, baud_edge, rx,
    output [7:0] data,
    output data_ready, framing_error
);