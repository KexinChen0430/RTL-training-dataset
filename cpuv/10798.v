module recon_timer (
  input [2:0] address, 
  input chipselect, 
  input clk, 
  input reset_n, 
  input write, 
  input read, 
  input [31:0] writedata, 
  output [31:0] readdata, 
  output irq, 
  output reg microsec_tick, 
  output reg millisec_tick, 
  output reg second_tick 
);
  parameter CLK_FREQ = 50000000; 
  parameter MILLISEC = CLK_FREQ/1000-1; 
  parameter MICROSEC = CLK_FREQ/1000000-1; 
  wire [31:0] readdata; 
  reg [31:0] read_mux_reg; 
  reg [9:0] microsec; 
  reg [31:0] millisec; 
  reg [31:0] next_millisec; 
  reg [31:0] second; 
  reg [3:0] ctrl_reg; 
  reg [31:0] irq_timer; 
  reg [31:0] irq_time; 
  reg [9:0] timer; 
  reg irq_active; 
  reg irq_active_d; 
  reg irq_pulse; 
  always@(posedge clk) 
  begin
    if (chipselect && read) 
      case(address) 
      `MILLISEC_OFFSET    : read_mux_reg <= millisec; 
      `SECOND_OFFSET      : read_mux_reg <= second; 
      `IRQ_TIME_OFFSET    : read_mux_reg <= irq_time; 
      `CTRL_OFFSET        : read_mux_reg <= {28'h0, ctrl_reg}; 
      `IRQ_STATUS_OFFSET  : read_mux_reg <= {31'h0, irq_pulse}; 
      default             : read_mux_reg <= 32'h0; 
      endcase
  end
  assign readdata = read_mux_reg; 
  always@(posedge clk or negedge reset_n) 
    if (~reset_n) begin 
      millisec <= 0; 
      second   <= 0; 
      next_millisec <= 999; 
      microsec_tick <= 1'b0; 
      millisec_tick <= 1'b0; 
      second_tick   <= 1'b0; 
    end else begin
      timer <= timer + 1; 
      millisec_tick <= 1'b0; 
      second_tick   <= 1'b0; 
      microsec_tick <= 1'b0; 
      if (timer == MICROSEC) begin 
        timer    <= 0; 
        microsec <= microsec + 1; 
        microsec_tick <= 1'b1; 
        if (microsec == 999) begin 
          microsec <= 0; 
          millisec <= millisec + 1; 
          millisec_tick <= 1'b1; 
          if (millisec == next_millisec) begin 
              second   <= second+1; 
              next_millisec <= next_millisec + 1000; 
              second_tick <= 1'b1; 
            end
          end
      end
      if (chipselect && write && address==`CTRL_OFFSET) 
        ctrl_reg     <= writedata; 
      if (chipselect && write && address==`IRQ_TIME_OFFSET) 
        irq_time <= writedata; 
      if (irq_active) 
        irq_pulse <= 1'b1; 
      else if (chipselect && write && address == `IRQ_STATUS_OFFSET && writedata[0]==1'b1) 
        irq_pulse <= 1'b0; 
      irq_active <= 1'b0; 
      if (ctrl_reg[`IRQ_COUNTDOWN_ENA_BIT]==1'b1) begin 
        if (millisec_tick == 1'b1) begin 
          irq_timer <= irq_timer + 1; 
          if (irq_timer == irq_time) begin 
            irq_active <= 1'b1; 
            if (ctrl_reg[`IRQ_TIMER_CONTINUOUS_BIT]==1'b1) begin 
              irq_timer <= 0; 
            end
          end
        end
      end else
        if (ctrl_reg[`IRQ_TIMER_MATCH_ENA_BIT]==1'b1) begin 
          if (millisec == irq_time) begin 
            irq_active <= 1'b1; 
        end
      end
    end
    assign irq = irq_pulse; 
endmodule