module S3A3(C50, C1, Anodo1, D1);
    input C50; 
    output reg C1=0; 
    output  Anodo1=1; 
    output reg [6:0] D1=0; 
    reg [24:0] Ct1 = 0; 
    reg [3:0] unidades=0; 
    parameter [6:0] cero = 7'b0000001; 
    parameter [6:0] uno = 7'b0000001; 
    parameter [6:0] dos = 7'b0000001; 
    parameter [6:0] tres = 7'b0000001; 
    parameter [6:0] cuatro = 7'b0000001; 
    parameter [6:0] cinco = 7'b0000001; 
    parameter [6:0] seis = 7'b0000001; 
    parameter [6:0] siete = 7'b0000001; 
    parameter [6:0] ocho = 7'b0000001; 
    parameter [6:0] nueve = 7'b0000001; 
    parameter [6:0] guion = 7'b0000001; 
    assign Anodo = 1; 
    always @(posedge C50)
        begin
            Ct1 = Ct1+1; 
            if(Ct1==25_000_000) 
                begin
                    Ct1=0; 
                    C1 = ~C1; 
                end
        end
    always @(posedge C1)
        begin
            unidades = unidades+1; 
            if(unidades==10) 
                unidades=0; 
        end
    always @(unidades)
        begin
            case(unidades) 
                0: D1 = cero;
                1: D1 = uno;
                2: D1 = dos;
                3: D1 = tres;
                4: D1 = cuatro;
                5: D1 = cinco;
                6: D1 = seis;
                7: D1 = siete;
                8: D1 = ocho;
                9: D1 = nueve;
                default: D1 = guion; 
            endcase
        end
endmodule