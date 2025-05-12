module SoftInt (i_wb_clk, i_wb_rst, i_wb_stb, i_wb_cyc, i_wb_we, i_wb_adr, i_wb_dat, o_wb_ack, o_wb_dat); 
input i_wb_clk; 
input i_wb_rst; 
input i_wb_stb; 
input i_wb_cyc; 
input i_wb_we;  
input [31:0] i_wb_adr; 
input [31:0] i_wb_dat; 
output o_wb_ack; 
output [31:0] o_wb_dat; 
`ifdef SIMULATION
always @(posedge i_wb_clk or posedge i_wb_rst) 
begin
    if (i_wb_rst) 
        o_wb_ack <= 1'b0; 
    else if (i_wb_stb && i_wb_cyc) 
        o_wb_ack <= 1'b1; 
end
`endif
`ifdef SIMULATION
always @(i_wb_adr) 
begin
    case (i_wb_adr[31:28]) 
        4'h0: 
            $write("Amber IC Register region 0");
        4'h1: 
            $write("Amber IC Register region 1");
        4'hE: 
            $write("Amber IC Register region 1 Clear");
        default: 
            begin
            $write(" unknown Amber IC Register region"); 
            $write(", Address 0x%08h\n", i_wb_adr); 
            `TB_ERROR_MESSAGE 
            end
    endcase
    $write(", Address 0x%08h\n", i_wb_adr); 
end
`endif
endmodule 