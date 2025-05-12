module outputs 
  wire [15 : 0] update; 
  wire RDY_update; 
  wire [31 : 0] update_x_PLUS_update_y_MUL_m_val___d2; 
  assign update = update_x_PLUS_update_y_MUL_m_val___d2[15:0] ; 
  assign RDY_update = 1'd1 ; 
  assign update_x_PLUS_update_y_MUL_m_val___d2 =
	     (update_x + update_y) * m_val ; 
endmodule 