module bw_io_dtl_drv_zctl ( 
  pad, 
  cbu, cbd, sel_data_n, pad_up, pad_dn_l, pad_dn25_l, por, bsr_up, bsr_dn_l,
  bsr_dn25_l, vddo 
  );
  output	pad; 
  input   [8:1] cbu; 
  input   [8:1] cbd; 
  input 	sel_data_n; 
  input 	pad_up; 
  input 	pad_dn_l; 
  input 	pad_dn25_l; 
  input 	por; 
  input 	bsr_up; 
  input 	bsr_dn_l; 
  input 	bsr_dn25_l; 
  input 	vddo; 
  reg  pad_reg; 
  always @(por or sel_data_n or pad_up or pad_dn_l or pad_dn25_l or bsr_up or bsr_dn_l or bsr_dn25_l) begin 
    casex ({por, sel_data_n, pad_up, pad_dn_l,pad_dn25_l, bsr_up, bsr_dn_l, bsr_dn25_l}) 
      8'b1xxxxxxx: pad_reg = 1'bz; 
      8'b00001xxx: pad_reg = 1'b0; 
      8'b00000xxx: pad_reg = 1'b0; 
      8'b00011xxx: pad_reg = 1'bz; 
      8'b00111xxx: pad_reg = 1'b1; 
      8'b01xxx001: pad_reg = 1'b0; 
      8'b01xxx000: pad_reg = 1'b0; 
      8'b01xxx011: pad_reg = 1'bz; 
      8'b01xxx111: pad_reg = 1'b1; 
      default:     pad_reg = 1'bx; 
      endcase
    end
  assign (pull1, strong0) #1 pad = pad_reg; 
  endmodule 