module acl_ic_rrp_reg
(
  input logic clock, 
  input logic resetn, 
  acl_ic_rrp_intf rrp_in, 
  (* dont_merge, altera_attribute = "-name auto_shift_register_recognition OFF" *) acl_ic_rrp_intf rrp_out
);
  always @(posedge clock or negedge resetn)
    if( ~resetn ) begin 
      rrp_out.datavalid <= 1'b0; 
      rrp_out.id <= 'x; 
      rrp_out.data <= 'x; 
    end
    else begin 
      rrp_out.datavalid <= rrp_in.datavalid; 
      rrp_out.id <= rrp_in.id; 
      rrp_out.data <= rrp_in.data; 
    end
endmodule