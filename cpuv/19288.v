module ThingMuxShort
  #(
    parameter NTHINGS = 1, 
    parameter       M = 5  
   )
   (
    input logic [NTHINGS-1:0] select_oh, 
    the_intf.t things_in [NTHINGS],      
    the_intf.i thing_out                  
    );
    assign thing_out.valid = things_in[0].valid;
endmodule 