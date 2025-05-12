module my_module2 (
    my_if.slave_mp  in_i,   
    my_if.master_mp out_i   
);
always_comb
  begin
     out_i.valid = '0;       
     out_i.data  = 'X;       
     out_i.valid = in_i.valid; 
     out_i.data  = in_i.data;  
  end
endmodule 