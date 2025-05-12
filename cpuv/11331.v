module bw_io_dtl_drv ( 
  pad,
  vddo,
  cbu, cbd, sel_data_n, pad_up, pad_dn_l, pad_dn25_l, por, bsr_up, bsr_dn_l,
  bsr_dn25_l
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
  inout 	vddo; 
  reg  pad_reg; 
  always @(por or sel_data_n or pad_up or pad_dn_l or pad_dn25_l or bsr_up or bsr_dn_l or bsr_dn25_l) begin 
    casez ({por, sel_data_n, pad_up, pad_dn_l,pad_dn25_l, bsr_up, bsr_dn_l, bsr_dn25_l}) 
      8'b1???????: pad_reg = 1'b1; 
      8'b00001???: pad_reg = 1'b0; 
      8'b00000???: pad_reg = 1'b0; 
      8'b00011???: pad_reg = 1'bz; 
      8'b00111???: pad_reg = 1'b1; 
      8'b01???001: pad_reg = 1'b0; 
      8'b01???000: pad_reg = 1'b0; 
      8'b01???011: pad_reg = 1'bz; 
      8'b01???111: pad_reg = 1'b1; 
      default:     pad_reg = 1'bx; 
      endcase
    end
  assign (pull1, strong0) #1 pad = pad_reg; 
  endmodule 