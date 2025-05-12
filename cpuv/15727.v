module ram0(
    input rdclk,             
    input [8:0] rdaddr,      
    output reg [31:0] do);   
    (* ram_style = "block" *) reg [31:0] ram[0:511]; 
    genvar i; 
    generate
        for (i=0; i<512; i=i+1) 
        begin
            initial begin 
                ram[i] <= i; 
            end
        end
    endgenerate
    always @ (posedge rdclk) begin 
        do <= ram[rdaddr]; 
    end
endmodule