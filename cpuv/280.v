module par_packed;
   parameter logic [31:0] P1 [3:0] = '{ 1, 2, 3, 4 } ; 
   wire struct packed { logic ecc; logic [7:0] data; } memsig;
endmodule 