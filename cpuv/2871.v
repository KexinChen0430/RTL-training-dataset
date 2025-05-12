module serializer #
(
parameter WIDTH = 4,    
parameter MODE  = "SDR" 
)
(
input  wire CLK,
input  wire RST,
input  wire[WIDTH-1:0] I,
output wire RD,
output wire CE,
output wire O_CLK,
output wire O_DAT
);