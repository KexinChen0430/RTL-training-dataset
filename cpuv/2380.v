module comparator #
(
parameter WIDTH = 8,
parameter ERROR_COUNT = 8,
parameter ERROR_HOLD = 2500000
)
(
input  wire CLK,
input  wire RST,
input  wire             TX_STB,
input  wire [WIDTH-1:0] TX_DAT,
input  wire             RX_STB,
input  wire [WIDTH-1:0] RX_DAT,
output wire             RX_BITSLIP,
output wire             O_ERROR
);