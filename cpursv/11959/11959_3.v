
module SystemDebugger(input  io_remote_cmd_valid,
                      output io_remote_cmd_ready,
                      input  io_remote_cmd_payload_last,
                      input  io_remote_cmd_payload_fragment,
                      output io_remote_rsp_valid,
                      input  io_remote_rsp_ready,
                      output io_remote_rsp_payload_error,
                      output [31:0] io_remote_rsp_payload_data,
                      output io_mem_cmd_valid,
                      input  io_mem_cmd_ready,
                      output [31:0] io_mem_cmd_payload_address,
                      output [31:0] io_mem_cmd_payload_data,
                      output io_mem_cmd_payload_wr,
                      output [1:0] io_mem_cmd_payload_size,
                      input  io_mem_rsp_valid,
                      input  [31:0] io_mem_rsp_payload,
                      input  io_mainClk,
                      input  resetCtrl_mainClkReset);

  wire _zz_2_;
  wire _zz_3_;
  reg  [66:0] dispatcher_dataShifter;
  reg  dispatcher_dataLoaded;
  reg  [7:0] dispatcher_headerShifter;
  wire [7:0] dispatcher_header;
  reg  dispatcher_headerLoaded;
  reg  [2:0] dispatcher_counter;
  wire [66:0] _zz_1_;

  assign _zz_2_ = dispatcher_headerLoaded == 1'b0;
  assign _zz_3_ = _zz_1_[64:64];
  assign dispatcher_header = dispatcher_headerShifter[7:0];
  assign io_remote_cmd_ready = !dispatcher_dataLoaded;
  assign _zz_1_ = dispatcher_dataShifter[66:0];
  assign io_mem_cmd_payload_address = _zz_1_[31:0];
  assign io_mem_cmd_payload_data = _zz_1_[63:32];
  assign io_mem_cmd_payload_wr = _zz_3_[0];
  assign io_mem_cmd_payload_size = _zz_1_[66:65];
  assign io_mem_cmd_valid = dispatcher_dataLoaded && 
                            (dispatcher_header == 8'b00000000);
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  
  always @(posedge io_mainClk or posedge resetCtrl_mainClkReset)
      begin
        if (resetCtrl_mainClkReset) 
          begin
            dispatcher_dataLoaded <= 1'b0;
            dispatcher_headerLoaded <= 1'b0;
            dispatcher_counter <= 3'b000;
          end
        else 
          begin
            if (io_remote_cmd_valid) 
              begin
                if (_zz_2_) 
                  begin
                    dispatcher_counter <= 3'b001+dispatcher_counter;
                    if (dispatcher_counter == 3'b111) 
                      begin
                        dispatcher_headerLoaded <= 1'b1;
                      end
                      
                  end
                  
                if (io_remote_cmd_payload_last) 
                  begin
                    dispatcher_headerLoaded <= 1'b1;
                    dispatcher_dataLoaded <= 1'b1;
                    dispatcher_counter <= 3'b000;
                  end
                  
              end
              
            if (io_mem_cmd_ready && io_mem_cmd_valid) 
              begin
                dispatcher_headerLoaded <= 1'b0;
                dispatcher_dataLoaded <= 1'b0;
              end
              
          end
      end
  
  always @(posedge io_mainClk)
      begin
        if (io_remote_cmd_valid) 
          begin
            if (_zz_2_) 
              begin
                dispatcher_headerShifter <= {io_remote_cmd_payload_fragment,dispatcher_headerShifter}>>>1;
              end
            else 
              begin
                dispatcher_dataShifter <= {io_remote_cmd_payload_fragment,dispatcher_dataShifter}>>>1;
              end
          end
          
      end
endmodule

