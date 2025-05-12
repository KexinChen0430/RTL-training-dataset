module testit; 
   reg       clk; 
   reg       a_i; 
   reg       b_i; 
   reg       a_o; 
   reg       b_o; 
   reg       rst_n; 
   reg [7:0] shreg; 
   parameter [2:0] 
     SM_IDLE  = 3'b000, 
     SM_SEND  = 3'b001, 
     SM_WAIT1 = 3'b010; 
   reg [2:0]  
              state_r;  
   reg [2:0]  
              state_e1; 
   reg [39:0] _stateascii_r; 
   always @(state_r) begin
      case ({state_r})
        SM_IDLE:  _stateascii_r = "idle "; 
        SM_SEND:  _stateascii_r = "send "; 
        SM_WAIT1: _stateascii_r = "wait1"; 
        default:  _stateascii_r = "%Erro"; 
      endcase
   end
   initial begin
      clk       = 0;
      a_i       = 0;
      b_i       = 0;
      rst_n     = 0;
      #20 rst_n = 1; 
   end
   always #5 clk = ~clk;
   always @(posedge clk or rst_n) begin
      if (~rst_n) begin 
         a_o   <= 0;
         b_o   <= 0;
         shreg <= 8'b00110011; 
      end
      else begin 
         a_o   <= a_i; 
         b_o   <= b_i; 
         shreg <= {shreg[6:0], shreg[7]}; 
      end
   end
   task set_a_i;
      begin
         a_i = shreg[0];
      end
   endtask 
   always @(shreg & a_o) begin
      set_a_i; 
   end
   initial begin
      $vcdpluson;
      #500 $finish;
   end
endmodule