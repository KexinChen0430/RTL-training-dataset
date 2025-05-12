module REQCNTMG(input  wire                 CLK,
                input  wire                 RST,
                input  wire                 DRIVE,
                input  wire [`SORT_WAY-1:0] req,
                input  wire [`SORT_WAY-1:0] im_enq,
                input  wire [`SORT_WAY-1:0] im_emp,
                output reg                  reqcnt_a,
                output reg                  reqcnt_b,
                output reg                  reqcnt_c,
                output reg                  reqcnt_d);
  reg reqcnt_rsta;
  reg reqcnt_rstb;
  reg reqcnt_rstc;
  reg reqcnt_rstd;
  always @(posedge CLK) begin
    if (RST) begin
      {reqcnt_a, reqcnt_b, reqcnt_c, reqcnt_d} <= 0;
      {reqcnt_rsta, reqcnt_rstb, reqcnt_rstc, reqcnt_rstd} <= 0;
    end else begin
      if (DRIVE) begin
        case (req)
          4'h1: reqcnt_a <= 1;
          4'h2: reqcnt_b <= 1;
          4'h4: reqcnt_c <= 1;
          4'h8: reqcnt_d <= 1;
        endcase
      end
      if (|im_enq) begin
        case (im_enq)
          4'h1: begin
            reqcnt_rsta <= 1;
            {reqcnt_rstb, reqcnt_rstc, reqcnt_rstd} <= 0;
          end
          4'h2: begin
            reqcnt_rstb <= 1;
            {reqcnt_rsta, reqcnt_rstc, reqcnt_rstd} <= 0;
          end
          4'h4: begin
            reqcnt_rstc <= 1;
            {reqcnt_rsta, reqcnt_rstb, reqcnt_rstd} <= 0;
          end
          4'h8: begin
            reqcnt_rstd <= 1;
            {reqcnt_rsta, reqcnt_rstb, reqcnt_rstc} <= 0;
          end
        endcase
      end else begin
        if (reqcnt_rsta && im_emp[0]) reqcnt_rsta <= 0;
        if (reqcnt_rstb && im_emp[1]) reqcnt_rstb <= 0;
        if (reqcnt_rstc && im_emp[2]) reqcnt_rstc <= 0;
        if (reqcnt_rstd && im_emp[3]) reqcnt_rstd <= 0;
      end
      if (reqcnt_rsta && ((|im_enq[`SORT_WAY-1:1])                || im_emp[0])) reqcnt_a <= 0;
      if (reqcnt_rstb && ((|{im_enq[`SORT_WAY-1:2], im_enq[0]})   || im_emp[1])) reqcnt_b <= 0;
      if (reqcnt_rstc && ((|{im_enq[`SORT_WAY-1:3], im_enq[1:0]}) || im_emp[2])) reqcnt_c <= 0;
      if (reqcnt_rstd && ((|im_enq[`SORT_WAY-2:0])                || im_emp[3])) reqcnt_d <= 0;
    end
  end
endmodule