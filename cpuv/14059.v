module modify_interface 
(
input logic value, 
intf.source intf_inst 
); 
assign intf_inst.logic_in_intf = value; 
endmodule 