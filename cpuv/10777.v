module dqrx (
    ptr_rst_n, dqs, dq, q0, q1, q2, q3
);
`ifdef den128Mb
    `include "128Mb_mobile_ddr_parameters.vh"
`elsif den256Mb
    `include "256Mb_mobile_ddr_parameters.vh"
`elsif den512Mb
    `include "512Mb_mobile_ddr_parameters.vh"
`elsif den1024Mb
    `include "1024Mb_mobile_ddr_parameters.vh"
`elsif den2048Mb
    `include "2048Mb_mobile_ddr_parameters.vh"
`else
    ERROR: You must specify component density with +define+den____Mb.
`endif
    input  ptr_rst_n;
    input  dqs;
    input  [DQ_BITS/DQS_BITS-1:0] dq;
    output [DQ_BITS/DQS_BITS-1:0] q0;
    output [DQ_BITS/DQS_BITS-1:0] q1;
    output [DQ_BITS/DQS_BITS-1:0] q2;
    output [DQ_BITS/DQS_BITS-1:0] q3;
    reg [1:0] ptr;
    reg [DQ_BITS/DQS_BITS-1:0] q [3:0];
    reg ptr_rst_dly_n;
    always @(posedge ptr_rst_n) ptr_rst_dly_n <= #(tAC2_min + tDQSQ) ptr_rst_n;
    always @(negedge ptr_rst_n) ptr_rst_dly_n <= #(tAC2_max + tDQSQ + 0.002) ptr_rst_n;
    reg dqs_dly;
    always @(dqs) dqs_dly <= #(tDQSQ + 0.001) dqs;
    always @(negedge ptr_rst_dly_n or posedge dqs_dly or negedge dqs_dly) begin
        if (!ptr_rst_dly_n) begin
            ptr <= 0;
        end else if (dqs_dly || ptr) begin
            q[ptr] <= dq;
            ptr <= ptr + 1;
        end
    end
    assign q0  = q[0];
    assign q1  = q[1];
    assign q2  = q[2];
    assign q3  = q[3];
endmodule