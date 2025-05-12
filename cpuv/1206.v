module <module_name> (
);
parameter [?:0] fsm_pstate_enum; 
reg [?:0] fsm_pstate, next_state; 
reg [8*?:0] state_name; 
always @ (fsm_pstate) begin
    case (fsm_pstate)
        <IDLE>    : state_name = "IDLE";   
        <state2>  : state_name = "state2"; 
        <default> : state_name = "default"; 
    endcase
end
endmodule 