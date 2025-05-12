module overlay_fallback #( 
    parameter DATA_WIDTH = 12, 
    parameter CHARACTER_SIZE = 32 
)(
    input wire i_clk, 
    input wire [DATA_WIDTH-1:0] i_data, 
    input wire i_vactive, 
    input wire i_hactive, 
    output wire [DATA_WIDTH-1:0] o_data, 
    output wire o_vactive, 
    output wire o_hactive 
);
    localparam ROM_LENGTH = 15; 
    localparam MESSAGE_LENGTH = 23; 
    initial if((CHARACTER_SIZE % 4) != 0) begin
        $(display "Error: CHARACTER_SIZE must be a multiple of 4!")
        $finish; 
    end
    initial if(CHARACTER_SIZE < 32) begin
        $(display "Error: CHARACTER_SIZE must be at least 32!")
        $finish; 
    end
    reg [63:0] character_rom [0:ROM_LENGTH-1]; 
    reg [clog2(ROM_LENGTH)-1:0] message_rom[0:MESSAGE_LENGTH-1]; 
    integer x; 
    initial
    begin
        for(x = 0; x < ROM_LENGTH; x = x + 1) 
            character_rom[x] = rom_lookup(x); 
        for(x = 0; x < MESSAGE_LENGTH; x = x + 1) 
            message_rom[x] = message_index(x); 
    end
    function [63:0] rom_lookup;
        input integer value; 
        begin
            case(value) 
            endcase
        end
    endfunction
    function integer message_index;
        input integer value; 
        begin
            case(value) 
            endcase
        end
    endfunction
    function integer clog2;
        input integer value; 
        begin
            if (value < 2) 
                value = 2; 
            value = value - 1; 
            for (clog2 = 0; value > 0; clog2 = clog2 + 1) 
                value = value >> 1; 
        end
    endfunction
endmodule