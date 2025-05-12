
module pixelq_op_OUTPUT_STREAM_reg_slice  #(parameter  N = 8)
  (input  wire clk,
   input  wire reset,
   input  wire [(0-1)+N:0] s_data,
   input  wire s_valid,
   output wire s_ready,
   output wire [(0-1)+N:0] m_data,
   output wire m_valid,
   input  wire m_ready);

  localparam [1:0]  ZERO = 2'b10, ONE = 2'b11, TWO = 2'b01;
  reg  [(0-1)+N:0] data_p1;
  reg  [(0-1)+N:0] data_p2;
  wire load_p1;
  wire load_p2;
  wire load_p1_from_p2;
  reg  s_ready_t;
  reg  [1:0] state;
  reg  [1:0] next;

  assign s_ready = s_ready_t;
  assign m_data = data_p1;
  assign m_valid = state[0];
  assign load_p1 = 
((((state == TWO) && m_ready) || (state == ONE)) && 
m_ready && s_valid) || ((state == TWO) && m_ready) || 
                   ((state == ZERO) && 
(s_valid || 
((((state == TWO) && m_ready) || (state == ONE)) && 
m_ready && s_valid) || ((state == TWO) && m_ready)));
  assign load_p2 = s_ready & s_valid;
  assign load_p1_from_p2 = state == TWO;
  
  always @(posedge clk)
      begin
        if (load_p1) 
          begin
            if (load_p1_from_p2) data_p1 <= data_p2;
            else data_p1 <= s_data;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (load_p2) data_p2 <= s_data;
          
      end
  
  always @(posedge clk)
      begin
        if (~reset) s_ready_t <= 1'b0;
        else if (state == ZERO) s_ready_t <= 1'b1;
        else if ((next == TWO) && (state == ONE)) s_ready_t <= 1'b0;
        else if ((state == TWO) && (next == ONE)) s_ready_t <= 1'b1;
          
      end
  
  always @(posedge clk)
      begin
        if (~reset) state <= ZERO;
        else state <= next;
      end
  
  always @(*)
      begin
        case (state)

          ZERO: if (s_ready & s_valid) next = ONE;
              else next = ZERO;

          ONE: if (m_ready & ~s_valid) next = ZERO;
              else if (s_valid & ~m_ready) next = TWO;
              else next = ONE;

          TWO: if (m_ready) next = ONE;
              else next = TWO;

          default: next = ZERO;

        endcase

      end
endmodule

