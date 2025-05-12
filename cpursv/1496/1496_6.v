
module BusArbiter  #(parameter  bus_width = 32, bus_max_devices = 16)
  (input  clk,
   inout  [bus_width+(0-1):0] data_lines,
   inout  [(0-1)+bus_max_devices:0] receiver_device,
   inout  [(0-1)+bus_max_devices:0] buffer_full,
   input  [(0-1)+bus_max_devices:0] write_request,
   output reg [(0-1)+bus_max_devices:0] voice);

  reg  [(0-1)+bus_max_devices:0]  operating_device = 0;

  
  generate
      genvar device;
      for (device = 1; device < bus_max_devices; device = 1+device)
          begin : voice_gen
            
            always @(negedge clk)
                if (!operating_device || ~write_request[operating_device]) 
                  begin
                    voice[device] = write_request[device] && !write_request[device-1:0];
                    operating_device = voice;
                  end
                  
          end
  endgenerate

  
  always @(clk)
      begin
        if (clk) 
          $display("BusArbiter: + posedge clk on bus");
        else 
          $display("BusArbiter: - negedge clk on bus");
        $display("BusArbiter: bus_data_lines: %b",data_lines);
        $display("BusArbiter: bus_receiver_device: %b",
                 receiver_device);
        $display("BusArbiter: bus_buffer_full: %b",buffer_full);
        $display("BusArbiter: bus_write_request: %b",write_request);
        $display("BusArbiter: bus_voice: %b",voice);
        $display("BusArbiter: operating_device: %b",operating_device);
      end
endmodule

