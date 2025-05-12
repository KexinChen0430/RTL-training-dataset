module my_module3 (
   my_if.slave_mp  in_i,  
   my_if.master_mp out_i 
   );
   assign out_i.valid  = in_i.valid;
   assign out_i.data   = in_i.data ;
endmodule