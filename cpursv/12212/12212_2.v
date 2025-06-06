
module i2c_simple(reset_n,clock,sda_in,scl);

  input  clock;
  input  reset_n;
  input  sda_in;
  input  scl;
  reg  start_bus_reg;
  reg  stop_bus_reg;
  wire sda_risingedge;
  wire scl_risingedge;
  wire sda_failingedge;
  wire scl_fallingedge;
  reg  curr,last;

  
  always @(posedge clock)
      begin
        if (!reset_n) 
          begin
            curr <= 1'b0;
            last <= 1'b0;
          end
        else 
          begin
            curr <= scl;
            last <= curr;
          end
      end
  assign scl_risingedge = ~last & curr;
  assign scl_fallingedge = last & ~curr;
  reg  sda_curr,sda_last;

  
  always @(posedge clock)
      begin
        if (!reset_n) 
          begin
            sda_curr <= 1'b0;
            sda_last <= 1'b0;
          end
        else 
          begin
            sda_curr <= sda_in;
            sda_last <= sda_curr;
          end
      end
  assign sda_risingedge = ~sda_last & sda_curr;
  assign sda_fallingedge = sda_last & ~sda_curr;
  
  always @(posedge clock)
      begin
        start_bus_reg <= scl & sda_fallingedge;
        stop_bus_reg <= scl & sda_risingedge;
      end
endmodule

