module counter(clk, count_in, count_out, count_secs);
    input clk;
    input [3:0] count_in;
    output reg count_out;
    output wire [6:0]count_secs; 
    reg [22:0] count_to_0 = 0;           
    parameter tick_every = 20;       
    integer mc = 1000000/tick_every; 
    assign count_secs = count_to_0/mc;
    always @(count_in)
        begin
            case (count_in)
                `LICZNIK_RESET: 
                    begin
                        count_out <= `NIC_NIE_ODLICZAM;
                        count_to_0 <= 0;
                    end
                `ODLICZ_KUBEK:      
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_KUBEK*mc;
                    end
                `ODLICZ_KAWA_OP1:   
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_KAWA_OPCJA1*mc;
                    end
                `ODLICZ_KAWA_OP2:   
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_KAWA_OPCJA2*mc;
                    end
                `ODLICZ_KAWA_OP3:   
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_KAWA_OPCJA3*mc;
                    end
                `ODLICZ_WODA_OP1:   
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_WODA_OPCJA1*mc;
                    end
                `ODLICZ_WODA_OP2:   
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_WODA_OPCJA2*mc;
                    end
                `ODLICZ_WODA_OP3:   
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_WODA_OPCJA3*mc;
                    end
                `ODLICZ_MLEKO:      
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_MLEKO*mc;
                    end
                `ODLICZ_NAPELN:     
                    begin
                        count_out <= `ODLICZAM;
                        count_to_0 <= `CZAS_NAPELN*mc;
                    end
                `ODLICZ_CZYSC:      
                    begin
                        count_out = `ODLICZAM;
                        count_to_0 = `CZAS_CZYSC*mc;
                    end
            endcase;
        end
    always @(negedge clk) 
        begin
            if(count_out == `ODLICZAM && count_to_0 > 0)
                count_to_0 <= count_to_0 - 1;
            else
                count_out <= `SKONCZYLEM_ODLICZAC; 
        end
endmodule