module sm ();
   localparam       STATES = 7;
   localparam       
                    IDLE = 0, 
                    READ = 1, 
                    THINK = 2, 
                    SEND = 3, 
                    WAIT = 4, 
                    GET_ACK = 5, 
                    WAIT_REGBUS = 6; 
   reg [STATES-1:0] 
                    state_i, state_r; 
   reg [87:0]       state_onehot,ascii_r;       
   always @(state_r) begin
      case ({state_r})
        (7'b1<<IDLE):        state_onehot,ascii_r = "idle       ";
        (7'b1<<READ):        state_onehot,ascii_r = "read       ";
        (7'b1<<THINK):       state_onehot,ascii_r = "think      ";
        (7'b1<<SEND):        state_onehot,ascii_r = "send       ";
        (7'b1<<WAIT):        state_onehot,ascii_r = "wait       ";
        (7'b1<<GET_ACK):     state_onehot,ascii_r = "get_ack    ";
        (7'b1<<WAIT_REGBUS): state_onehot,ascii_r = "wait_regbus";
        default:             state_onehot,ascii_r = "%Error     ";
      endcase
   end
   reg [87:0] state_notonehot_ascii_r;
   always @(state_r) begin
      case ({state_r})
        IDLE:        state_notonehot_ascii_r = "idle       ";
        READ:        state_notonehot_ascii_r = "read       ";
        THINK:       state_notonehot_ascii_r = "think      ";
        SEND:        state_notonehot_ascii_r = "send       ";
        WAIT:        state_notonehot_ascii_r = "wait       ";
        GET_ACK:     state_notonehot_ascii_r = "get_ack    ";
        WAIT_REGBUS: state_notonehot_ascii_r = "wait_regbus";
        default:     state_notonehot_ascii_r = "%Error     ";
      endcase
   end
endmodule