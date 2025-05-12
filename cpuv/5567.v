module EscrituraRegistroToMemoria#(parameter Width = 4)
(
    Read, InError, Address, ListoIn, InDato, Coeff00, Coeff01, Coeff02, Coeff03,
    Coeff04, Coeff05, Coeff06, Coeff07, Coeff08, Coeff09, Coeff10, Coeff11,
    Coeff12, Coeff13, Coeff14, Coeff15, Coeff16, Coeff17, Coeff18, Coeff19,
    Offset, DatoEntradaSistema, Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9, OutDato
);
    input Read, InError, ListoIn;
    input [8:0] Address;
    input signed [Width-1:0] InDato, Coeff00, Coeff01, Coeff02, Coeff03, Coeff04, Coeff05,
        Coeff06, Coeff07, Coeff08, Coeff09, Coeff10, Coeff11, Coeff12, Coeff13, Coeff14, Coeff15, Coeff16,
        Coeff17, Coeff18, Coeff19, Offset, DatoEntradaSistema, Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9;
    output reg signed [Width-1:0] OutDato;
    always @*begin
        if (Read) begin
            case (Address)
                9'h000: if (ListoIn) OutDato <= 1; 
                9'h004: OutDato <= InDato; 
                9'h008: if (InError) OutDato <= 1; 
                9'h00C: OutDato <= Coeff00; 
                9'h010: OutDato <= Coeff01; 
                9'h014: OutDato <= Coeff02; 
                9'h018: OutDato <= Coeff03; 
                9'h01C: OutDato <= Coeff04; 
                9'h020: OutDato <= Coeff05; 
                9'h024: OutDato <= Coeff06; 
                9'h028: OutDato <= Coeff07; 
                9'h02C: OutDato <= Coeff08; 
                9'h030: OutDato <= Coeff09; 
                9'h034: OutDato <= Coeff10; 
                9'h038: OutDato <= Coeff11; 
                9'h03C: OutDato <= Coeff12; 
                9'h040: OutDato <= Coeff13; 
                9'h044: OutDato <= Coeff14; 
                9'h048: OutDato <= Coeff15; 
                9'h04C: OutDato <= Coeff16; 
                9'h050: OutDato <= Coeff17; 
                9'h054: OutDato <= Coeff18; 
                9'h058: OutDato <= Coeff19; 
                9'h05C: OutDato <= Offset; 
                9'h060: OutDato <= DatoEntradaSistema; 
                9'h064: OutDato <= Y0; 
                9'h068: OutDato <= Y1; 
                9'h06C: OutDato <= Y2; 
                9'h070: OutDato <= Y3; 
                9'h074: OutDato <= Y4; 
                9'h078: OutDato <= Y5; 
                9'h07C: OutDato <= Y6; 
                9'h080: OutDato <= Y7; 
                9'h084: OutDato <= Y8; 
                9'h088: OutDato <= Y9; 
                default: OutDato <= 0;
            endcase
        end else begin
            OutDato <= 0;
        end
    end
endmodule