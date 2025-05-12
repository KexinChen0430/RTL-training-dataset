module pdp1_sbs(
   input i_clk,           
   input i_rst,           
   output reg sb_ireq,    
   input sb_dne,          
   input pb_att,          
   input [0:10] pb_op,    
   output [0:5] pb_sqb,   
   input tr_lp,           
   input tr_ptr,          
   input tr_tyo,          
   input tr_tyi,          
   input tr_tp,           
   input tr_drm           
);
reg r_en;
wire w_tr_any;
assign pb_sqb = {tr_lp, tr_ptr, tr_tyo, tr_tyi, tr_tp, tr_drm, r_en};
assign w_tr_any = (|pb_sqb[0:4]);
always @(posedge i_clk) begin
   if(i_rst) begin
      sb_ireq <= 1'b0;
      r_en <= 1'b0;
   end
   else begin
      if(pb_att) begin
         case(pb_op)
            `PDP1_SBS_ESM: 
               r_en <= 1'b1;
            `PDP1_SBS_LSM: 
               r_en <= 1'b0;
            `PDP1_SBS_CBS: 
               sb_ireq <= 1'b0;
         endcase 
      end
      else begin
         if(w_tr_any & ~sb_dne)
            sb_ireq <= 1'b1;
         else if(sb_dne & sb_ireq)
            sb_ireq <= 1'b0;
      end
   end
end
endmodule