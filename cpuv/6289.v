module slave( 
  input wire reset_n, 
  input wire en, 
  input wire [6:0] my_addr, 
  input wire [7:0] measurement, 
  input wire scl, 
  inout wire sda 
  );