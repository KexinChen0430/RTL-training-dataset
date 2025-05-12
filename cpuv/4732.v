module font5_vio
  (
    control,
    async_in,
    async_out
  );
  input  [35:0] control;   
  input  [127:0] async_in; 
  output [127:0] async_out; 
endmodule