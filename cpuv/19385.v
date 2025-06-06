module sub (
   pad_io_h, pad_io_l
   );
   parameter USE = 1'b1;
   parameter DIFFERENTIAL = 1'b1;
   parameter BIDIR = 1'b1;
   inout pad_io_h;
   inout pad_io_l;
   wire [31:0] dqs_out_dtap_delay;
   generate
      if (USE) begin: output_strobe
         wire aligned_os_oe;
         wire aligned_strobe;
         if (BIDIR) begin
            reg sig_h_r = 1'b0;
            reg sig_l_r = 1'b0;
            always @* begin
               sig_h_r = ~aligned_os_oe ? aligned_strobe : 1'bz;
               if (DIFFERENTIAL)
                 sig_l_r = ~aligned_os_oe ? ~aligned_strobe : 1'bz;
            end
            assign pad_io_h = sig_h_r;
            if (DIFFERENTIAL)
              assign pad_io_l = sig_l_r;
         end
      end
   endgenerate
endmodule