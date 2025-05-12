module acl_atomics_arb_stall
#(
    parameter integer STALL_CYCLES = 6
)
(
    input logic clock,
    input logic resetn,
    acl_arb_intf in_intf,
    acl_arb_intf out_intf
);
reg shift_register [0:STALL_CYCLES-1];
wire atomic;
wire stall;
integer t;
assign out_intf.req.request = ( in_intf.req.request & ~stall ); 
assign out_intf.req.read = ( in_intf.req.read & ~stall ); 
assign out_intf.req.write = ( in_intf.req.write & ~stall ); 
assign out_intf.req.writedata = in_intf.req.writedata;
assign out_intf.req.burstcount = in_intf.req.burstcount;
assign out_intf.req.address = in_intf.req.address;
assign out_intf.req.byteenable = in_intf.req.byteenable;
assign out_intf.req.id = in_intf.req.id;
assign in_intf.stall = ( out_intf.stall | stall );
assign atomic = ( out_intf.req.request == 1'b1 &&
                  out_intf.req.read == 1'b1 &&
                  out_intf.req.writedata[0:0] == 1'b1 ) ? 1'b1 : 1'b0;
always@(posedge clock or negedge resetn)
begin
  if ( !resetn ) begin
    shift_register[0] <= 1'b0;
  end
  else begin
    shift_register[0] <= atomic;
  end
end
always@(posedge clock or negedge resetn)
begin
  for (t=1; t< STALL_CYCLES; t=t+1)
  begin
   if ( !resetn ) begin
     shift_register[t] <= 1'b0;
   end
   else begin
     shift_register[t] <= shift_register[t-1];
   end
  end
end
assign stall = ( shift_register[STALL_CYCLES-1] == 1'b1 );
endmodule