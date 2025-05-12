module rs232out
   (
    input wire         clock, 
    output wire        serial_out, 
    input  wire  [7:0] transmit_data, 
    input  wire        we, 
    output wire        busy); 