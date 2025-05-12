module moore_fsm (
  input wire clk,                
  input wire rst,                
  input wire i_input,            
  output reg o_output,           
  output wire [2:0] o_current_state, 
  output wire [2:0] o_next_state      
);
  reg [2:0] current_state;
  reg [2:0] next_state;
  localparam  i_val_a = 1'b0; 
  localparam  i_val_b = 1'b1; 
  localparam  STATE_U = 3'b000;
  localparam  STATE_V = 3'b001;
  localparam  STATE_W = 3'b010;
  localparam  STATE_X = 3'b011;
  localparam  STATE_Y = 3'b100;
  localparam  STATE_Z = 3'b101;
  always @ (posedge clk, posedge rst) begin
    if (rst == 1'b1) begin
      current_state <= STATE_U;
    end else begin
      current_state <= next_state;
    end
  end
  assign o_current_state = current_state;
  assign o_next_state = next_state;
  always @ (*) begin
    case (current_state)
      STATE_U: begin
        next_state = (i_input == i_val_a) ? STATE_Z : STATE_W;
      end
      STATE_V: begin
        next_state = (i_input == i_val_a) ? STATE_Z : STATE_W;
      end
      STATE_W: begin
        next_state = (i_input == i_val_a) ? STATE_X : STATE_U;
      end
      STATE_X: begin
        next_state = (i_input == i_val_a) ? STATE_Y : STATE_X;
      end
      STATE_Y: begin
        next_state = (i_input == i_val_a) ? STATE_V : STATE_Y;
      end
      STATE_Z: begin
        next_state = (i_input == i_val_a) ? STATE_Y : STATE_X;
      end
      default: begin
        next_state = STATE_U;
      end
    endcase
  end
  always @ (*) begin
    case (current_state)
      STATE_U:  begin
        o_output = 1'b1; 
      end
      STATE_V:  begin
        o_output = 1'b0; 
      end
      STATE_W:  begin
        o_output = 1'b0; 
      end
      STATE_X:  begin
        o_output = 1'b0; 
      end
      STATE_Y:  begin
        o_output = 1'b1; 
      end
      STATE_Z:  begin
        o_output = 1'b1; 
      end
      default:   begin
        o_output = 1'b0;
      end
    endcase
  end
endmodule