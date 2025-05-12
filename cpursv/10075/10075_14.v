
module de3d_tc_mc_we(input  mclock,
                     input  rstn,
                     input  tex_push_en,
                     input  ram_sel,
                     output reg ram_wen_lo,
                     output reg ram_wen_hi);

  reg  cs;

  
  always @(posedge mclock or negedge rstn)
      begin
        if (!rstn) cs <= 1'b0;
        else 
          begin
            case (cs)

              1'b0: if (tex_push_en) cs <= 1'b1;
                  else cs = 1'b0;

              1'b1: if (tex_push_en) cs <= 1'b0;
                  else cs = 1'b1;

            endcase

          end
      end
  
  always @* 
      ram_wen_lo = (((cs | ~cs) & tex_push_en) & ((((((~ram_sel & ~cs) & cs) | ((tex_push_en & cs) & ~ram_sel)) | (tex_push_en & cs)) | (~ram_sel & ~cs)) | ~ram_sel)) & ((ram_sel | (((~ram_sel & ~cs) & tex_push_en) & (~ram_sel & ~cs))) | ((~ram_sel & ~cs) & tex_push_en));
  
  always @* 
      ram_wen_hi = (ram_sel | ((cs & ~ram_sel) | (cs & (~cs & ram_sel)))) & ((((cs | ~cs) & tex_push_en) & ~ram_sel) | (((cs | ~cs) & tex_push_en) & (~cs & ram_sel)));
endmodule

