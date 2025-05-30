module uut_1_bytep
(
    output wire [31:0] data_o,
    output wire        sof_o,
    input  wire [7:0]  data_i,
    input  wire        sof_i,
    input  wire        pclk_i
);
    reg  [7:0]   data_z1;
    reg          sof_z1;
    reg  [7:0]   data_z2;
    reg          sof_z2;
    reg  [7:0]   data_z3;
    reg          sof_z3;
    reg  [7:0]   data_z4;
    reg          sof_z4;
    always @ (posedge pclk_i) begin
        data_z1[7:0] <= data_i[7:0];
        sof_z1       <= sof_i;
        data_z2[7:0] <= data_z1[7:0];
        sof_z2       <= sof_z1;
        data_z3[7:0] <= data_z2[7:0];
        sof_z3       <= sof_z2;
        data_z4[7:0] <= data_z3[7:0];
        sof_z4       <= sof_z3;
    end
    always @ (*)
    begin
        data_o[31:0] = {data_z4[7:0], data_z3[7:0], data_z2[7:0], data_z1[7:0]};
        sof_o        = sof_z4;
    end
endmodule