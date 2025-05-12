module Problem1( 
    input [3:0] Binary_Number, 
    output reg [6:0] Cathodes, 
    output reg Anode 
    );
    always @ ( Binary_Number) 
    begin
        Anode = 0; 
        case(Binary_Number) 
            4'b0000: begin 
                 Cathodes[0] = 0; 
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 0;
                 Cathodes[4] = 0;
                 Cathodes[5] = 0;
                 Cathodes[6] = 1;
                 end
            4'b0001: begin 
                 Cathodes[0] = 1; 
                 Cathodes[1] = 0;
                 Cathodes[2] = 0;
                 Cathodes[3] = 1;
                 Cathodes[4] = 1;
                 Cathodes[5] = 1;
                 Cathodes[6] = 1;
                 end
            endcase 
    end 
endmodule 