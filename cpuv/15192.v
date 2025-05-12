module ram0(
    input rdclk,             
    input [9:0] rdaddr,      
    output reg [15:0] do);   
    (* ram_style = "block" *) reg [15:0] ram[0:1023]; 
    genvar i; 
    generate
        for (i=0; i<1024; i=i+1) 
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