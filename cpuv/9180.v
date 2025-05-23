module _4bit_binary_counter(
    input CP,
    input M,
    input [3:0] D,
    input LD_n,
    input CLR_n,
    output reg [3:0] Q,
    output reg  Qcc_n
    );
    always @(negedge CLR_n or negedge LD_n or posedge CP) begin
        if (Qcc_n == 0) begin
            Qcc_n = 1;
        end
        if (!CLR_n) begin
            {Qcc_n, Q} <= 5'b10000;
        end
        else if (!LD_n) begin
            {Qcc_n, Q} <= {1'b1, D};
        end
        else if(CP) begin
            if (M) begin
                {Qcc_n, Q} <= {Qcc_n,Q} + 1;
            end
            else begin
                {Qcc_n, Q} <= {Qcc_n,Q} - 1;
            end
        end
    end
endmodule