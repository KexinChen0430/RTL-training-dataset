module mul32(
    input  [31 : 0] iSOURCE0, 
    input  [31 : 0] iSOURCE1, 
    output [63 : 0] oDATA,    
    output          oHSF,     
    output          oHOF,     
    output          oHCF,     
    output          oHPF,     
    output          oHZF,     
    output          oLSF,     
    output          oLOF,     
    output          oLCF,     
    output          oLPF,     
    output          oLZF      
);
wire [63:0] w_tmp_out;
assign w_tmp_out = ((iSOURCE0[0])  ? iSOURCE1 << 0  : 64'h00) +
                   ((iSOURCE0[1])  ? iSOURCE1 << 1  : 64'h00) +
                   ((iSOURCE0[31]) ? iSOURCE1 << 31 : 64'h00);
assign oDATA = w_tmp_out;
assign oHSF = w_tmp_out[31];
assign oHOF = w_tmp_out[32] ^ w_tmp_out[31];
assign oHCF = w_tmp_out[32];
assign oHPF = w_tmp_out[0];
assign oHZF = (w_tmp_out[32:0] == {33{1'b0}}) ? 1'b1 : 1'b0;
assign oLSF = w_tmp_out[32];
assign oLOF = w_tmp_out[63];
assign oLCF = 1'b0;
assign oLPF = w_tmp_out[32];
assign oLZF = (w_tmp_out == {64{1'b0}}) ? 1'b1 : 1'b0;
endmodule