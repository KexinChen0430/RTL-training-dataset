module dqrx (
    dqs, dq, q0, q1, q2, q3
);
    `include "ddr2_parameters.vh"
    input  dqs;
    input  [DQ_BITS/DQS_BITS-1:0] dq;
    output [DQ_BITS/DQS_BITS-1:0] q0;
    output [DQ_BITS/DQS_BITS-1:0] q1;
    output [DQ_BITS/DQS_BITS-1:0] q2;
    output [DQ_BITS/DQS_BITS-1:0] q3;
    reg [DQ_BITS/DQS_BITS-1:0] q [3:0];
    assign q0  = q[0];
    assign q1  = q[1];
    assign q2  = q[2];
    assign q3  = q[3];
    reg [1:0] ptr;
    reg dqs_q;
    always @(dqs) begin
        if (dqs ^ dqs_q) begin
            #(TDQSQ + 1);
            q[ptr] <= dq;
            ptr <= (ptr + 1)%4;
        end
        dqs_q <= dqs;
    end
endmodule