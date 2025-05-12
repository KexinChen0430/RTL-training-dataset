module REQCNTMG(
    input  wire                 CLK,     
    input  wire                 RST,     
    input  wire                 DRIVE,   
    input  wire [`SORT_WAY-1:0] req,     
    input  wire [`SORT_WAY-1:0] im_enq,  
    input  wire [`SORT_WAY-1:0] im_emp,  
    output reg                  reqcnt_a, 
    output reg                  reqcnt_b, 
    output reg                  reqcnt_c, 
    output reg                  reqcnt_d, 
    output reg                  reqcnt_e, 
    output reg                  reqcnt_f, 
    output reg                  reqcnt_g, 
    output reg                  reqcnt_h  
);
reg reqcnt_rsta;
reg reqcnt_rstb;
reg reqcnt_rstc;
reg reqcnt_rstd;
reg reqcnt_rste;
reg reqcnt_rstf;
reg reqcnt_rstg;
reg reqcnt_rsth;
always @(posedge CLK) begin
    if (RST) begin
        {reqcnt_a, reqcnt_b, reqcnt_c, reqcnt_d, reqcnt_e, reqcnt_f, reqcnt_g, reqcnt_h} <= 0;
        {reqcnt_rsta, reqcnt_rstb, reqcnt_rstc, reqcnt_rstd, reqcnt_rste, reqcnt_rstf, reqcnt_rstg, reqcnt_rsth} <= 0;
    end else begin
        if (DRIVE) begin
            case (req)
                8'h01: reqcnt_a <= 1;
                8'h02: reqcnt_b <= 1;
                8'h04: reqcnt_c <= 1;
                8'h08: reqcnt_d <= 1;
                8'h10: reqcnt_e <= 1;
                8'h20: reqcnt_f <= 1;
                8'h40: reqcnt_g <= 1;
                8'h80: reqcnt_h <= 1;
            endcase
        end
        if (|im_enq) begin
            case (im_enq)
                8'h01: begin
                    reqcnt_rsta <= 1;
                    {reqcnt_rstb, reqcnt_rstc, reqcnt_rstd, reqcnt_rste, reqcnt_rstf, reqcnt_rstg, reqcnt_rsth} <= 0;
                end
            endcase
        end else begin
            if (reqcnt_rsta && im_emp[0]) reqcnt_rsta <= 0;
        end
        if (reqcnt_rsta && ((|im_enq[`SORT_WAY-1:1])                || im_emp[0])) reqcnt_a <= 0;
    end
end
endmodule