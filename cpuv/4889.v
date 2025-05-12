module eim_burstcnt(
    input wire bclk, 
    input wire [15:0] bus_ad, 
    input wire [2:0] bus_a, 
    input wire adv, 
    input wire rw, 
    input wire cs, 
    output reg [15:0] measured_burst 
);