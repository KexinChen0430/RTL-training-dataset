
module BusArbiter  #(parameter  bus_width = 32, bus_max_devices = 16)
  (input  clk,
   inout  [bus_width-1:0] data_lines,
   inout  [bus_max_devices+(-1):0] receiver_device,
   inout  [bus_max_devices+(-1):0] buffer_full,
   input  [bus_max_devices+(-1):0] write_request,
   output reg [bus_max_devices+(-1):0] voice);

  reg  [bus_max_devices+(-1):0]  operating_device = 0;

  
  generate
      genvar device;
      for (device = 1; device < bus_max_devices; device = device+1)
          begin : voice_gen
            
            always @(negedge clk)
                if (~write_request[operating_device] || !operating_device) 
                  begin
                    voice[device] = write_request[device] && !write_request[device+(-1):0];
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

