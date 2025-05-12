module Problem4( 
    input A, 
    input B, 
    input C, 
    input D, 
    output reg F, 
    output reg G, 
    output reg H 
    );
    reg [3:0] select; 
    always @ (A or B or C or D) 
        begin
        select = {A, B, C, D}; 
            case(select) 
                4'b0000: begin 
                            F = 1; 
                            G = 0; 
                            H = 1; 
                         end
                endcase
        end
endmodule 