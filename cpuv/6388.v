module outputs
  wire [1 : 0] gen_grant_carry;
  assign gen_grant_carry =
	     { gen_grant_carry_r && (gen_grant_carry_c || gen_grant_carry_p),
	       !gen_grant_carry_r &&
	       (gen_grant_carry_c || gen_grant_carry_p) } ;
endmodule