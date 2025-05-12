module oh_counter #(parameter DW = 32) 
(
    input clk, 
    input in, 
    input en, 
    input dir, 
    input autowrap, 
    input load, 
    input [DW-1:0] load_data, 
    output [DW-1:0] count, 
    output wraparound 
);
    reg [DW-1:0] count;
    wire [DW-1:0] count_in;
    assign count_in[DW-1:0] = dir ? count[DW-1:0] - in :
                                       count[DW-1:0] + in;
    always @(posedge clk)
        if (load) 
            count[DW-1:0] <= load_data[DW-1:0];
        else if (en & ~(wraparound & ~autowrap)) 
            count[DW-1:0] <= count_in[DW-1:0]; 
    assign wraparound = (dir & en & ~(|count[DW-1:0])) | 
                        (~dir & en & (&count[DW-1:0])); 
endmodule