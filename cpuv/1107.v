module ram0(
    input rdclk,        
    input [9:0] rdaddr, 
    output reg [35:0] do 
);
    (* ram_style = "block" *) reg [35:0] ram[0:1023]; 
    genvar i;
    generate
        for (i=0; i<1024; i=i+1) 
        begin
            initial begin 
                ram[i] <= i | (i << 16);
            end
        end
    endgenerate
    always @ (posedge rdclk) begin
        do <= ram[rdaddr];
    end
endmodule