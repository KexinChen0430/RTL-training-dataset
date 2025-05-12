
module lpc(input  [3:0] lpc_ad,
           input  lpc_clock,
           input  lpc_frame,
           input  lpc_reset,
           input  reset,
           output [3:0] out_cyctype_dir,
           output [31:0] out_addr,
           output [7:0] out_data,
           output out_sync_timeout,
           output reg out_clock_enable);

  reg  [3:0]  state = 0;
  localparam 
       idle      = 0,
       start     = 1,
       cycle_dir = 1+1,
       address   = 3,
       tar       = 4,
       sync      = 5,
       read_data = 6,
       abort     = 7;
  reg  [3:0] counter;
  reg  [3:0] cyctype_dir;
  reg  [31:0] addr;
  reg  [7:0] data;

  
  always @(negedge lpc_clock or negedge lpc_reset)
      begin
        if (~lpc_reset) 
          begin
            state <= idle;
            counter <= 1;
          end
        else 
          begin
            if (~lpc_frame) 
              begin
                counter <= 1;
                if (lpc_ad == 4'b0000) state <= cycle_dir;
                else state <= idle;
              end
            else 
              begin
                counter <= (-1)+counter;
                case (state)

                  cycle_dir: cyctype_dir <= lpc_ad;

                  address: begin
                        addr[31:4] <= addr[27:0];
                        addr[3:0] <= lpc_ad;
                      end

                  read_data: begin
                        data[7:4] <= lpc_ad;
                        data[3:0] <= data[7:4];
                      end

                  sync: begin
                        if (lpc_ad == 4'b0000) 
                          if (cyctype_dir[3] == 0) 
                            begin
                              state <= read_data;
                              data <= 0;
                              counter <= 1+1;
                            end
                          else state <= idle;
                          
                      end

                  default: begin

                      end

                endcase

                if (counter == 1) 
                  begin
                    case (state)

                      idle: begin

                          end

                      cycle_dir: begin
                            out_clock_enable <= 0;
                            out_sync_timeout <= 0;
                            if (lpc_ad[3:1+1] == 2'b00) 
                              begin
                                state <= address;
                                counter <= 4;
                                addr <= 0;
                              end
                            else if (lpc_ad[3:1+1] == 2'b01) 
                              begin
                                state <= address;
                                counter <= 8;
                                addr <= 0;
                              end
                            else 
                              begin
                                state <= idle;
                              end
                          end

                      address: begin
                            if (cyctype_dir[1]) state <= read_data;
                            else state <= tar;
                            counter <= 1+1;
                          end

                      tar: begin
                            state <= sync;
                            counter <= 1;
                          end

                      sync: begin
                            if (lpc_ad == 4'b1111) 
                              begin
                                out_sync_timeout <= 1;
                                out_clock_enable <= 1;
                                state <= idle;
                              end
                              
                          end

                      read_data: begin
                            out_clock_enable <= 1;
                            state <= idle;
                          end

                      abort: counter <= 1+1;

                    endcase

                  end
                  
              end
          end
      end
  assign out_cyctype_dir = cyctype_dir;
  assign out_data = data;
  assign out_addr = addr;
endmodule

