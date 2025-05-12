module Week8Lab(
    input Clk,
    output reg [6:0] Cathodes,
    output reg [3:0] Anode
    );
    reg[1:0 ] digit = 2'b00;
    reg [27:0] Count;
    reg Rate;
    initial begin
        Count = 0;
        Rate = 0;
        end
    always @ (posedge Clk)
        begin
             if (Count == 216666)
             begin
                Rate = ~Rate;
                Count = 0;
             end
             else
             begin
                Count = Count + 1;
                end
        end
    always @ (posedge Rate)
    begin
        case (digit)
        2'b00: begin
                    Anode[0] = 0;
                    Anode[1] = 1;
                    Anode[2] = 1;
                    Anode[3] = 1;
                    Cathodes[0] = 1;
                     Cathodes[1] = 0;
                     Cathodes[2] = 0;
                     Cathodes[3] = 1;
                     Cathodes[4] = 1;
                     Cathodes[5] = 0;
                     Cathodes[6] = 0;
                end
        2'b01: begin
                     Anode[0] = 1;
                           Anode[1] = 0;
                           Anode[2] = 1;
                           Anode[3] = 1;
                    Cathodes[0] = 0;
                     Cathodes[1] = 0;
                     Cathodes[2] = 0;
                     Cathodes[3] = 0;
                     Cathodes[4] = 1;
                     Cathodes[5] = 1;
                     Cathodes[6] = 0;
                end
        2'b10: begin
                    Anode[0] = 1;
                           Anode[1] = 1;
                           Anode[2] = 0;
                           Anode[3] = 1;
                    Cathodes[0] = 0;
                     Cathodes[1] = 0;
                     Cathodes[2] = 1;
                     Cathodes[3] = 0;
                     Cathodes[4] = 0;
                     Cathodes[5] = 1;
                     Cathodes[6] = 0;
                end
        2'b11: begin
                     Anode[0] = 1;
                           Anode[1] = 1;
                           Anode[2] = 1;
                           Anode[3] = 0;
                    Cathodes[0] = 1;
                     Cathodes[1] = 0;
                     Cathodes[2] = 0;
                     Cathodes[3] = 1;
                     Cathodes[4] = 1;
                     Cathodes[5] = 1;
                     Cathodes[6] = 1;
                end
        endcase
        digit = digit + 1;
    end
endmodule