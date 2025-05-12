module jt12_comb #(parameter
    w=16,   
    m=1     
)(
    input               rst,
    input               clk,
(* direct_enable *)    input cen,
    input  signed [w-1:0] snd_in,
    output reg signed [w-1:0] snd_out
);
wire signed [w-1:0] prev;
generate
    genvar k;
    reg signed [w-1:0] mem[0:m-1];
    assign prev=mem[m-1];
    for(k=0;k<m;k=k+1) begin : mem_gen
        always @(posedge clk)
            if(rst) begin
                mem[k] <= {w{1'b0}};
            end else if(cen) begin
                mem[k] <= k==0 ? snd_in : mem[k-1];
            end
    end
endgenerate
always @(posedge clk)
    if(rst) begin
        snd_out <= {w{1'b0}};
    end else if(cen) begin
        snd_out <= snd_in - prev;
    end
endmodule