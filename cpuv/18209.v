module acl_ic_wrp_reg
(
  input logic clock, 
  input logic resetn, 
  acl_ic_wrp_intf wrp_in, 
  (* dont_merge, altera_attribute = "-name auto_shift_register_recognition OFF" *) acl_ic_wrp_intf wrp_out
);
  always @(posedge clock or negedge resetn)
    if( ~resetn ) begin 
      wrp_out.ack <= 1'b0; 
      wrp_out.id <= 'x; 
    end
    else begin 
      wrp_out.ack <= wrp_in.ack; 
      wrp_out.id <= wrp_in.id; 
    end
endmodule